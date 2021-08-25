echo off
color F0
title Block All Telemetry
mode con: cols=82 lines=21

cls
echo Batch script created by EverythingTech!
timeout 3 > nul

:menu
cls
echo If you would like to continue, type in "yes". If not, then type in "no".
echo If you would like to revert, type in "revert".
echo Input your answer below:
set /p a=
if "%a%" == "yes" goto :block
if "%a%" == "revert" goto :unblock
if "%a%" == "info" goto :info
if "%a%" == "no" goto :exit
cls

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to menu.
timeout 2 > nul
goto :menu

:block
netsh advfirewall firewall add rule name="Block Windows Telemetry" dir=in action=block remoteip=134.170.30.202,137.116.81.24,157.56.106.189,184.86.53.99,2.22.61.43,2.22.61.66,204.79.197.200,23.218.212.69,65.39.117.23,65.55.108.23,64.4.54.254 enable=yes > nul
netsh advfirewall firewall add rule name="Block NVIDIA Telemetry" dir=in action=block remoteip=8.36.80.197,8.36.80.224,8.36.80.252,8.36.113.118,8.36.113.141,8.36.80.230,8.36.80.231,8.36.113.126,8.36.80.195,8.36.80.217,8.36.80.237,8.36.80.246,8.36.113.116,8.36.113.139,8.36.80.244,216.228.121.209 enable=yes > nul 
cls
echo Telemetry Sucessfully blocked!
timeout 2 > nul
cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:unblock
netsh advfirewall firewall delete rule name="Block Windows Telemetry" > nul
netsh advfirewall firewall delete rule name="Block NVIDIA Telemetry" > nul
cls
echo Telemetry Sucessfully unblocked!
timeout 2 > nul
cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit
