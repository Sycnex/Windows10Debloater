Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ErrorPreference = 'SilentlyContinue'
$VerbosePreference = 'Continue'

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Windows10Debloater'
$form.Size = New-Object System.Drawing.Size(800,600)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(275,40)
$OKButton.Size = New-Object System.Drawing.Size(225,23)
$OKButton.Text = 'Remove Selected Bloatware Packages'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$RemoveKeys                = New-Object system.Windows.Forms.Button
$RemoveKeys.text           = "Remove registry keys associated with Bloatware"
$RemoveKeys.width          = 265
$RemoveKeys.height         = 23
$RemoveKeys.location       = New-Object System.Drawing.Point(275,400)
$form.Controls.Add($RemoveKeys)
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

$Form.controls.AddRange(@($WhitelistDebloat,$RemoveKeys))

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

 $RemoveKeys.Add_Click({
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
        Write-Verbose "Removing $Key from registry"
        Remove-Item $Key -Recurse
    }
Remove-Keys
}
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
[void] $listBox.Items.Add('*Windows.CBSPreview*')
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
