Write-Output "Enabling WSL"
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Output "Set WSL2 as default"
wsl --set-default-version 2

Write-Output "You can now install your favourite linux distribution from the Microsoft Store"
Start-Process ms-windows-store
