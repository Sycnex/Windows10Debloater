Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ErrorPreference = 'SilentlyContinue'
$VerbosePreference = 'Continue'

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Windows10Debloater'
$form.Size = New-Object System.Drawing.Size(1000,600)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(275,40)
$OKButton.Size = New-Object System.Drawing.Size(225,23)
$OKButton.Text = 'Remove Selected Bloatware Packages'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$ProtectPrivacy                = New-Object system.Windows.Forms.Button
$ProtectPrivacy.text           = "Disable Telemetry"
$ProtectPrivacy.width          = 265
$ProtectPrivacy.height         = 23
$ProtectPrivacy.location       = New-Object System.Drawing.Point(275,365)
$form.Controls.Add($ProtectPrivacy)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$RemoveKeys                = New-Object system.Windows.Forms.Button
$RemoveKeys.text           = "Remove registry keys associated with Bloatware"
$RemoveKeys.width          = 265
$RemoveKeys.height         = 23
$RemoveKeys.location       = New-Object System.Drawing.Point(275,400)
$form.Controls.Add($RemoveKeys)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$RevertChange                = New-Object system.Windows.Forms.Button
$RevertChange.text           = "Revert Changes made by this utility"
$RevertChange.width          = 265
$RevertChange.height         = 23
$RevertChange.location       = New-Object System.Drawing.Point(275,435)
$form.Controls.Add($RevertChange)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$EnableCortana                = New-Object system.Windows.Forms.Button
$EnableCortana.text           = "Enable Cortana"
$EnableCortana.width          = 265
$EnableCortana.height         = 23
$EnableCortana.location       = New-Object System.Drawing.Point(575,365)
$form.Controls.Add($EnableCortana)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$DisableCortana                = New-Object system.Windows.Forms.Button
$DisableCortana.text           = "Disable Cortana"
$DisableCortana.width          = 265
$DisableCortana.height         = 23
$DisableCortana.location       = New-Object System.Drawing.Point(575,400)
$form.Controls.Add($DisableCortana)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$UnpinStartMenuTiles               = New-Object system.Windows.Forms.Button
$UnpinStartMenuTiles.text           = "Unpin Start Menu Tiles"
$UnpinStartMenuTiles.width          = 265
$UnpinStartMenuTiles.height         = 23
$UnpinStartMenuTiles.location       = New-Object System.Drawing.Point(575,435)
$form.Controls.Add($UnpinStartMenuTiles)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Select Default Bloatware Packages To Remove:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,500)
#$listBox.Height = 80

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(275,145)
$label2.Size = New-Object System.Drawing.Size(280,30)
$label2.Text = 'This is used to remove other packages besides the ones chosen on the left hand side'
$form.Controls.Add($label2)

$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(275,285)
$label3.Size = New-Object System.Drawing.Size(500,15)
$label3.Text = '_______________________________________________________________________________'
$form.Controls.Add($label3)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(275,265)
$label4.Size = New-Object System.Drawing.Size(500,100)
$label4.Text = 'ADVANCED OPTIONS BELOW'
$form.Controls.Add($label4)

$WhitelistDebloat                = New-Object system.Windows.Forms.Button
$WhitelistDebloat.text           = "Remove extra packages besides the default bloatware"
$WhitelistDebloat.width          = 285
$WhitelistDebloat.height         = 30
$WhitelistDebloat.location       = New-Object System.Drawing.Point(275,175)
#$WhitelistDebloat.Font           = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($WhitelistDebloat,$RemoveKeys,$ProtectPrivacy))

$WhitelistDebloat.Add_Click({ 
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

Debloatall

 })

 Try {
 New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
 }
 Catch {$_
 }

 $RemoveKeys.Add_Click({
 Function Remove-Keys {

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
        Write-Verbose "Removing $Key from registry"
        Remove-Item $Key -Recurse
    }
}
Remove-Keys
})

$ProtectPrivacy.Add_Click({
Function ProtectPrivacy { 
  
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
    ProtectPrivacy
})

$RevertChange.Add_Click( { 
    Function RevertChanges {
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
     }
    RevertChanges
})

$DisableCortana.Add_Click( { 
    DisableCortana {
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
    }
DisableCortana
})

$EnableCortana.Add_Click( { 
    EnableCortana {
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
     }
EnableCortana
})

$UnpinStartMenuTiles.Add_Click( {
    UnpinStartMenuTiles {
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
    UnpinStartMenuTiles
})


$listBox.SelectionMode = 'MultiExtended'

[void] $listBox.Items.Add('Microsoft.BingNews')
[void] $listBox.Items.Add('Microsoft.GetHelp')
[void] $listBox.Items.Add('Microsoft.Getstarted')
[void] $listBox.Items.Add('Microsoft.Messaging')
[void] $listBox.Items.Add('Microsoft.Microsoft3DViewer')
[void] $listBox.Items.Add('Microsoft.MicrosoftOfficeHub')
[void] $listBox.Items.Add('Microsoft.MicrosoftSolitaireCollection')
[void] $listBox.Items.Add('Microsoft.NetworkSpeedTest')
[void] $listBox.Items.Add('Microsoft.News')
[void] $listBox.Items.Add('Microsoft.Office.Lens')
[void] $listBox.Items.Add('Microsoft.Office.OneNote')
[void] $listBox.Items.Add('Microsoft.Office.Sway')
[void] $listBox.Items.Add('Microsoft.OneConnect')
[void] $listBox.Items.Add('Microsoft.People')
[void] $listBox.Items.Add('Microsoft.Print3D')
[void] $listBox.Items.Add('Microsoft.RemoteDesktop')
[void] $listBox.Items.Add('Microsoft.SkypeApp')
[void] $listBox.Items.Add('Microsoft.StorePurchaseApp')
[void] $listBox.Items.Add('Microsoft.Office.Todo.List')
[void] $listBox.Items.Add('Microsoft.Whiteboard')
[void] $listBox.Items.Add('Microsoft.WindowsAlarms')
[void] $listBox.Items.Add('Microsoft.WindowsCamera')
[void] $listBox.Items.Add('microsoft.windowscommunicationsapps')
[void] $listBox.Items.Add('Microsoft.WindowsFeedbackHub')
[void] $listBox.Items.Add('Microsoft.WindowsMaps')
[void] $listBox.Items.Add('Microsoft.WindowsSoundRecorder')
[void] $listBox.Items.Add('Microsoft.Xbox.TCUI')
[void] $listBox.Items.Add('Microsoft.XboxApp')
[void] $listBox.Items.Add('Microsoft.XboxGameOverlay')
[void] $listBox.Items.Add('Microsoft.XboxIdentityProvider')
[void] $listBox.Items.Add('Microsoft.XboxSpeechToTextOverlay')
[void] $listBox.Items.Add('Microsoft.ZuneMusic')
[void] $listBox.Items.Add('Microsoft.ZuneVideo')
[void] $listBox.Items.Add('*EclipseManager*')
[void] $listBox.Items.Add('*ActiproSoftwareLLC*')
[void] $listBox.Items.Add('*AdobeSystemsIncorporated.AdobePhotoshopExpress*')
[void] $listBox.Items.Add('*Duolingo-LearnLanguagesforFree*')
[void] $listBox.Items.Add('*PandoraMediaInc*')
[void] $listBox.Items.Add('*CandyCrush*')
[void] $listBox.Items.Add('*Wunderlist*')
[void] $listBox.Items.Add('*Flipboard*')
[void] $listBox.Items.Add('*Twitter*')
[void] $listBox.Items.Add('*Facebook*')
[void] $listBox.Items.Add('*Spotify*')
[void] $listBox.Items.Add('*Minecraft*')
[void] $listBox.Items.Add('*Royal Revolt*')
[void] $listBox.Items.Add('*Sway*')
[void] $listBox.Items.Add('*Speed Test*')
[void] $listBox.Items.Add('*Dolby*')
[void] $listBox.Items.Add('*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*')
[void] $listBox.Items.Add('*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*')
[void] $listBox.Items.Add('*Microsoft.BingWeather*')
[void] $listBox.Items.Add('*Microsoft.MSPaint*')
[void] $listBox.Items.Add('*Microsoft.MicrosoftStickyNotes*')
[void] $listBox.Items.Add('*Microsoft.Windows.Photos*')
[void] $listBox.Items.Add('*Microsoft.WindowsCalculator*')
[void] $listBox.Items.Add('*Microsoft.WindowsStore*')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    foreach ($x in $x) {
        Get-AppxPackage -Name $x| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $x | Remove-AppxProvisionedPackage -Online
        Write-Verbose "Trying to remove $x."
    }
}
