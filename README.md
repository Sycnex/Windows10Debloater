
# Windows10Debloater
Script/Utility/Application to debloat, optimize and tweak Windows 10


# Methods to Run Windows10Debloater

There are different methods of running the Windows10Debloater:
* with GUI (**recommended**)
* Interactive (Commandline)
* SysPrep (Silence)

The GUI-Method offers you a simple GUI where you just select your tasks of choice.
The Interactive-Method guides you thru all the options - in the console.
The SysPrep-Method, is a complete silence way.


# How to Run Windows10Debloater

1. Download the .zip file from the main page and extract it to your desired location.
2. Once extracted, start you favorite method by using one of the following batch-files:

* Start_GUI.bat (**recommended**)
* Start_NOGUI.bat (Interactive-Method)
* Start_SysPrep.bat (Silence)


# Switch Parameters

There are 3 switch parameters in the `Windows10SysPrepDebloater.ps1` script.

The first one is `-SysPrep`, which runs the command within a function: `get-appxpackage | remove-appxpackage`. This is useful since some administrators need that command to run first in order for machines to be able to properly provision the apps for removal.

The second switch parameter is `-Debloat`, which does as it suggests. It runs the following functions: Start-Debloat, Remove-Keys, and Protect-Privacy.

Remove-Keys removes registry keys leftover that are associated with the bloatware apps listed above, but not removed during the Start-Debloat function.

Third, Protect-Privacy adds and/or changes registry keys to stop some telemetry functions, stops Cortana from being used as your Search Index, disables "unneccessary" scheduled tasks, and more.

**This script will remove the bloatware from Windows 10 when using `Remove-AppXPackage`/`Remove-AppXProvisionedPackage`, and then delete specific registry keys that are were not removed beforehand. For best results, this script should be ran before a user profile is configured, otherwise you will likely see that apps that should have been removed will remain, and if they are removed you will find broken tiles on the start menu.**

## These registry keys are:

* ActiproSoftwareLLC,
* EclipseManager,
* Microsoft.PPIProjection,
* Microsoft.XboxGameCallableUI

You can choose to either 'Debloat' or 'Revert'. Depending on your choice, either one will run specific code to either debloat your Windows 10 machine.

**The Debloat switch choice runs the following functions:**

* Debloat
* Protect-Privacy
* Remove-Keys
* Stop-EdgePDF (If chosen)

**The Revert switch choice runs the following functions:**

* Enable-EdgePDF
* Revert-Changes

The Revert option reinstalls the bloatware and changes your registry keys back to default. 

# The scheduled tasks that are disabled are:

* Consolidator
* DmClient
* UsbCeip
* XblGameSaveTask
* XblGameSaveTaskLogon

These scheduled tasks that are disabled have absolutely no impact on the function of the OS.

# Bloatware that is removed:

* 3DBuilder
* ActiproSoftware
* Alarms
* Appconnector
* Asphalt8
* Autodesk SketchBook
* Bing Finance
* Bing Food And Drink
* Bing Health And Fitness
* Bing News
* Bing Sports
* Bing Travel
* Bing Weather
* BioEnrollment
* Caesars Slots Free Casino
* Camera
* CandyCrush
* CandyCrushSoda
* ContactSupport
* CyberLink MediaSuite Essentials
* DrawboardPDF
* Duolingo
* EclipseManager
* Facebook
* FarmVille 2 Country Escape
* Flipboard
* Fresh Paint
* Get started
* iHeartRadio
* King apps
* Maps
* March of Empires
* Messaging
* Microsoft Office Hub
* Microsoft Solitaire Collection
* Microsoft Sticky Notes
* Minecraft
* NYT Crossword
* Netflix
* Network Speed Test
* Office Sway
* OneConnect
* OneNote
* Pandora
* People
* Phone
* Phototastic Collage
* PicsArt-PhotoStudio
* PowerBI
* Royal Revolt 2
* Shazam
* Skype for Desktop
* SoundRecorder
* TuneInRadio
* Twitter
* Windows Feedback
* Windows Feedback Hub
* Windows Reading List
* Windows communications apps
* Xbox Game CallableUI
* Xbox Identity Provider
* XboxApp
* Zune Music
* Zune Video

# Quick Download Link

`iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))`

# Refactoring requiered
The code needs a whole refactoring. Many functions are doubled thru all the different execude-methods. That makes it even harder to add new functionallity.
There should also be only one start script, preffered in PowerShell instead of Batch. Start different modes by using different parameters.
Additionally the individual scripts should end on `.ps1`.

# Credits

Thank you to a60wattfish, abulgatz, Damian, Norrodar, Vikingat-RAGE, xsisbest and Reddit user /u/GavinEke for some of the suggestions and fixes that I have placed into my scripts. You all have done a fantastic job!
