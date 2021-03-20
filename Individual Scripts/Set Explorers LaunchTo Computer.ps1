# "This Computer"-Button starts the explorer on the following path:
# 	LaunchTo	Value	Description
#				1 		Computer (Harddrives, Network, etc.)
#				2 		Fast Access
#				3 		Downloads (The Download-Folder)

Write-Host "Set Explorers Entry Point"
	$LaunchTo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
	Set-ItemProperty $LaunchTo LaunchTo -Value 1