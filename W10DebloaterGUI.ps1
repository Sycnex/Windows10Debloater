<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.

<#$ErrorActionPreference = 'SilentlyContinue'

$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
$Ask = 'Do you want to run this as an Administrator?

        Select "Yes" to Run as an Administrator

        Select "No" to not run this as an Administrator
        
        Select "Cancel" to stop the script.'

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    $Prompt = [System.Windows.MessageBox]::Show($Ask, "Run as an Administrator or not?", $Button, $ErrorIco) 
    Switch ($Prompt) {
        #This will debloat Windows 10
        Yes {
            Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
            Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
            Exit
        }
        No {
            Break
        }
    }
}#>

$DebloatFolder = "C:\Temp\Windows10Debloater"
If (Test-Path $DebloatFolder) {
    Write-Host "${DebloatFolder} exists." 
}
Else {
    Write-Host "The folder ${DebloatFolder} doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "${DebloatFolder}" -ItemType Directory
    Write-Host "The folder ${DebloatFolder} was successfully created."
}

Start-Transcript -OutputDirectory "${DebloatFolder}"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore, PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form = New-Object system.Windows.Forms.Form
$Form.ClientSize = '875,616'
$Form.text = "Windows 10 Debloater"
$Form.TopMost = $false

$ListBox1 = New-Object system.Windows.Forms.ListBox
$ListBox1.text = "listBox"
$ListBox1.width = 300
$ListBox1.height = 494
$ListBox1.location = New-Object System.Drawing.Point(3, 116)
$ListBox1.SelectionMode = 'MultiExtended'


$TextBox1 = New-Object system.Windows.Forms.RichTextBox
$TextBox1.multiline = $True
$TextBox1.width = 535
$TextBox1.height = 400
$TextBox1.location = New-Object System.Drawing.Point(325, 200)
$TextBox1.Font = 'Microsoft Sans Serif,10'


$Button1 = New-Object system.Windows.Forms.Button
$Button1.text = "Uninstall"
$Button1.width = 80
$Button1.height = 30
$Button1.location = New-Object System.Drawing.Point(5, 80)
$Button1.Font = 'Microsoft Sans Serif,10'

$Button2 = New-Object system.Windows.Forms.Button
$Button2.text = "Apply Checkbox Changes"
$Button2.width = 175
$Button2.height = 30
$Button2.location = New-Object System.Drawing.Point(685, 165)
$Button2.Font = 'Microsoft Sans Serif,10'

$Label1 = New-Object system.Windows.Forms.Label
$Label1.text = "-----------------------------------------------------------------------------------------------------------------"
$Label1.AutoSize = $true
$Label1.width = 50
$Label1.height = 10
$Label1.location = New-Object System.Drawing.Point(305, 108)
$Label1.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

$CheckBox1 = New-Object system.Windows.Forms.CheckBox
$CheckBox1.text = "Enable Cortana"
$CheckBox1.AutoSize = $false
$CheckBox1.width = 125
$CheckBox1.height = 20
$CheckBox1.location = New-Object System.Drawing.Point(325, 175)
$CheckBox1.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

$CheckBox2 = New-Object system.Windows.Forms.CheckBox
$CheckBox2.text = "Disable Cortana"
$CheckBox2.AutoSize = $false
$CheckBox2.width = 125
$CheckBox2.height = 20
$CheckBox2.location = New-Object System.Drawing.Point(325, 150)
$CheckBox2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

$CheckBox3 = New-Object system.Windows.Forms.CheckBox
$CheckBox3.text = "Uninstall OneDrive"
$CheckBox3.AutoSize = $false
$CheckBox3.width = 140
$CheckBox3.height = 20
$CheckBox3.location = New-Object System.Drawing.Point(475, 150)
$CheckBox3.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

$CheckBox4 = New-Object system.Windows.Forms.CheckBox
$CheckBox4.text = "Unpin Tiles From Start Menu"
$CheckBox4.AutoSize = $false
$CheckBox4.width = 200
$CheckBox4.height = 20
$CheckBox4.location = New-Object System.Drawing.Point(475, 175)
$CheckBox4.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)


$Form.controls.AddRange(@($ListBox1, $Button1, $Button2, $TextBox1, $CustomizeBlacklists, $CustomizeForm, $SaveList, $CustomizeBlacklists, $Checkbox1, $Checkbox2, $CheckBox3, $CheckBox4, $Label1))

$global:Bloatware = @(
    "Microsoft.PPIProjection"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"                                    # Issue 77
    "Microsoft.Office.Lens"                             # Issue 77
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.RemoteDesktop"                           # Issue 120
    "Microsoft.SkypeApp"
    "Microsoft.StorePurchaseApp"
    "Microsoft.Office.Todo.List"                        # Issue 77
    "Microsoft.Whiteboard"                              # Issue 77
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
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
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Spotify"                                           # Issue 123
    "Minecraft"
    "Royal Revolt"
    "Sway"                                              # Issue 77
    "Dolby"                                             # Issue 78

    #Optional: Typically not removed but you can if you need to for some reason
    #"Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe"
    #"Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe"
    #"Microsoft.BingWeather"
)

#$Windows10AppsFolder = Get-Item -path "C:\Program Files\WindowsApps\*"
foreach ($Bloat in $Bloatware) {
    
    #$Apps = $App.Trim("C:\Program Files\WindowsApps\")
    $ListBox1.Items.Add($Bloat)
    $ListBox1.Sorted = $True
    
}

$Button = [Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [Windows.MessageBoxImage]::Error
$Warn = [Windows.MessageBoxImage]::Warning

$Ask = 'Do you want to create a System Restore Point?
        Select "Yes" to create a System Restore Point
        Select "No" to not create a System Restore Point
        
        Select "Cancel" to stop the script.'


$SelectedBloatware = $ListBox1.SelectedItems
$Button1.Add_Click( {

$Prompt1 = [Windows.MessageBox]::Show($Ask, "Create a System Restore Point?", $Button, $ErrorIco) 
Switch ($Prompt1) {
    Yes {
$TextBox1.AppendText("Creating System Restore point. Please wait...

")
Checkpoint-Computer -Description "Before using W10DebloaterGUI.ps1" -Verbose

        

        ForEach ($Selected in $SelectedBloatware) {
            $TextBox1.AppendText("Trying to remove $Selected...
")

            Try {
                If (Test-Path "C:\Program Files\WindowsApps\*$Selected*") {
                    Get-AppxPackage | Where-Object { ($_.Name -match $Selected) } | Remove-AppxPackage
                    Get-AppxProvisionedPackage -Online | Where-Object { ($_.Name -match $Selected) } | Remove-AppxProvisionedPackage -Online
                    Get-AppxPackage -AllUsers | Where-Object { ($_.Name -match $Selected) } | Remove-AppxPackage

                    $TextBox1.AppendText("Successfully removed $Selected!
                    
")
                }
                Else {
    
                    If (!(Test-Path "C:\Program Files\WindowsApps\*$Selected*")) {
                        $TextBox1.AppendText("$Selected doesn't exist on this machine! 

")
                    }
          
                }

            }

            Catch {
                $TextBox1.AppendText("$_")
    
            }
        }
    
    }

    No {
        
        Break
    
    }
  }
} )


$Button2.Add_Click( { 

        If ($CheckBox1.Checked) {
    
            $Textbox1.AppendText("Re-enabling Cortana to be used in your Windows Search")
            $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            If (Test-Path $Search) {
                Set-ItemProperty $Search  AllowCortana -Value 1 
            } 
    
        }

        If ($CheckBox2.Checked) {
    
            Write-Host "Stopping Cortana from being used as part of your Windows Search Function"
            $Search = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
            If (Test-Path $Search) {
                Set-ItemProperty $Search AllowCortana -Value 0
            }
        }

        If ($CheckBox3.Checked) {
    
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
        
                    Remove-item env:OneDrive
                })
    
    
        }
    
        If ($CheckBox4.Checked) {
    
            #Credit to Vikingat-Rage
            #https://superuser.com/questions/1068382/how-to-remove-all-the-tiles-in-the-windows-10-start-menu
            #Unpins all tiles from the Start Menu
            Write-Host "Unpinning all tiles from the start menu"
            (New-Object -Com Shell.Application).
            NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
            Items() |
            % { $_.Verbs() } |
            ? { $_.Name -match 'Un.*pin from Start' } |
            % { $_.DoIt() }
    
        } 

    } )

[void]$Form.ShowDialog()
