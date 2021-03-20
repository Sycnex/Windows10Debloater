#This function will revert the changes you made when running the Start-Debloat function.
        
    #This line reinstalls all of the bloatware that was removed
    Get-AppxPackage -AllUsers | ForEach {Add-AppxPackage -Verbose -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    
    #Tells Windows to enable your advertising information.    
    Write-Output "Re-enabling key to show advertisement information"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising  Enabled -Value 1
    }
            
    #Enables Cortana to be used as part of your Windows Search Function
    Write-Output "Re-enabling Cortana to be used in your Windows Search"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search  AllowCortana -Value 1 
    }
            
    #Re-enables the Windows Feedback Experience for sending anonymous data
    Write-Output "Re-enabling Windows Feedback Experience"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 1 
    
    #Enables bloatware applications               
    Write-Output "Adding Registry key to allow bloatware apps to return"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    If (!(Test-Path $registryPath)) {
        New-Item $registryPath 
    }
    Set-ItemProperty $registryPath  DisableWindowsConsumerFeatures -Value 0 
        
    #Changes Mixed Reality Portal Key 'FirstRunSucceeded' to 1
    Write-Output "Setting Mixed Reality Portal value to 1"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 1 
    }
        
    #Re-enables live tiles
    Write-Output "Enabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
    If (!(Test-Path $Live)) {
        New-Item $Live 
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 0 
       
    #Re-enables data collection
    Write-Output "Re-enabling data collection"
    $DataCollection = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    If (!(Test-Path $DataCollection)) {
        New-Item $DataCollection
    }
    Set-ItemProperty $DataCollection  AllowTelemetry -Value 1
        
    #Re-enables People Icon on Taskbar
    Write-Output "Enabling People icon on Taskbar"
    $People = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
    If (!(Test-Path $People)) {
        New-Item $People 
    }
    Set-ItemProperty $People  PeopleBand -Value 1 
    
    #Re-enables suggestions on start menu
    Write-Output "Enabling suggestions on the Start Menu"
    $Suggestions = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $Suggestions)) {
        New-Item $Suggestions
    }
    Set-ItemProperty $Suggestions  SystemPaneSuggestionsEnabled -Value 1 
        
    #Re-enables scheduled tasks that were disabled when running the Debloat switch
    Write-Output "Enabling scheduled tasks that were disabled"
    Get-ScheduledTask XblGameSaveTaskLogon | Enable-ScheduledTask 
    Get-ScheduledTask  XblGameSaveTask | Enable-ScheduledTask 
    Get-ScheduledTask  Consolidator | Enable-ScheduledTask 
    Get-ScheduledTask  UsbCeip | Enable-ScheduledTask 
    Get-ScheduledTask  DmClient | Enable-ScheduledTask 
    Get-ScheduledTask  DmClientOnScenarioDownload | Enable-ScheduledTask 

    Write-Output "Re-enabling and starting WAP Push Service"
    #Enable and start WAP Push Service
	Set-Service "dmwappushservice" -StartupType Automatic
    Start-Service "dmwappushservice"
    
    Write-Output "Re-enabling and starting the Diagnostics Tracking Service"
    #Enabling the Diagnostics Tracking Service
	Set-Service "DiagTrack" -StartupType Automatic
	Start-Service "DiagTrack"
	
#	# Re-Enable the showing of last used files and folders (luff)
#    Write-Output "Re-enabling keys to show last used files and folders"
#	$luffKeys = @(
#		"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}"
#		"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}"
#	)
#	ForEach ($luffKey in $luffKeys) {
#		If (! (Test-Path $lastUsedFiles)) {
#			Write-Output "Adding $luffKey to registry"
#			New-Item $luffKey
#		}
#    }
#    Write-Output "Re-enabling explorer to show last used files and folders"
#	$explorerLastUsed = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
#	Set-ItemProperty $explorerLastUsed HubMode -Value 0
#	
#	# Re-Enable AeroShake
#	Write-Output "Re-enabling AeroShake"
#	$aeroShake = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
#	Set-ItemProperty $aeroShake NoWindowMinimizingShortcuts -Value 0
#	
#	# Re-Locate Explorer LaunchTo
#	Write-Output "Re-Locate the Explorers Launch To (Entry Point)"
#	$LaunchTo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
#	Set-ItemProperty $LaunchTo LaunchTo -Value 2
