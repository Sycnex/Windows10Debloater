# Windows10Debloater
Script/Utility to debloat Windows 10

# This script will remove the bloatware from Windows 10 when using Remove-AppXPackage/Remove-AppXProvisionedPackage, and then delete specific registry keys that are were not removed beforehand. These registry keys are:

EclipseManager,
ActiproSoftwareLLC,
Microsoft.PPIProjection,
Microsoft.XboxGameCallableUI

You can choose to either 'Debloat' or 'Revert'. Depending on your choice, either one will run specific code to either debloat your Windows 10 machine.

The Debloat switch choice runs the following functions:

Start-Debloat,
Remove-Keys,
Protect-Privacy,
Stop-EdgePDF (If chosen)

The Revert switch choice runs the following functions:

Revert-Changes,
Enable-EdgePDF

The Revert option reinstalls the bloatware and changes your registry keys back to default. 

# The scheduled tasks that are disabled are:

XblGameSaveTaskLogon,
XblGameSaveTask,
Consolidator,
UsbCeip,
DmClient

These scheduled tasks that are disabled have absolutely no impact on the function of the OS.

# Bloatware that is removed:

3DBuilder,
Appconnector,
Bing Finance,
Bing News,
Bing Sports,
Bing Weather,
Fresh Paint,
Get started,
Microsoft Office Hub,
Microsoft Solitaire Collection,
Microsoft Sticky Notes,
OneNote,
OneConnect,
People,
Skype for Desktop,
Alarms,
Camera,
Maps,
Phone,
SoundRecorder,

XboxApp,
Zune Music,
Zune Video,
Windows communications apps,
Minecraft,
PowerBI,
Network Speed Test,
Phone,
Messaging,
Office Sway,
OneConnect,
Windows Feedback Hub,
Bing Food And Drink,
Bing Travel,
Bing Health And Fitness,
Windows Reading List,
Twitter,
Pandora,
Flipboard,
Shazam,
CandyCrush,
CandyCrushSoda,
King apps,
iHeartRadio,
Netflix,
DrawboardPDF,
PicsArt-PhotoStudio,
FarmVille 2 Country Escape,
TuneInRadio,
Asphalt8,
NYT Crossword,
CyberLink MediaSuite Essentials,
Facebook,
Royal Revolt 2,
Caesars Slots Free Casino,
March of Empires,
Phototastic Collage,
Autodesk SketchBook,
Duolingo,
EclipseManager,
ActiproSoftware,
BioEnrollment,
Windows Feedback,
Xbox Game CallableUI,
Xbox Identity Provider, and
ContactSupport.


# Purpose

I have found many different solutions online to debloat Windows 10 and many either worked but caused issues in the long run, or they did so little that it wasn't enough of a "debloat" experience. I decided to create a script that will debloat Windows 10 the way that I envision it, with the option of even being able to revert changes.

This comes in hand when setting up new Windows 10 machines without needing to manually remove the bloatware found within Windows 10, along with some "fail safe" features via the Revert-Changes function, and even stops Windows from installing the bloatware in new user profiles.

# Silent and Interactive

There are now 2 versions of my Windows10Debloater - There is an interactive version, and a pure silent version. The silent version now utilizes the switch parameter: -Debloat. The silent version can be useful for deploying MDT Images or any other way you deploy Windows 10. This will work to remove the bloatware during the deployment process.

The interactive version is what it implies - a Windows10Debloater script with interactive prompts.

# Interactive and Noninteractive switches

When you run the Windows10Debloater Script you will notice that you are given two choices: 1) Interactive which does as it implies - it is interactive to the extent that you will be asked a few questions, such as if you'd like to Debloat or Revert, stop Edge from taking over as default and asking if you'd like to reboot your machine.

2) Noninteractive will ask you only if you'd like to Debloat or Revert, and it explains that you won't be asked any further questions and that it'll show information on the screen. The default in the script for the Noninteractive switch is to not reboot the machine or stop Edge from taking over as default.

# How To Run

Download the Windows10Debloater.ps1 file. Next, copy the source code from Windows10Debloater.ps1 and throw it into PowerShell ISE.

Alternatively, download the Windows10SilentDebloater.ps1 file, place it in any directory of your choice, load PowerShell ISE or PowerShell (64-Bit), change to the directory where you placed the Windows10SilentDebloater.ps1 file, and run one (or all) of the 3 switch parameters: -SysPrep, -Debloat, and -StopEdgePDF. E.g., C:\WWindows10SilentDebloater.ps1 -SysPrep -Debloat -StopEdgePDF.

# Switch Parameters

There are 3 switch parameters in the Windows10SilentDebloater.ps1 script.

The first one is -SysPrep, which runs the command within a function: get-appxpackage | remove-appxpackage. This is useful since some administrators need that command to run first in order for machines to be able to properly provision the apps for removal.

The second switch parameter is -Debloat, which does as it suggests. It runs the following functions: Start-Debloat, Remove-Keys, and Protect-Privacy.

Start-Debloat removes all bloatware apps (that are listed above) without removing Store, Photos, Paint3d, and Calculator.

Remove-Keys removes registry keys leftover that are associated with the bloatware apps listed above, but not removed during the Start-Debloat function.

Third, Protect-Privacy adds and/or changes registry keys to stop some telemetry functions, stops Cortana from being used as your Search Index, disables "unneccessary" scheduled tasks, and more.

Finally, there is an optional switch parameter which is Stop-EdgePDF. This just stops Edge from taking over as the default PDF viewer. I made this optional since some do not find this necessary for them or their organization.

# Credit

Thank you to a60wattfish for some of the suggestions that I have placed into my scripts. 

# Donate 

If you like and appreciate my work then consider a donation for a cup of tea.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/syncrn)
