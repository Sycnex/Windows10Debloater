#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

# This form was created using POSHGUI.com  a free online gui designer for PowerShell
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI 
$Form = New-Object system.Windows.Forms.Form
$Form.ClientSize = '408,523'
$Form.text = "Windows10Debloater"
$Form.TopMost = $false

$Debloat = New-Object system.Windows.Forms.Label
$Debloat.text = "Debloat Options"
$Debloat.AutoSize = $true
$Debloat.width = 25
$Debloat.height = 10
$Debloat.location = New-Object System.Drawing.Point(9, 8)
$Debloat.Font = 'Microsoft Sans Serif,12,style=Bold,Underline'

$RemoveAllBloatware = New-Object system.Windows.Forms.Button
$RemoveAllBloatware.text = "Remove All Bloatware"
$RemoveAllBloatware.width = 142
$RemoveAllBloatware.height = 40
$RemoveAllBloatware.location = New-Object System.Drawing.Point(8, 32)
$RemoveAllBloatware.Font = 'Microsoft Sans Serif,10'

$RemoveBlacklist = New-Object system.Windows.Forms.Button
$RemoveBlacklist.text = "Remove Bloatware With Blacklist"
$RemoveBlacklist.width = 205
$RemoveBlacklist.height = 37
$RemoveBlacklist.location = New-Object System.Drawing.Point(9, 79)
$RemoveBlacklist.Font = 'Microsoft Sans Serif,10'

$Label1 = New-Object system.Windows.Forms.Label
$Label1.text = "Revert Debloat "
$Label1.AutoSize = $true
$Label1.width = 25
$Label1.height = 10
$Label1.location = New-Object System.Drawing.Point(254, 7)
$Label1.Font = 'Microsoft Sans Serif,12,style=Bold,Underline'

$RevertChange = New-Object system.Windows.Forms.Button
$RevertChange.text = "Revert Changes"
$RevertChange.width = 113
$RevertChange.height = 36
$RevertChange.location = New-Object System.Drawing.Point(254, 32)
$RevertChange.Font = 'Microsoft Sans Serif,10'

$Label2 = New-Object system.Windows.Forms.Label
$Label2.text = "Optional Changes/Fixes"
$Label2.AutoSize = $true
$Label2.width = 25
$Label2.height = 10
$Label2.location = New-Object System.Drawing.Point(9, 193)
$Label2.Font = 'Microsoft Sans Serif,12,style=Bold,Underline'

$DisableCortana = New-Object system.Windows.Forms.Button
$DisableCortana.text = "Disable Cortana"
$DisableCortana.width = 111
$DisableCortana.height = 36
$DisableCortana.location = New-Object System.Drawing.Point(9, 217)
$DisableCortana.Font = 'Microsoft Sans Serif,10'

$EnableCortana = New-Object system.Windows.Forms.Button
$EnableCortana.text = "Enable Cortana"
$EnableCortana.width = 112
$EnableCortana.height = 36
$EnableCortana.location = New-Object System.Drawing.Point(9, 260)
$EnableCortana.Font = 'Microsoft Sans Serif,10'

$StopEdgePDFTakeover = New-Object system.Windows.Forms.Button
$StopEdgePDFTakeover.text = "Stop Edge PDF Takeover"
$StopEdgePDFTakeover.width = 175
$StopEdgePDFTakeover.height = 35
$StopEdgePDFTakeover.location = New-Object System.Drawing.Point(130, 217)
$StopEdgePDFTakeover.Font = 'Microsoft Sans Serif,10'

$EnableEdgePDFTakeover = New-Object system.Windows.Forms.Button
$EnableEdgePDFTakeover.text = "Enable Edge PDF Takeover"
$EnableEdgePDFTakeover.width = 185
$EnableEdgePDFTakeover.height = 35
$EnableEdgePDFTakeover.location = New-Object System.Drawing.Point(130, 260)
$EnableEdgePDFTakeover.Font = 'Microsoft Sans Serif,10'

$DisableTelemetry = New-Object system.Windows.Forms.Button
$DisableTelemetry.text = "Disable Telemetry/Tasks"
$DisableTelemetry.width = 152
$DisableTelemetry.height = 35
$DisableTelemetry.location = New-Object System.Drawing.Point(9, 345)
$DisableTelemetry.Font = 'Microsoft Sans Serif,10'

$RemoveRegkeys = New-Object system.Windows.Forms.Button
$RemoveRegkeys.text = "Remove Bloatware Regkeys"
$RemoveRegkeys.width = 188
$RemoveRegkeys.height = 35
$RemoveRegkeys.location = New-Object System.Drawing.Point(169, 345)
$RemoveRegkeys.Font = 'Microsoft Sans Serif,10'

$UnpinStartMenuTiles = New-Object system.Windows.Forms.Button
$UnpinStartMenuTiles.text = "Unpin Tiles From Start Menu"
$UnpinStartMenuTiles.width = 190
$UnpinStartMenuTiles.height = 35
$UnpinStartMenuTiles.location = New-Object System.Drawing.Point(169, 303)
$UnpinStartMenuTiles.Font = 'Microsoft Sans Serif,10'

$RemoveOnedrive = New-Object system.Windows.Forms.Button
$RemoveOnedrive.text = "Uninstall OneDrive"
$RemoveOnedrive.width = 152
$RemoveOnedrive.height = 35
$RemoveOnedrive.location = New-Object System.Drawing.Point(9, 303)
$RemoveOnedrive.Font = 'Microsoft Sans Serif,10'

$FixWhitelist = New-Object system.Windows.Forms.Button
$FixWhitelist.text = "Fix Whitelisted Apps"
$FixWhitelist.width = 130
$FixWhitelist.height = 37
$FixWhitelist.location = New-Object System.Drawing.Point(254, 74)
$FixWhitelist.Font = 'Microsoft Sans Serif,10'

$InstallNet35 = New-Object system.Windows.Forms.Button
$InstallNet35.text = "Install .NET v3.5"
$InstallNet35.width = 152
$InstallNet35.height = 39
$InstallNet35.location = New-Object System.Drawing.Point(9, 387)
$InstallNet35.Font = 'Microsoft Sans Serif,10'

$EnableDarkMode = New-Object system.Windows.Forms.Button
$EnableDarkMode.text = "Enable Dark Mode"
$EnableDarkMode.width = 152
$EnableDarkMode.height = 39
$EnableDarkMode.location = New-Object System.Drawing.Point(9, 435)
$EnableDarkMode.Font = 'Microsoft Sans Serif,10'

$DisableDarkMode = New-Object system.Windows.Forms.Button
$DisableDarkMode.text = "Disable Dark Mode"
$DisableDarkMode.width = 152
$DisableDarkMode.height = 39
$DisableDarkMode.location = New-Object System.Drawing.Point(169, 435)
$DisableDarkMode.Font = 'Microsoft Sans Serif,10'



$Form.controls.AddRange(@($Debloat, $RemoveAllBloatware, $RemoveBlacklist, $Label1, $RevertChange, $Label2, $DisableCortana, $EnableCortana, $StopEdgePDFTakeover, $EnableEdgePDFTakeover, $DisableTelemetry, $RemoveRegkeys, $UnpinStartMenuTiles, $RemoveOnedrive, $FixWhitelist, $RemoveBloatNoBlacklist, $InstallNet35, $EnableDarkMode, $DisableDarkMode))

$DebloatFolder = "C:\Temp\Windows10Debloater"
If (Test-Path $DebloatFolder) {
    Write-Host "$DebloatFolder exists. Skipping."
}
Else {
    Write-Host "The folder "$DebloatFolder" doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory
    Write-Host "The folder $DebloatFolder was successfully created."
}

Start-Transcript -OutputDirectory "$DebloatFolder"

#region gui events {
$RemoveBlacklist.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        Function DebloatBlacklist {
    
            $Bloatware = @(
    
                #Unnecessary Windows 10 AppX Apps
                "Microsoft.BingNews"
                "Microsoft.GetHelp"
                "Microsoft.Getstarted"
                "Microsoft.Messaging"
                "Microsoft.Microsoft3DViewer"
                "Microsoft.MicrosoftOfficeHub"
                "Microsoft.MicrosoftSolitaireCollection"
                "Microsoft.NetworkSpeedTest"
                "Microsoft.News"
                "Microsoft.Office.Lens"
                "Microsoft.Office.OneNote"
                "Microsoft.Office.Sway"
                "Microsoft.OneConnect"
                "Microsoft.People"
                "Microsoft.Print3D"
                "Microsoft.RemoteDesktop"
                "Microsoft.SkypeApp"
                "Microsoft.StorePurchaseApp"
                "Microsoft.Office.Todo.List"
                "Microsoft.Whiteboard"
                "Microsoft.WindowsAlarms"
                #"Microsoft.WindowsCamera"
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
                "*EclipseManager*"
                "*ActiproSoftwareLLC*"
                "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
                "*Duolingo-LearnLanguagesforFree*"
                "*PandoraMediaInc*"
                "*CandyCrush*"
                "*Wunderlist*"
                "*Flipboard*"
                "*Twitter*"
                "*Facebook*"
                "*Spotify*"
                "*Minecraft*"
                "*Royal Revolt*"
                "*Sway*"
                "*Dolby*"
                "*Windows.CBSPreview*"
                
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
                Get-AppxPackage -Name $Bloat| Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
                Write-Host "Trying to remove $Bloat."
                Write-Host "Bloatware removed!"
            }
        }
        Write-Host "Removing Bloatware with a specific blacklist."
        DebloatBlacklist
    })
$RemoveAllBloatware.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        #This function finds any AppX/AppXProvisioned package and uninstalls it, except for Freshpaint, Windows Calculator, Windows Store, and Windows Photos.
        #Also, to note - This does NOT remove essential system services/software/etc such as .NET framework installations, Cortana, Edge, etc.

        #This is the switch parameter for running this script as a 'silent' script, for use in MDT images or any type of mass deployment without user interaction.

        Function Begin-SysPrep {

            Write-Host "Starting Sysprep Fixes"
   
            # Disable Windows Store Automatic Updates
            Write-Host "Adding Registry key to Disable Windows Store Automatic Updates"
            $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
            If (!(Test-Path $registryPath)) {
                Mkdir $registryPath
                New-ItemProperty $registryPath AutoDownload -Value 2 
            }
            Set-ItemProperty $registryPath AutoDownload -Value 2

            #Stop WindowsStore Installer Service and set to Disabled
            Write-Host "Stopping InstallService"
            Stop-Service InstallService
            Write-Host "Setting InstallService Startup to Disabled"
            Set-Service InstallService -StartupType Disabled
        }
        
        Function CheckDMWService {

            Param([switch]$Debloat)
  
            If (Get-Service dmwappushservice | Where-Object {$_.StartType -eq "Disabled"}) {
                Set-Service dmwappushservice -StartupType Automatic
            }

            If (Get-Service dmwappushservice | Where-Object {$_.Status -eq "Stopped"}) {
                Start-Service dmwappushservice
            } 
        }

        Function DebloatAll {
            #Removes AppxPackages
            #Credit to /u/GavinEke for a modified version of my whitelist code
            $WhitelistedApps = 'Microsoft.ScreenSketch|Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|`
            Microsoft.XboxGameCallableUI|Microsoft.XboxGamingOverlay|Microsoft.Xbox.TCUI|Microsoft.XboxGamingOverlay|Microsoft.XboxIdentityProvider|Microsoft.MicrosoftStickyNotes|Microsoft.MSPaint|Microsoft.WindowsCamera|.NET|Framework|`
            Microsoft.HEIFImageExtension|Microsoft.ScreenSketch|Microsoft.StorePurchaseApp|Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.DesktopAppInstaller|WindSynthBerry|MIDIBerry|Slack'
            #NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
            $NonRemovable = '1527c705-839a-4832-9118-54d4Bd6a0c89|c5e2524a-ea46-4f67-841f-6a9465d9d515|E2A4F912-2574-4A75-9BB0-0D023378592B|F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE|InputApp|Microsoft.AAD.BrokerPlugin|Microsoft.AccountsControl|`
            Microsoft.BioEnrollment|Microsoft.CredDialogHost|Microsoft.ECApp|Microsoft.LockApp|Microsoft.MicrosoftEdgeDevToolsClient|Microsoft.MicrosoftEdge|Microsoft.PPIProjection|Microsoft.Win32WebViewHost|Microsoft.Windows.Apprep.ChxApp|`
            Microsoft.Windows.AssignedAccessLockApp|Microsoft.Windows.CapturePicker|Microsoft.Windows.CloudExperienceHost|Microsoft.Windows.ContentDeliveryManager|Microsoft.Windows.Cortana|Microsoft.Windows.NarratorQuickStart|`
            Microsoft.Windows.ParentalControls|Microsoft.Windows.PeopleExperienceHost|Microsoft.Windows.PinningConfirmationDialog|Microsoft.Windows.SecHealthUI|Microsoft.Windows.SecureAssessmentBrowser|Microsoft.Windows.ShellExperienceHost|`
            Microsoft.Windows.XGpuEjectDialog|Microsoft.XboxGameCallableUI|Windows.CBSPreview|windows.immersivecontrolpanel|Windows.PrintDialog|Microsoft.VCLibs.140.00|Microsoft.Services.Store.Engagement|Microsoft.UI.Xaml.2.0'
            Get-AppxPackage -AllUsers | Where {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
            Get-AppxPackage | Where {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
            Get-AppxProvisionedPackage -Online | Where {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxProvisionedPackage -Online
}
  
        #Creates a PSDrive to be able to access the 'HKCR' tree
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
  
        Function Remove-Keys {         
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
                Write-Host "Removing $Key from registry"
                Remove-Item $Key -Recurse
            }
        }
          
        Function Protect-Privacy { 
  
            #Creates a PSDrive to be able to access the 'HKCR' tree
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
          
            #Disables Windows Feedback Experience
            Write-Host "Disabling Windows Feedback Experience program"
            $Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
            If (Test-Path $Advertising) {
                Set-ItemProperty $Advertising Enabled -Value 0
            }
          
            #Stops Cortana from being used as part of your Windows Search Function
            Write-Host "Stopping Cortana from being used as part of your Windows Search Function"
            $Search = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
            If (Test-Path $Search) {
                Set-ItemProperty $Search AllowCortana -Value 0
            }
          
            #Stops the Windows Feedback Experience from sending anonymous data
            Write-Host "Stopping the Windows Feedback Experience program"
            $Period1 = 'HKCU:\Software\Microsoft\Siuf'
            $Period2 = 'HKCU:\Software\Microsoft\Siuf\Rules'
            $Period3 = 'HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds'
            If (!(Test-Path $Period3)) { 
                mkdir $Period1
                mkdir $Period2
                mkdir $Period3
                New-ItemProperty $Period3 PeriodInNanoSeconds -Value 0
            }
                 
            Write-Host "Adding Registry key to prevent bloatware apps from returning"
            #Prevents bloatware applications from returning
            $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
            If (!(Test-Path $registryPath)) {
                Mkdir $registryPath
                New-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 
            }          
      
            Write-Host "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
            $Holo = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic'    
            If (Test-Path $Holo) {
                Set-ItemProperty $Holo FirstRunSucceeded -Value 0
            }
      
            #Disables live tiles
            Write-Host "Disabling live tiles"
            $Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'    
            If (!(Test-Path $Live)) {
                mkdir $Live  
                New-ItemProperty $Live NoTileApplicationNotification -Value 1
            }
      
            #Turns off Data Collection via the AllowTelemtry key by changing it to 0
            Write-Host "Turning off Data Collection"
            $DataCollection = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection'    
            If (Test-Path $DataCollection) {
                Set-ItemProperty $DataCollection AllowTelemetry -Value 0
            }
      
            #Disables People icon on Taskbar
            Write-Host "Disabling People icon on Taskbar"
            $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
            If (Test-Path $People) {
                Set-ItemProperty $People PeopleBand -Value 0
            }
  
            #Disables suggestions on start menu
            Write-Host "Disabling suggestions on the Start Menu"
            $Suggestions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'    
            If (Test-Path $Suggestions) {
                Set-ItemProperty $Suggestions SystemPaneSuggestionsEnabled -Value 0
            }
            
            
            Write-Host "Removing CloudStore from registry if it exists"
            $CloudStore = 'HKCUSoftware\Microsoft\Windows\CurrentVersion\CloudStore'
            If (Test-Path $CloudStore) {
                Stop-Process Explorer.exe -Force
                Remove-Item $CloudStore
                Start-Process Explorer.exe -Wait
            }
  
            #Loads the registry keys/values below into the NTUSER.DAT file which prevents the apps from redownloading. Credit to a60wattfish
            reg load HKU\Default_User C:\Users\Default\NTUSER.DAT
            Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SystemPaneSuggestionsEnabled -Value 0
            Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name PreInstalledAppsEnabled -Value 0
            Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name OemPreInstalledAppsEnabled -Value 0
            reg unload HKU\Default_User
      
            #Disables scheduled tasks that are considered unnecessary 
            Write-Host "Disabling scheduled tasks"
            #Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Disable-ScheduledTask
            Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask
            Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask
            Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask
            Get-ScheduledTask -TaskName DmClient | Disable-ScheduledTask
            Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Disable-ScheduledTask
        }

        Function UnpinStart {
            #Credit to Vikingat-Rage
            #https://superuser.com/questions/1068382/how-to-remove-all-the-tiles-in-the-windows-10-start-menu
            #Unpins all tiles from the Start Menu
            Write-Host "Unpinning all tiles from the start menu"
            (New-Object -Com Shell.Application).
            NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
            Items() |
            %{ $_.Verbs() } |
            ?{$_.Name -match 'Un.*pin from Start'} |
            %{$_.DoIt()}
    }

        Function Remove3dObjects {
        #Removes 3D Objects from the 'My Computer' submenu in explorer
            Write-Output "Removing 3D Objects from explorer 'My Computer' submenu"
            $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
            $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
            If (Test-Path $Objects32) {
                Remove-Item $Objects32 -Recurse 
            }
            If (Test-Path $Objects64) {
                Remove-Item $Objects64 -Recurse 
            }
}
  
        #This includes fixes by xsisbest
        Function FixWhitelistedApps {
            $ErrorActionPreference = 'silentlycontinue'
      
            If (!(Get-AppxPackage -AllUsers | Select Microsoft.Paint3D, Microsoft.MSPaint, Microsoft.WindowsCalculator, Microsoft.WindowsStore, Microsoft.MicrosoftStickyNotes, Microsoft.WindowsSoundRecorder, Microsoft.Windows.Photos)) {
      
                #Credit to abulgatz for the 4 lines of code
                Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.MSPaint | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.MicrosoftStickyNotes | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.WindowsSoundRecorder | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
                Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
            }
        }
  
        Function CheckDMWService {

            Param([switch]$Debloat)
  
            If (Get-Service dmwappushservice | Where-Object {$_.StartType -eq "Disabled"}) {
                Set-Service dmwappushservice -StartupType Automatic
            }

            If (Get-Service dmwappushservice | Where-Object {$_.Status -eq "Stopped"}) {
                Start-Service dmwappushservice
            } 
        }
        
        Function CheckInstallService {
  
            If (Get-Service InstallService | Where-Object {$_.Status -eq "Stopped"}) {  
                Start-Service InstallService
                Set-Service InstallService -StartupType Automatic 
            }
        }
  
        Write-Host "Initiating Sysprep"
        Begin-SysPrep
        Write-Host "Removing bloatware apps."
        DebloatAll
        Write-Host "Removing leftover bloatware registry keys."
        Remove-Keys
        Write-Host "Checking to see if any Whitelisted Apps were removed, and if so re-adding them."
        FixWhitelistedApps
        Write-Host "Stopping telemetry, disabling unneccessary scheduled tasks, and preventing bloatware from returning."
        Protect-Privacy
        Write-Host "Unpinning tiles from the Start Menu."
        UnpinStart
        Write-Host "Setting the 'InstallService' Windows service back to 'Started' and the Startup Type 'Automatic'."
        CheckDMWService
        CheckInstallService
        Write-Host "Finished all tasks. `n"
  
    } )
$RevertChange.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        #This function will revert the changes you made when running the Start-Debloat function.
        
        #This line reinstalls all of the bloatware that was removed
        Get-AppxPackage -AllUsers | ForEach {Add-AppxPackage -Verbose -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    
        #Tells Windows to enable your advertising information.    
        Write-Host "Re-enabling key to show advertisement information"
        $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
        If (Test-Path $Advertising) {
            Set-ItemProperty $Advertising  Enabled -Value 1
        }
            
        #Enables Cortana to be used as part of your Windows Search Function
        Write-Host "Re-enabling Cortana to be used in your Windows Search"
        $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
        If (Test-Path $Search) {
            Set-ItemProperty $Search  AllowCortana -Value 1 
        }
            
        #Re-enables the Windows Feedback Experience for sending anonymous data
        Write-Host "Re-enabling Windows Feedback Experience"
        $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
        If (!(Test-Path $Period)) { 
            New-Item $Period
        }
        Set-ItemProperty $Period PeriodInNanoSeconds -Value 1 
    
        #Enables bloatware applications               
        Write-Host "Adding Registry key to allow bloatware apps to return"
        $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
        If (!(Test-Path $registryPath)) {
            New-Item $registryPath 
        }
        Set-ItemProperty $registryPath  DisableWindowsConsumerFeatures -Value 0 
        
        #Changes Mixed Reality Portal Key 'FirstRunSucceeded' to 1
        Write-Host "Setting Mixed Reality Portal value to 1"
        $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
        If (Test-Path $Holo) {
            Set-ItemProperty $Holo  FirstRunSucceeded -Value 1 
        }
        
        #Re-enables live tiles
        Write-Host "Enabling live tiles"
        $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
        If (!(Test-Path $Live)) {
            New-Item $Live 
        }
        Set-ItemProperty $Live  NoTileApplicationNotification -Value 0 
       
        #Re-enables data collection
        Write-Host "Re-enabling data collection"
        $DataCollection = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
        If (!(Test-Path $DataCollection)) {
            New-Item $DataCollection
        }
        Set-ItemProperty $DataCollection  AllowTelemetry -Value 1
        
        #Re-enables People Icon on Taskbar
        Write-Host "Enabling People Icon on Taskbar"
        $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
        If (Test-Path $People) {
            Set-ItemProperty $People -Name PeopleBand -Value 1 -Verbose
        }
    
        #Re-enables suggestions on start menu
        Write-Host "Enabling suggestions on the Start Menu"
        $Suggestions = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
        If (!(Test-Path $Suggestions)) {
            New-Item $Suggestions
        }
        Set-ItemProperty $Suggestions  SystemPaneSuggestionsEnabled -Value 1 
        
        #Re-enables scheduled tasks that were disabled when running the Debloat switch
        Write-Host "Enabling scheduled tasks that were disabled"
        Get-ScheduledTask XblGameSaveTaskLogon | Enable-ScheduledTask 
        Get-ScheduledTask  XblGameSaveTask | Enable-ScheduledTask 
        Get-ScheduledTask  Consolidator | Enable-ScheduledTask 
        Get-ScheduledTask  UsbCeip | Enable-ScheduledTask 
        Get-ScheduledTask  DmClient | Enable-ScheduledTask 
        Get-ScheduledTask  DmClientOnScenarioDownload | Enable-ScheduledTask 

        Write-Host "Re-enabling and starting WAP Push Service"
        #Enable and start WAP Push Service
        Set-Service "dmwappushservice" -StartupType Automatic
        Start-Service "dmwappushservice"
    
        Write-Host "Re-enabling and starting the Diagnostics Tracking Service"
        #Enabling the Diagnostics Tracking Service
        Set-Service "DiagTrack" -StartupType Automatic
        Start-Service "DiagTrack"
        Write-Host "Done reverting changes!"

        #
        Write-Output "Restoring 3D Objects from explorer 'My Computer' submenu"
        $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
        $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
        If (!(Test-Path $Objects32)) {
            New-Item $Objects32
        }
        If (!(Test-Path $Objects64)) {
            New-Item $Objects64
        }
    })
$FixWhitelist.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        If (!(Get-AppxPackage -AllUsers | Select Microsoft.Paint3D, Microsoft.WindowsCalculator, Microsoft.WindowsStore, Microsoft.Windows.Photos, Microsoft.WindowsCamera)) {
    
            #Credit to abulgatz for these 4 lines of code
            Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
            Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
        } 
        
        Write-Host "Whitelisted apps were either fixed or re-added."
    })
$DisableCortana.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        Write-Host "Disabling Cortana"
        $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
        $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
        $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
        If (!(Test-Path $Cortana1)) {
            New-Item $Cortana1
        }
        Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
        If (!(Test-Path $Cortana2)) {
            New-Item $Cortana2
        }
        Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
        Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
        If (!(Test-Path $Cortana3)) {
            New-Item $Cortana3
        }
        Set-ItemProperty $Cortana3 HarvestContacts -Value 0
        Write-Host "Cortana has been disabled."
    })
$StopEdgePDFTakeover.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        #Stops edge from taking over as the default .PDF viewer    
        Write-Host "Stopping Edge from taking over as the default .PDF viewer"
        $NoPDF = "HKCR:\.pdf"
        $NoProgids = "HKCR:\.pdf\OpenWithProgids"
        $NoWithList = "HKCR:\.pdf\OpenWithList" 
        If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
            New-ItemProperty $NoPDF NoOpenWith 
        }        
        If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
            New-ItemProperty $NoPDF  NoStaticDefaultVerb 
        }        
        If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
            New-ItemProperty $NoProgids  NoOpenWith 
        }        
        If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
            New-ItemProperty $NoProgids  NoStaticDefaultVerb 
        }        
        If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
            New-ItemProperty $NoWithList  NoOpenWith
        }        
        If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
            New-ItemProperty $NoWithList  NoStaticDefaultVerb 
        }
            
        #Appends an underscore '_' to the Registry key for Edge
        $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
        If (Test-Path $Edge) {
            Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
        }
        Write-Host "Edge should no longer take over as the default .PDF."
    })
$EnableCortana.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        Write-Host "Re-enabling Cortana"
        $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
        $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
        $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
        If (!(Test-Path $Cortana1)) {
            New-Item $Cortana1
        }
        Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 1 
        If (!(Test-Path $Cortana2)) {
            New-Item $Cortana2
        }
        Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 0 
        Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 0 
        If (!(Test-Path $Cortana3)) {
            New-Item $Cortana3
        }
        Set-ItemProperty $Cortana3 HarvestContacts -Value 1 
        Write-Host "Cortana has been enabled!"
    })
$EnableEdgePDFTakeover.Add_Click( { 
        New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        $ErrorActionPreference = 'silentlycontinue'
        Write-Host "Setting Edge back to default"
        $NoPDF = "HKCR:\.pdf"
        $NoProgids = "HKCR:\.pdf\OpenWithProgids"
        $NoWithList = "HKCR:\.pdf\OpenWithList"
        #Sets edge back to default
        If (Get-ItemProperty $NoPDF  NoOpenWith) {
            Remove-ItemProperty $NoPDF  NoOpenWith
        } 
        If (Get-ItemProperty $NoPDF  NoStaticDefaultVerb) {
            Remove-ItemProperty $NoPDF  NoStaticDefaultVerb 
        }       
        If (Get-ItemProperty $NoProgids  NoOpenWith) {
            Remove-ItemProperty $NoProgids  NoOpenWith 
        }        
        If (Get-ItemProperty $NoProgids  NoStaticDefaultVerb) {
            Remove-ItemProperty $NoProgids  NoStaticDefaultVerb 
        }        
        If (Get-ItemProperty $NoWithList  NoOpenWith) {
            Remove-ItemProperty $NoWithList  NoOpenWith
        }    
        If (Get-ItemProperty $NoWithList  NoStaticDefaultVerb) {
            Remove-ItemProperty $NoWithList  NoStaticDefaultVerb
        }
        
        #Removes an underscore '_' from the Registry key for Edge
        $Edge2 = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
        If (Test-Path $Edge2) {
            Set-Item $Edge2 AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
        }
        Write-Host "Edge will now be able to be used for .PDF."
    })
$DisableTelemetry.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        #Disables Windows Feedback Experience
        Write-Host "Disabling Windows Feedback Experience program"
        $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
        If (Test-Path $Advertising) {
            Set-ItemProperty $Advertising Enabled -Value 0 
        }
            
        #Stops Cortana from being used as part of your Windows Search Function
        Write-Host "Stopping Cortana from being used as part of your Windows Search Function"
        $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
        If (Test-Path $Search) {
            Set-ItemProperty $Search AllowCortana -Value 0 
        }

        #Disables Web Search in Start Menu
        Write-Host "Disabling Bing Search in Start Menu"
        $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
        Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
        If (!(Test-Path $WebSearch)) {
            New-Item $WebSearch
        }
        Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
        #Stops the Windows Feedback Experience from sending anonymous data
        Write-Host "Stopping the Windows Feedback Experience program"
        $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
        If (!(Test-Path $Period)) { 
            New-Item $Period
        }
        Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

        #Prevents bloatware applications from returning and removes Start Menu suggestions               
        Write-Host "Adding Registry key to prevent bloatware apps from returning"
        $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
        $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
        If (!(Test-Path $registryPath)) { 
            New-Item $registryPath
        }
        Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

        If (!(Test-Path $registryOEM)) {
            New-Item $registryOEM
        }
        Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
        Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
        Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
        Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
        #Preping mixed Reality Portal for removal    
        Write-Host "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
        $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
        If (Test-Path $Holo) {
            Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
        }

        #Disables Wi-fi Sense
        Write-Host "Disabling Wi-Fi Sense"
        $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
        $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
        $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
        If (!(Test-Path $WifiSense1)) {
            New-Item $WifiSense1
        }
        Set-ItemProperty $WifiSense1  Value -Value 0 
        If (!(Test-Path $WifiSense2)) {
            New-Item $WifiSense2
        }
        Set-ItemProperty $WifiSense2  Value -Value 0 
        Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
        #Disables live tiles
        Write-Host "Disabling live tiles"
        $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
        If (!(Test-Path $Live)) {      
            New-Item $Live
        }
        Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
        #Turns off Data Collection via the AllowTelemtry key by changing it to 0
        Write-Host "Turning off Data Collection"
        $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
        $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
        $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
        If (Test-Path $DataCollection1) {
            Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
        }
        If (Test-Path $DataCollection2) {
            Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
        }
        If (Test-Path $DataCollection3) {
            Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
        }
    
        #Disabling Location Tracking
        Write-Host "Disabling Location Tracking"
        $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
        $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
        If (!(Test-Path $SensorState)) {
            New-Item $SensorState
        }
        Set-ItemProperty $SensorState SensorPermissionState -Value 0 
        If (!(Test-Path $LocationConfig)) {
            New-Item $LocationConfig
        }
        Set-ItemProperty $LocationConfig Status -Value 0 
        
        #Disables People icon on Taskbar
        Write-Host "Disabling People icon on Taskbar"
        $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
        If (Test-Path $People) {
            Set-ItemProperty $People -Name PeopleBand -Value 0
        } 
        
        #Disables scheduled tasks that are considered unnecessary 
        Write-Host "Disabling scheduled tasks"
        #Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
        Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
        Get-ScheduledTask  Consolidator | Disable-ScheduledTask
        Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
        Get-ScheduledTask  DmClient | Disable-ScheduledTask
        Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask

        #Write-Host "Uninstalling Telemetry Windows Updates"
        #Uninstalls Some Windows Updates considered to be Telemetry. !WIP!
        #Wusa /Uninstall /KB:3022345 /norestart /quiet
        #Wusa /Uninstall /KB:3068708 /norestart /quiet
        #Wusa /Uninstall /KB:3075249 /norestart /quiet
        #Wusa /Uninstall /KB:3080149 /norestart /quiet        

        Write-Host "Stopping and disabling WAP Push Service"
        #Stop and disable WAP Push Service
        Stop-Service "dmwappushservice"
        Set-Service "dmwappushservice" -StartupType Disabled

        Write-Host "Stopping and disabling Diagnostics Tracking Service"
        #Disabling the Diagnostics Tracking Service
        Stop-Service "DiagTrack"
        Set-Service "DiagTrack" -StartupType Disabled
        Write-Host "Telemetry has been disabled!"
    })
$RemoveRegkeys.Add_Click( { 
        $ErrorActionPreference = 'silentlycontinue'
        $Keys = @(
            
            New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
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
            Write-Host "Removing $Key from registry"
            Remove-Item $Key -Recurse
        }
        Write-Host "Additional bloatware keys have been removed!"
    })
$UnpinStartMenuTiles.Add_Click( {
        #https://superuser.com/questions/1068382/how-to-remove-all-the-tiles-in-the-windows-10-start-menu
        #Unpins all tiles from the Start Menu
            Write-Host "Unpinning all tiles from the start menu"
            (New-Object -Com Shell.Application).
            NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
            Items() |
            %{ $_.Verbs() } |
            ?{$_.Name -match 'Un.*pin from Start'} |
            %{$_.DoIt()}
    })

$RemoveOnedrive.Add_Click( { 
        If (Test-Path "$env:USERPROFILE\OneDrive\*") {
            Write-Host "Files found within the OneDrive folder! Checking to see if a folder named OneDriveBackupFiles exists."
            Start-Sleep 1
              
            If (Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles") {
                Write-Host "A folder named OneDriveBackupFiles already exists on your desktop. All files from your OneDrive location will be moved to that folder." 
            }
            else {
                If (!(Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles")) {
                    Write-Host "A folder named OneDriveBackupFiles will be created and will be located on your desktop. All files from your OneDrive location will be located in that folder."
                    New-item -Path "$env:USERPROFILE\Desktop" -Name "OneDriveBackupFiles"-ItemType Directory -Force
                    Write-Host "Successfully created the folder 'OneDriveBackupFiles' on your desktop."
                }
            }
            Start-Sleep 1
            Move-Item -Path "$env:USERPROFILE\OneDrive\*" -Destination "$env:USERPROFILE\Desktop\OneDriveBackupFiles" -Force
            Write-Host "Successfully moved all files/folders from your OneDrive folder to the folder 'OneDriveBackupFiles' on your desktop."
            Start-Sleep 1
            Write-Host "Proceeding with the removal of OneDrive."
            Start-Sleep 1
        }
        Else {
            Write-Host "Either the OneDrive folder does not exist or there are no files to be found in the folder. Proceeding with removal of OneDrive."
            Start-Sleep 1
            Write-Host "Enabling the Group Policy 'Prevent the usage of OneDrive for File Storage'."
            $OneDriveKey = 'HKLM:Software\Policies\Microsoft\Windows\OneDrive'
            If (!(Test-Path $OneDriveKey)) {
                Mkdir $OneDriveKey
                Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
            }
            Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
        }

        Write-Host "Uninstalling OneDrive. Please wait..."
    
        New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        Stop-Process -Name "OneDrive*"
        Start-Sleep 2
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep 2
        Write-Host "Stopping explorer"
        Start-Sleep 1
        taskkill.exe /F /IM explorer.exe
        Start-Sleep 3
        Write-Host "Removing leftover files"
        If (Test-Path "$env:USERPROFILE\OneDrive") {
            Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive") {
            Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:PROGRAMDATA\Microsoft OneDrive") {
            Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
            Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
        }
        Write-Host "Removing OneDrive from windows explorer"
        If (!(Test-Path $ExplorerReg1)) {
            New-Item $ExplorerReg1
        }
        Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
        If (!(Test-Path $ExplorerReg2)) {
            New-Item $ExplorerReg2
        }
        Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
        Write-Host "Restarting Explorer that was shut down before."
        Start-Process explorer.exe -NoNewWindow
        Write-Host "OneDrive has been successfully uninstalled!"
    })

$InstallNet35.Add_Click( {

        Write-Host "Initializing the installation of .NET 3.5..."
        DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
        Write-Host ".NET 3.5 has been successfully installed!"
    } )

$EnableDarkMode.Add_Click(  {
    Write-Host "Enabling Dark Mode"
    $Theme = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty $Theme AppsUseLightTheme -Value 0
    Start-Sleep 1
    Write-Host "Enabled"
}
)

$DisableDarkMode.Add_Click(  {
    Write-Host "Disabling Dark Mode"
    $Theme = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty $Theme AppsUseLightTheme -Value 1
    Start-Sleep 1
    Write-Host "Disabled"
}
)

[void]$Form.ShowDialog()
