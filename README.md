# Windows10Debloater
Script/Utility/Application to debloat Windows 10

# How To Run the Windows10Debloater.ps1 and the Windows10DebloaterGUI.ps1 files

There are different methods of running the PowerShell script. The methods are as follows:

First Method:

1) Download the .zip file on the main page of the github and extract the .zip file to your desired location
2) Once extracted, open PowerShell (or PowerShell ISE) as an Administrator
3) Enable PowerShell execution
<code>Set-ExecutionPolicy Unrestricted</code>
4) Ubnlock all powershell script
<code>ls -Recurse *.ps1 | Unblock-File</code>
5) On the propmt, change to the directory where you extracted the files:
  e.g. - cd c:\temp
6) Next, to run either script, enter in the following:
  e.g. - .\Windows10DebloaterGUI.ps1
  

Second Method:

1) Download the .zip file on the main page of the github and extract the .zip file to your desired location
2) Right click the PowerShell file that you'd like to run and click on "Run With PowerShell"
3) This will allow the script to run without having to do the above steps


Third Method:

This method has an issue because my script will launch a PowerShell session as an Administrator if you didn't do so, and if you didn't then this method won't work properly unless you remove the code at the very top that does this.

1) Download the .zip file on the main page of the github and extract the .zip file to your desired location
2) Open the files and copy and paste the source code into either PowerShell.exe or PowerShell ISE.
3) Click "RUN" (or F5) and the script will run


# How To Run the Windows10SysPrepDebloater.ps1 file

For the WindowsSysPrepDebloater.ps1 file, there are a couple of paramters that you can run so that you can specify which functions are used. The parameters are:
-SysPrep, -Debloat, and -StopEdgePDF. 

To run this with parameters, do the following:

1) Download the .zip file on the main page of the github and extract the .zip file to your desired location
2) Once extracted, open PowerShell (or PowerShell ISE) as an Administrator
3) On the propmt, change to the directory where you extracted the files:
  e.g. - cd c:\temp
4) Next, to run either script, enter in the following:
  e.g. - .\Windows10SysPrepDebloater.ps1 -Sysprep, -Debloat -Privacy and -StopEdgePDF
  

# Sysprep, Interactive, and GUI Application

There are now 3 versions of my Windows10Debloater - There is an interactive version, a GUI app version, and a pure silent version.

Windows10SysPrepDebloater.ps1 - The silent version now utilizes the switch parameters: -Sysprep, -Debloat -Privacy and -StopEdgePDF. The silent version can be useful for deploying MDT Images/sysprepping or any other way you deploy Windows 10. This will work to remove the bloatware during the deployment process.

Windows10Debloater.ps1 - This interactive version is what it implies - a Windows10Debloater script with interactive prompts. This one should not be used for deployments that require a silent script with optional parameters. This script gives you choices with prompts as it runs so that you can make the choices of what the script does.

Windows10DebloaterGUI.ps1 There is now a GUI Application named Windows10DebloaterGUI.ps1 with buttons to perform all of the functions that the scripts do. This is better for the average user who does not want to work with code, or if you'd prefer to just see an application screen. 

# Switch Parameters

There are 3 switch parameters in the Windows10SysPrepDebloater.ps1 script.

The first one is -SysPrep, which runs the command within a function: get-appxpackage | remove-appxpackage. This is useful since some administrators need that command to run first in order for machines to be able to properly provision the apps for removal.

The second switch parameter is -Debloat, which does as it suggests. It runs the following functions: Start-Debloat, Remove-Keys, and Protect-Privacy.

Remove-Keys removes registry keys leftover that are associated with the bloatware apps listed above, but not removed during the Start-Debloat function.

Third, Protect-Privacy adds and/or changes registry keys to stop some telemetry functions, stops Cortana from being used as your Search Index, disables "unneccessary" scheduled tasks, and more.

Finally, there is an optional switch parameter which is Stop-EdgePDF. This just stops Edge from taking over as the default PDF viewer. I made this optional since some do not find this necessary for them or their organization.

# This script will remove the bloatware from Windows 10 when using Remove-AppXPackage/Remove-AppXProvisionedPackage, and then delete specific registry keys that are were not removed beforehand. For best results, this script should be ran before a user profile is configured, otherwise you will likely see that apps that should have been removed will remain, and if they are removed you will find broken tiles on the start menu.

These registry keys are:

EclipseManager,
ActiproSoftwareLLC,
Microsoft.PPIProjection,
Microsoft.XboxGameCallableUI

You can choose to either 'Debloat' or 'Revert'. Depending on your choice, either one will run specific code to either debloat your Windows 10 machine.

The Debloat switch choice runs the following functions:

Debloat,
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

# Credit

Thank you to a60wattfish, abulgatz, xsisbest, Damian, Vikingat-RAGE, and Reddit user /u/GavinEke for some of the suggestions and fixes that I have placed into my scripts. You all have done a fantastic job!
