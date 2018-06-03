#This function finds any AppX/AppXProvisioned package and uninstalls it, except for Freshpaint, Windows Calculator, Windows Store, and Windows Photos.
#Also, to note - This does NOT remove essential system services/software/etc such as .NET framework installations, Cortana, Edge, etc.

#Checks for the script running as admin and if it's not then restarts the script in admin
Add-Type -AssemblyName PresentationCore,PresentationFramework
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
  Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
  Exit
}

If (Test-Path "C:\Windows10Debloater") {
    Write-Output "C:\Windows10Debloater exists. Skipping."
}
Else {
    Write-Output "The folder 'C:\Windows10Debloater' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "C:\Windows10Debloater" -ItemType Directory
}

Start-Transcript -OutputDirectory "C:\Windows10Debloater"

#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

Function Start-Debloat {
    
    [CmdletBinding()]
        
    Param()
    
    #Removes AppxPackages
    #Credit to /u/GavinEke for a modified version of my whitelist code
    [regex]$WhitelistedApps = 'Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|Microsoft.XboxGameCallableUI|Microsoft.XboxGamingOverlay|Microsoft.Xbox.TCUI'
    Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps} | Remove-AppxProvisionedPackage -Online
}
Function Remove-Keys {
        
    [CmdletBinding()]
            
    Param()
        
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
        Remove-Item $Key -Recurse
    }
}
            
Function Protect-Privacy {
        
    [CmdletBinding()]
        
    Param()
            
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
        mkdir $Period1
        mkdir $Period2
        mkdir $Period3
        New-ItemProperty $Period3 -Name PeriodInNanoSeconds -Value 0 -Verbose
    }
                   
    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    #Prevents bloatware applications from returning
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    If (!(Test-Path $registryPath)) {
        Mkdir $registryPath 
        New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 -Verbose 
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
        mkdir $Live      
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
        mkdir $People 
        New-ItemProperty $People -Name PeopleBand -Value 0 -Verbose
    }
    
    #Disables suggestions on start menu
    Write-Output "Disabling suggestions on the Start Menu"
    If ('HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager') {
        $Suggestions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
        Set-ItemProperty $Suggestions -Name SystemPaneSuggestionsEnabled -Value 0 -Verbose
    }
        
    #Disables scheduled tasks that are considered unnecessary 
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask
    Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask -TaskName DmClient | Disable-ScheduledTask
    Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Disable-ScheduledTask
}
        
Function Stop-EdgePDF {
        
    Write-Output "Stopping Edge from taking over as the default .PDF viewer" 
    #Stops edge from taking over as the default .PDF viewer
    If (!(Get-ItemProperty 'HKCR:\.pdf' -Name NoOpenWith)) {
        $NoOpen = 'HKCR:\.pdf'
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose 
    }
        
    If (!(Get-ItemProperty 'HKCR:\.pdf' -Name NoStaticDefaultVerb)) {
        $NoStatic = 'HKCR:\.pdf'
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose 
    }
        
    If (!(Get-ItemProperty 'HKCR:\.pdf\OpenWithProgids' -Name NoOpenWith)) {
        $NoOpen = 'HKCR:\.pdf\OpenWithProgids'
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose 
    }
        
    If (!(Get-ItemProperty 'HKCR:\.pdf\OpenWithProgids' -Name NoStaticDefaultVerb)) {
        $NoStatic = 'HKCR:\.pdf\OpenWithProgids'
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose 
    }
        
    If (!(Get-ItemProperty 'HKCR:\.pdf\OpenWithList' -Name NoOpenWith)) {
        $NoOpen = 'HKCR:\.pdf\OpenWithList'
        New-ItemProperty $NoOpen -Name NoOpenWith -Verbose 
    }
        
    If (!(Get-ItemProperty 'HKCR:\.pdf\OpenWithList' -Name NoStaticDefaultVerb)) {
        $NoStatic = 'HKCR:\.pdf\OpenWithList'
        New-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose 
    }
        
    #Appends an underscore '_' to the Registry key for Edge
    If ('HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723') {
        $Edge = 'HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723'
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ -Verbose
    }
}

Function Revert-Changes {   
            
    [CmdletBinding()]
            
    Param()
        
    #This function will revert the changes you made when running the Start-Debloat function.
        
    #This line reinstalls all of the bloatware that was removed
    Get-AppxPackage -AllUsers | ForEach {Add-AppxPackage -Verbose -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
        
    Write-Output "Re-enabling key to show advertisement information"
    #Tells Windows to enable your advertising information.
    If ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo') {
        $Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
        Set-ItemProperty $Advertising -Name Enabled -Value 1 -Verbose
    }
            
    #Enables Cortana to be used as part of your Windows Search Function
    Write-Output "Re-enabling Cortana to be used in your Windows Search"
    If ('HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search') {
        $Search = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
        Set-ItemProperty $Search -Name AllowCortana -Value 1 -Verbose
    }
            
    #Re-enables the Windows Feedback Experience for sending anonymous data
    Write-Output "Re-enabling Windows Feedback Experience"
    If (!('HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds')) { 
        mkdir 'HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds'
        $Period = 'HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds'
        New-Item $Period 
        Set-ItemProperty -Name PeriodInNanoSeconds -Value 1 -Verbose
    }
                   
    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    #Enables bloatware applications
    If ('HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent') {
        $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
        Mkdir $registryPath 
        New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 0 -Verbose 
    }
        
    #Changes Mixed Reality Portal Key 'FirstRunSucceeded' to 1
    Write-Output "Setting Mixed Reality Portal value to 1"
    If ('HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic') {
        $Holo = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic'
        Set-ItemProperty $Holo -Name FirstRunSucceeded -Value 1 -Verbose
    }
        
    #Re-enables live tiles
    Write-Output "Enabling live tiles"
    If ('HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications') {
        mkdir 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'        
        $Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'
        New-ItemProperty $Live -Name NoTileApplicationNotification -Value 0 -Verbose 
    }
               
    Write-Output "Changing the 'Cloud Content' registry key value to 1 to allow bloatware apps to reinstall"
    #Prevents bloatware applications from returning
    If ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\") {
        $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
        Mkdir $registryPath 
        New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 -Verbose 
    }
        
    #Re-enables data collection
    Write-Output "Re-enabling data collection"
    If ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection') {
        $DataCollection = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection'
        Set-ItemProperty $DataCollection -Name AllowTelemetry -Value 1 -Verbose
    }
        
    #Re-enables People Icon on Taskbar
    Write-Output "Enabling People icon on Taskbar"
    If ('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People') {
        $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
        New-ItemProperty $People -Name PeopleBand -Value 1 -Verbose 
    }
    
    #Re-enables suggestions on start menu
    Write-Output "Enabling suggestions on the Start Menu"
    If ('HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager') {
        $Suggestions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
        Set-ItemProperty $Suggestions -Name SystemPaneSuggestionsEnabled -Value 1 -Verbose
    }
        
    #Re-enables scheduled tasks that were disabled when running the Debloat switch
    Write-Output "Enabling scheduled tasks that were disabled"
    Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Enable-ScheduledTask 
    Get-ScheduledTask -TaskName XblGameSaveTask | Enable-ScheduledTask 
    Get-ScheduledTask -TaskName Consolidator | Enable-ScheduledTask 
    Get-ScheduledTask -TaskName UsbCeip | Enable-ScheduledTask 
    Get-ScheduledTask -TaskName DmClient | Enable-ScheduledTask 
    Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Enable-ScheduledTask 
}
    
Function Enable-EdgePDF {
    Write-Output "Setting Edge back to default"
    #Sets edge back to default
    If (Get-ItemProperty 'HKCR:\.pdf' -Name NoOpenWith) {
        $NoOpen = 'HKCR:\.pdf'
        Remove-ItemProperty $NoOpen -Name NoOpenWith -Verbose
    }
        
    If (Get-ItemProperty 'HKCR:\.pdf' -Name NoStaticDefaultVerb) {
        $NoStatic = 'HKCR:\.pdf'
        Remove-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose
    }
        
    If (Get-ItemProperty 'HKCR:\.pdf\OpenWithProgids' -Name NoOpenWith) {
        $NoOpen = 'HKCR:\.pdf\OpenWithProgids'
        Remove-ItemProperty $NoOpen -Name NoOpenWith -Verbose
    }
        
    If (Get-ItemProperty 'HKCR:\.pdf\OpenWithProgids' -Name NoStaticDefaultVerb) {
        $NoStatic = 'HKCR:\.pdf\OpenWithProgids'
        Remove-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose
    }
        
    If (Get-ItemProperty 'HKCR:\.pdf\OpenWithList' -Name NoOpenWith) {
        $NoOpen = 'HKCR:\.pdf\OpenWithList'
        Remove-ItemProperty $NoOpen -Name NoOpenWith -Verbose
    }
        
    If (Get-ItemProperty 'HKCR:\.pdf\OpenWithList' -Name NoStaticDefaultVerb) {
        $NoStatic = 'HKCR:\.pdf\OpenWithList'
        Remove-ItemProperty $NoStatic -Name NoStaticDefaultVerb -Verbose
    }
        
    #Removes an underscore '_' from the Registry key for Edge
    If ('HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723') {
        $Edge = 'HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723'
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723 -Verbose
    }
}

Function FixWhitelistedApps {
    
    [CmdletBinding()]
            
    Param()
    
    If (!(Get-AppxPackage -AllUsers | Select Microsoft.Paint3D, Microsoft.WindowsCalculator, Microsoft.WindowsStore, Microsoft.Windows.Photos)) {
    
        #Credit to abulgatz for these 4 lines of code
        Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
        Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    } 
}


#GUI prompt Debloat/Revert options and GUI variables
$Button = [Windows.MessageBoxButton]::YesNo
$ErrorIco = [Windows.MessageBoxImage]::Error
$Warn = [Windows.MessageBoxImage]::Warning
$Ask = 'The following will allow you to either Debloat Windows 10, or to revert changes made after Debloating Windows 10.
        Choose "Yes" to Debloat Windows 10
        Choose "No" to revert changes made by this script.'
$EdgePdf = 'Do you want to stop edge from taking over as the default PDF viewer?'
$EdgePdf2 = 'Do you want to revert changes that disabled Edge as the default PDF viewer?'
$Reboot = 'For some of the changes to properly take effect it is recommended to reboot your machine. Would you like to restart?'

$Prompt1 = [Windows.MessageBox]::Show($Ask,'Debloat or Revert',$Button,$ErrorIco) 
Switch ($Prompt1) {
    #This will debloat Windows 10
    Yes {
        #Creates a "drive" to access the HKCR (HKEY_CLASSES_ROOT)
        Write-Output "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the removal and modification of specific registry keys."
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        Start-Sleep 1
        Write-Output "Uninstalling bloatware, please wait."
        Start-Debloat
        Write-Output "Bloatware removed."
        Start-Sleep 1
        Write-Output "Removing specific registry keys."
        Remove-Keys
        Write-Output "Leftover bloatware registry keys removed."
        Start-Sleep 1
        Write-Output "Checking to see if any Whitelisted Apps were removed, and if so re-adding them."
        Start-Sleep 1
        FixWhitelistedApps
        Start-Sleep 1
        Write-Output "Disabling Cortana from search, disabling feedback to Microsoft, and disabling scheduled tasks that are considered to be telemetry or unnecessary."
        Protect-Privacy
        Write-Output "Cortana disabled from search, feedback to Microsoft has been disabled, and scheduled tasks are disabled."
        Start-Sleep 1; $PublishSettings = $Debloat

        $Prompt2 = [Windows.MessageBox]::Show($EdgePdf,'Edge PDF',$Button,$Warn)
        Switch ($Prompt2) {
            Yes {
                Stop-EdgePDF
                Write-Output "Edge will no longer take over as the default PDF viewer."; $PublishSettings = $Yes
            }
            No {
                $PublishSettings = $No
            }
        }
        #Prompt asking if you'd like to reboot your machine
        $Prompt3 = [Windows.MessageBox]::Show($Reboot,'Reboot',$Button,$Warn) 
        Switch ($Prompt3) {
            Yes {
                Write-Output "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Stop-Transcript
                Write-Output "Initiating reboot."
                Start-Sleep 2
                Restart-Computer; $PublishSettings = $Yes
            }
            No {
                Write-Output "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Stop-Transcript
                Write-Output "Script has finished. Exiting."
                Start-Sleep 2
                Exit; $PublishSettings = $No
            }
        }
    }
    No {
        Write-Output "Reverting changes..."
        Write-Output "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the modification of specific registry keys."
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        Revert-Changes; $PublishSettings = $Revert
        #Prompt asking to revert edge changes as well
        $Prompt4 = [Windows.MessageBox]::Show($EdgePdf2,'Revert Edge',$Button,$ErrorIco)
        Switch ($Prompt4) {
            Yes {
                Enable-EdgePDF
                Write-Output "Edge will no longer be disabled from being used as the default Edge PDF viewer."; $PublishSettings = $Yes
            }
            No {$PublishSettings = $No}
        }
        #Prompt asking if you'd like to reboot your machine
        $Prompt5 = [Windows.MessageBox]::Show($Reboot,'Reboot',$Button,$Warn)
        Switch ($Prompt5) {
            Yes {
                Write-Output "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Output "Initiating reboot."
                Stop-Transcript
                Start-Sleep 2
                Restart-Computer; $PublishSettings = $Yes
            }
            No {
                Write-Output "Unloading the HKCR drive..."
                Remove-PSDrive HKCR 
                Start-Sleep 1
                Write-Output "Script has finished. Exiting."
                Stop-Transcript
                Start-Sleep 2
                Exit; $PublishSettings = $No
            }
        }
    }
}
