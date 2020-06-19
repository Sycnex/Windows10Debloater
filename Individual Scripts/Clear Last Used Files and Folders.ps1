Write-Host "Clear last used files and folders"
	Remove-Item %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*.automaticDestinations-ms -FORCE -ErrorAction SilentlyContinue