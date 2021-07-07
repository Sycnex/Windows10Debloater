#   Description:
# This script disables unwanted Windows services. If you do not want to disable
# certain services comment out the corresponding lines below. like this #use hastag to comment

$services = @(
    "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                    # Diagnostics Tracking Service
    "dmwappushservice"                             # WAP Push Message Routing Service (see known issues)
    "lfsvc"                                        # Geolocation Service
    "MapsBroker"                                   # Downloaded Maps Manager
    "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
    "RemoteAccess"                                 # Routing and Remote Access
    "RemoteRegistry"                               # Remote Registry
    "SharedAccess"                                 # Internet Connection Sharing (ICS)
    "TrkWks"                                       # Distributed Link Tracking Client
    "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
    #"WlanSvc"                                      # WLAN AutoConfig
    "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
    "wscsvc"                                       # Windows Security Center Service
    "WSearch"                                      # Windows Search
    "XblAuthManager"                               # Xbox Live Auth Manager
    "XblGameSave"                                  # Xbox Live Game Save Service
    "XboxNetApiSvc"                                # Xbox Live Networking Service
    "XboxGipSvc"                                   #Disables Xbox Accessory Management Service
    "ndu"                                          # Windows Network Data Usage Monitor
    "WerSvc"                                       #disables windows error reporting
    "Spooler"                                      #Disables your printer
    "Fax"                                          #Disables fax
    "fhsvc"                                        #Disables fax histroy
    "gupdate"                                      #Disables google update
    "gupdatem"                                     #Disable another google update
    "stisvc"                                       #Disables Windows Image Acquisition (WIA)
    "AJRouter"                                     #Disables (needed for AllJoyn Router Service)
    "MSDTC"                                        # Disables Distributed Transaction Coordinator
    "WpcMonSvc"                                    #Disables Parental Controls
    "PhoneSvc"                                     #Disables Phone Service(Manages the telephony state on the device)
    "PrintNotify"                                  #Disables Windows printer notifications and extentions
    "PcaSvc"                                       #Disables Program Compatibility Assistant Service
    "WPDBusEnum"                                   #Disables Portable Device Enumerator Service
    "LicenseManager"                               #Disable LicenseManager(Windows store may not work properly)
    "seclogon"                                     #Disables  Secondary Logon(disables other credentials only password will work)
    "SysMain"                                      #Disables sysmain
    "lmhosts"                                      #Disables TCP/IP NetBIOS Helper
    "wisvc"                                        #Disables Windows Insider program(Windows Insider will not work)
    "FontCache"                                    #Disables Windows font cache
    "RetailDemo"                                   #Disables RetailDemo whic is often used when showing your device
    "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
    #"BFE"                                         #Disables Base Filtering Engine (BFE) (is a service that manages firewall and Internet Protocol security)
    #"BrokerInfrastructure"                         #Disables Windows infrastructure service that controls which background tasks can run on the system.
    "SCardSvr"                                      #Disables Windows smart card
    "EntAppSvc"                                     #Disables enterprise application management.
    "BthAvctpSvc"                                   #Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
    #"FrameServer"                                   #Disables Windows Camera Frame Server(this allows multiple clients to access video frames from camera devices.)
    "Browser"                                       #Disables computer browser
    "BthAvctpSvc"                                   #AVCTP service (This is Audio Video Control Transport Protocol service.)
    "BDESVC"                                        #Disables bitlocker
    "iphlpsvc"                                      #Disables ipv6 but most websites don't use ipv6 they use ipv4     
    "edgeupdate"                                    # Disables one of edge update service  
    "MicrosoftEdgeElevationService"                 # Disables one of edge  service 
    "edgeupdatem"                                   # disbales another one of update service (disables edgeupdatem)                          
    "SEMgrSvc"                                      #Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
    #"PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
    #"p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
    #"p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
    "PerfHost"                                      #Disables  remote users and 64-bit processes to query performance .
    "BcastDVRUserService_48486de"                   #Disables GameDVR and Broadcast   is used for Game Recordings and Live Broadcasts
    "CaptureService_48486de"                        #Disables ptional screen capture functionality for applications that call the Windows.Graphics.Capture API.  
    "cbdhsvc_48486de"                               #Disables   cbdhsvc_48486de (clipboard service it disables)
    "BluetoothUserService_48486de"                  #disbales BluetoothUserService_48486de (The Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.)
    "WpnService"                                    #Disables WpnService (Push Notifications may not work )
    #"StorSvc"                                       #Disables StorSvc (usb external hard drive will not be reconised by windows)
    "RtkBtManServ"                                  #Disables Realtek Bluetooth Device Manager Service
    "QWAVE"                                         #Disables Quality Windows Audio Video Experience (audio and video might sound worse)
     #Hp services
    "HPAppHelperCap"
    "HPDiagsCap"
    "HPNetworkCap"
    "HPSysInfoCap"
    "HpTouchpointAnalyticsService"
    #hyper-v services
     "HvHost"                          
    "vmickvpexchange"
    "vmicguestinterface"
    "vmicshutdown"
    "vmicheartbeat"
    "vmicvmsession"
    "vmicrdv"
    "vmictimesync" 
    # Services which cannot be disabled
    #"WdNisSvc"
)

foreach ($service in $services) {
    Write-Output "Trying to disable $service"
    Get-Service -Name $service | Set-Service -StartupType Disabled
}

#stop service this stop the services
Get-Service diagnosticshub.standardcollector.service | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service DiagTrack | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service dmwappushservice | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service lfsvc | Where {$_.status –eq 'Stopped'} |  Stop-Service
Get-Service MapsBroker | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service NetTcpPortSharing | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service RemoteAccess | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service RemoteRegistry | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service TrkWk | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service WbioSrvc | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service WlanSvc | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service WMPNetworkSvc | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service wscsvc | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service WSearch | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service XblAuthManager | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service XblGameSave | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service XboxNetApiSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service XboxGipSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service ndu | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service WerSvc | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service Spooler | Where {$_.status –eq 'running'} |  Stop-Service   
Get-Service Fax | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service fhsvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service gupdate | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service gupdatem | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service stisvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service AJRouter | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service MSDTC | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service WpcMonSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service PhoneSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service PrintNotify | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service PcaSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service WPDBusEnum | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service LicenseManager | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service seclogon | Where {$_.status –eq 'running'} |  Stop-Service   
Get-Service SysMain | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service lmhosts | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service wisvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service FontCache | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service RetailDemo | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service ALG | Where {$_.status –eq 'running'} |  Stop-Service 
#Get-Service BFE | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service BrokerInfrastructure | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service SCardSvr | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service EntAppSvc | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service BthAvctpSvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service BDESVC | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service iphlpsvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service edgeupdate | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service MicrosoftEdgeElevationService | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service edgeupdatem | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service SEMgrSvc | Where {$_.status –eq 'running'} |  Stop-Service 
#Get-Service PNRPsvc | Where {$_.status –eq 'running'} |  Stop-Service 
#Get-Service p2psvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service p2pimsvc | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service PerfHost | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service BcastDVRUserService_48486de | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service CaptureService_48486de | Where {$_.status –eq 'running'} |  Stop-Service 
Get-Service cbdhsvc_48486de | Where {$_.status –eq 'running'} |  Stop-Service  
Get-Service BluetoothUserService_48486de | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service WpnService | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service StorSvc | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service QWAVE | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service RtkBtManServ | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HPAppHelperCap | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HPDiagsCap | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HPNetworkCap | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HPSysInfoCap | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HpTouchpointAnalyticsService | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service HvHost | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmickvpexchange | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmicguestinterface | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmicshutdown | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmicheartbeat | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmicvmsession | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmicrdv | Where {$_.status –eq 'running'} |  Stop-Service
Get-Service vmictimesync | Where {$_.status –eq 'running'} |  Stop-Service
