#This function finds any AppX/AppXProvisioned package and uninstalls it, except for Freshpaint, Windows Calculator, Windows Store, and Windows Photos.
#Also, to note - This does NOT remove essential system services/software/etc such as .NET framework installations, Cortana, Edge, etc.

#This is the switch parameter for running this script as a 'silent' script, for use in MDT images or any type of mass deployment without user interaction.

$ErrorActionPreference = 'SilentlyContinue'

param (
    [switch]$DebloatAllApps, [switch]$DebloatSpecificApps, [switch]$SysPrep, [switch]$StopEdgePDF, [Switch]$Privacy
)

Function Begin-SysPrep {

    [CmdletBinding()]
    param([switch]$SysPrep)
    Write-Verbose -Message ('Starting Sysprep Fixes')
 
    # Disable Windows Store Automatic Updates
    Write-Verbose -Message "Adding Registry key to Disable Windows Store Automatic Updates"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
    If (!(Test-Path $registryPath)) {
        Mkdir $registryPath -ErrorAction SilentlyContinue
        New-ItemProperty $registryPath -Name AutoDownload -Value 2 
    }
    Else {
        Set-ItemProperty $registryPath -Name AutoDownload -Value 2 
    }
    # Disable Microsoft Consumer Experience
    Write-Verbose -Message "Adding Registry key to prevent bloatware apps from returning"
    #Prevents bloatware applications from returning
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    If (!(Test-Path $registryPath)) {
        Mkdir $registryPath -ErrorAction SilentlyContinue
        New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 
    }
    Else {
        Set-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 
    }
    #Stop WindowsStore Installer Service and set to Disabled
    Write-Verbose -Message ('Stopping InstallService')
    Stop-Service InstallService
    Write-Verbose -Message ('Setting InstallService Startup to Disabled')
    & sc config InstallService start=disabled
}


Function DebloatAll {

    param([switch]$DebloatAllApps)
            
    #Removes AppxPackages
    #Credit to Reddit user /u/GavinEke for a modified version of my whitelist code
    Write-Verbose -Message ('Starting Debloat')
    [regex]$WhitelistedApps = 'Microsoft.Paint3D|Microsoft.MSPaint|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows'
    Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    
}

Function DebloatBlacklist {
    [CmdletBinding()]

    Param ([switch]$DebloatSpecificApps)

    $Bloatware = @(

        #Unnecessary Windows 10 AppX Apps
        "Microsoft.BingNews"
        "Microsoft.DesktopAppInstaller"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.Office.OneNote"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.RemoteDesktop"
        "Microsoft.SkypeApp"
        "Microsoft.StorePurchaseApp"
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
             
        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "EclipseManager"
        "ActiproSoftwareLLC"
        "AdobeSystemsIncorporated.AdobePhotoshopExpress"
        "Duolingo-LearnLanguagesforFree"
        "PandoraMediaInc"
        "CandyCrush"
        "Wunderlist"
        "Flipboard"
        "Twitter"
        "Facebook"
        "Spotify"
        "Minecraft"
        "Royal Revolt"
             
        #Optional: Typically not removed but you can if you need to for some reason
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
        #"*Microsoft.BingWeather*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        #"*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        Write-Output "Trying to remove $Bloat."
    }
}
Function Remove-Keys {

    Param([switch]$DebloatAllApps, [switch]$DebloatSpecificApps)
    
    #Creates a PSDrive to be able to access the 'HKCR' tree
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    #These are the registry keys that it will delete.

    $Keys = @(

        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"

        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"

        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )

    #This writes the output of each key it is removing and also removes the keys listed above.
    ForEach ($Key in $Keys) {
        Write-Output "Removing $Key from registry"
        Remove-Item $Key -Recurse -ErrorAction SilentlyContinue
    }
}

Function Protect-Privacy {

    Param([switch]$Privacy)

    Write-Verbose -Message ('Starting Protect Privacy')
    #Creates a PSDrive to be able to access the 'HKCR' tree
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

    #Disables Windows Feedback Experience
    Write-Output "Disabling Windows Feedback Experience program"
    $Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising -Name Enabled -Value 0 -Verbose
    }

    #Stops Cortana from being used as part of your Windows Search Function
    Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
    $Search = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
    If (Test-Path $Search) {
        Set-ItemProperty $Search -Name AllowCortana -Value 0 -Verbose
    }

    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "Stopping the Windows Feedback Experience program"
    $Period1 = 'HKCU:\Software\Microsoft\Siuf'
    $Period2 = 'HKCU:\Software\Microsoft\Siuf\Rules'
    $Period3 = 'HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds'
    If (!(Test-Path $Period3)) {
        mkdir $Period1 -ErrorAction SilentlyContinue
        mkdir $Period2 -ErrorAction SilentlyContinue
        mkdir $Period3 -ErrorAction SilentlyContinue
        New-ItemProperty $Period3 -Name PeriodInNanoSeconds -Value 0 -Verbose -ErrorAction SilentlyContinue
    }

    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    #Prevents bloatware applications from returning
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    If (!(Test-Path $registryPath)) {
        Mkdir $registryPath -ErrorAction SilentlyContinue
        New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 -Verbose -ErrorAction SilentlyContinue
    }

    Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
    $Holo = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic'
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo -Name FirstRunSucceeded -Value 0 -Verbose
    }

    #Disables live tiles
    Write-Output "Disabling live tiles"
    $Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'
    If (!(Test-Path $Live)) {
        mkdir $Live -ErrorAction SilentlyContinue
        New-ItemProperty $Live -Name NoTileApplicationNotification -Value 1 -Verbose
    }

    #Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Output "Turning off Data Collection"
    $DataCollection = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection'
    If (Test-Path $DataCollection) {
        Set-ItemProperty $DataCollection -Name AllowTelemetry -Value 0 -Verbose
    }

    #Disables People icon on Taskbar
    Write-Output "Disabling People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (!(Test-Path $People)) {
        mkdir $People -ErrorAction SilentlyContinue
        New-ItemProperty $People -Name PeopleBand -Value 0 -Verbose
    }

    #Disables suggestions on start menu
    Write-Output "Disabling suggestions on the Start Menu"
    $Suggestions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
    If (Test-Path $Suggestions) {
        Set-ItemProperty $Suggestions -Name SystemPaneSuggestionsEnabled -Value 0 -Verbose
    }

    #Loads the registry keys/values below into the NTUSER.DAT file which prevents the apps from redownloading. Credit to a60wattfish
    reg load HKU\Default_User C:\Users\Default\NTUSER.DAT
    Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SystemPaneSuggestionsEnabled -Value 0
    Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name PreInstalledAppsEnabled -Value 0
    Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name OemPreInstalledAppsEnabled -Value 0
    reg unload HKU\Default_User

    #Disables scheduled tasks that are considered unnecessary
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Disable-ScheduledTask -ErrorAction SilentlyContinue
    Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask -ErrorAction SilentlyContinue
    Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask -ErrorAction SilentlyContinue
    Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask -ErrorAction SilentlyContinue
    Get-ScheduledTask -TaskName DmClient | Disable-ScheduledTask -ErrorAction SilentlyContinue
    Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Disable-ScheduledTask -ErrorAction SilentlyContinue
}

Function Stop-EdgePDF {

    param([switch]$StopEdgePDF)
    
    Write-Verbose -Message ('Starting StopEdge PDF')
    #Stops edge from taking over as the default .PDF viewer
    Write-Output "Stopping Edge from taking over as the default .PDF viewer"
    $NoOpen = 'HKCR:\.pdf'
    If (!(Get-ItemProperty $NoOpen -Name NoOpenWith)) {
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose -ErrorAction SilentlyContinue
    }

    $NoStatic = 'HKCR:\.pdf'
    If (!(Get-ItemProperty $NoStatic -Name NoStaticDefaultVerb)) {
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose -ErrorAction SilentlyContinue
    }

    $NoOpen = 'HKCR:\.pdf\OpenWithProgids'
    If (!(Get-ItemProperty $NoOpen -Name NoOpenWith)) {
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose -ErrorAction SilentlyContinue
    }

    $NoStatic = 'HKCR:\.pdf\OpenWithProgids'
    If (!(Get-ItemProperty $NoStatic -Name NoStaticDefaultVerb)) {
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose -ErrorAction SilentlyContinue
    }

    $NoOpen = 'HKCR:\.pdf\OpenWithList'
    If (!(Get-ItemProperty $NoOpen -Name NoOpenWith)) {
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose -ErrorAction SilentlyContinue
    }

    $NoStatic = 'HKCR:\.pdf\OpenWithList'
    If (!(Get-ItemProperty $NoStatic -Name NoStaticDefaultVerb)) {
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose -ErrorAction SilentlyContinue
    }

    #Appends an underscore '_' to the Registry key for Edge
    $Edge = 'HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723'
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ -Verbose
        
    }
}

Function FixWhitelistedApps {

    Param([switch]$DebloatAll, [switch]$DebloatSpecificApps, [switch]$SysPrep)
    
    Write-Verbose -Message ('Starting Fix Whitelisted Apps')

    #Credit to abulgatz for the 4 lines of code
    Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.MSPaint | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}

Write-Output "Initiating Sysprep"
Begin-SysPrep 
Write-Output "Removing bloatware apps."
DebloatAll
DebloatBlacklist
Write-Output "Removing leftover bloatware registry keys."
Remove-Keys 
Write-Output "Checking to see if any Whitelisted Apps were removed, and if so re-adding them."
FixWhitelistedApps 
Write-Output "Stopping telemetry, disabling unneccessary scheduled tasks, and preventing bloatware from returning."
Protect-Privacy 
Write-Output "Stopping Edge from taking over as the default PDF Viewer."
Stop-EdgePDF 
Write-Output "Finished all tasks."
