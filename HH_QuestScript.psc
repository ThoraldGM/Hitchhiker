Scriptname HH_QuestScript extends Quest Conditional
{ It just works. }

;/

Fallout 4 Papyrus script by ThoraldGM | https://modforge.net | Updated 20180201
Hitchhiker mod: https://www.nexusmods.com/fallout4/mods/29273

Script refactoring and holotape added by BigAndFlabby 20180129
Refactoring changelog (noted by TGM):
- Added holotape, streamlined code into structs, maximized efficiency
- Used markers in destination arrays instead of mixing markers, static navbumps, and CenterOnCell
- Removed all trace of CenterOnCell, MoveToNearestNavmeshLocation, and set XYZ offsets code
- Teleports should now work on Xbox consoles. Version 2.0 will be published on Nexus and Beth PC/Xbox pages

I was a Telnet MUD LPC programmer 20 years ago (Torvald @ Mystic). My last college programming course was 15 years ago.
Thanks BigAndFlabby for teaching me current best practices and helping me to level up!

SCRIPT SECTIONS:

LINE 0058: PROPERTIES
LINE 0387: ON QUEST INIT
LINE 0396: HH INIT MOD
LINE 0420: HH BUILD GO FILES ARRAY
LINE 0438: HH BUILD TELEPORT STRUCTS
LINE 0456: HH BUILD TELEPORT DATA
LINE 0467: HH BUILD DESTINATION ARRAYS
LINE 0740: HH START HITCHING
LINE 0754: ON MENU OPEN CLOSE EVENT
LINE 0767: HH HANDLER TELEPORT ON PIP BOY CLOSE
LINE 0876: (OPTIONAL AUTO TIME CHANGE)
LINE 0884: (OPTIONAL AUTO WEATHER CHANGE)
LINE 0910: ON TIMER
LINE 0932: HH REMOVE FALL PERK
LINE 0944: HH SPIN CAMERA
LINE 0973: HH STOP SPINNING
LINE 0996: HH CHECK DESTINATION PLUGIN
LINE 1005: HH SET RANDOM DESTINATION
LINE 1093: HH TRY TO USE FURNITURE
LINE 1113: HH FORCE TIME
LINE 1146: HH FORCE WEATHER
LINE 1178: HH MARK TALES ON MAP
LINE 1213: ON PLAYER LOAD GAME
LINE 1222: HH CHECK DLCS
LINE 1233: HH CHECK CHOICE CHOPPED
LINE 1241: HH CALCULATE REWARDS
LINE 1385: HH DEBUG TRACE BOX
LINE 1395: HH ENABLE DEBUG
LINE 1403: HH DISABLE DEBUG
LINE 1411: HH DISABLE PLAYER CONTROLS
LINE 1420: HH ENABLE PLAYER CONTROLS
LINE 1428: VALIDATE DATA
LINE 1448: VALIDATE DATA HELPER

/;

; ------------------------------------------------------------------------------------------------------------
; PROPERTIES
; ------------------------------------------------------------------------------------------------------------

; ************************************************************************************************************
; Player menu options:
; ************************************************************************************************************
Group CameraSettings
    GlobalVariable Property HH_OptionCamMaxDistance Auto Mandatory
    { Max camera distance (default: 200, vanilla: 150) }
    GlobalVariable Property HH_OptionCamMinDistance Auto Mandatory
    { Min camera distance (default: 100, vanilla: 0) }
    GlobalVariable Property HH_OptionSpinCamera Auto Mandatory
    { Does player want teleport to spin camera? (default: yes) }
    GlobalVariable Property HH_OptionSpinDuration Auto Mandatory
    { How long should camera spin? (default: 20 seconds) }
    GlobalVariable Property HH_OptionSpinGhost Auto Mandatory
    { Does player want invulnerable spin? (default: yes) }
EndGroup

Group TeleportSettings
    GlobalVariable Property HH_OptionFastTravel Auto Mandatory
    { Does player want loading screens? (default: yes) }
    GlobalVariable Property HH_OptionHeal Auto Mandatory
    { Does player want to heal after teleport? (default: no) }
    GlobalVariable Property HH_OptionSetRewards Auto Mandatory
    { How many hitches per category trigger rewards? (default: 5) }
    GlobalVariable Property HH_OptionSetTime Auto Mandatory
    { Change time after teleport? (default: no) }
    GlobalVariable Property HH_OptionSetTimePreference Auto Mandatory
    { Preferred game hour (player sets in menu) }
    GlobalVariable Property HH_OptionSetWeather Auto Mandatory
    { Change weather after teleport? (default: no) }
    GlobalVariable Property HH_OptionSetWeatherPreference Auto Mandatory
    { Preferred game weather (player sets in menu) }
    GlobalVariable Property HH_OptionSitFurniture Auto Mandatory
    { If destination is furniture, choose whether to use it (default: yes) }
    GlobalVariable Property HH_OptionTeleportSound Auto Mandatory
    { Does player want teleport sound? (default: yes) }
    GlobalVariable Property HH_OptionVaultBoy Auto Mandatory
    { Does player want Vault Boy animations? (default: yes) }
    Sound Property DRSVertibirdFlightLoadOpen Auto Const Mandatory
    { Teleport start sound effect }
    Sound Property OBJHijackerTeleportOut2DA Auto Const Mandatory
    { Teleport end sound effect }
EndGroup

; ************************************************************************************************************
; Weather:
; ************************************************************************************************************
Group Weathers
    Weather Property DefaultWeather Auto Const Mandatory
    { Default weather (outdoors) }
    Weather Property CommonwealthClear Auto Const Mandatory
    { Clear }
    Weather Property CommonwealthDusty Auto Const Mandatory
    { Dusty }
    Weather Property CommonwealthFoggy Auto Const Mandatory
    { Foggy }
    Weather Property CommonwealthMisty Auto Const Mandatory
    { Misty }
    Weather Property CommonwealthMistyRainy Auto Const Mandatory
    { Misty Rainy }
    Weather Property CommonwealthOvercast Auto Const Mandatory
    { Overcast }
    Weather Property CommonwealthGSRadstorm Auto Const Mandatory
    { Radstorm }
    Weather Property CommonwealthRain Auto Const Mandatory
    { Rain }
EndGroup

; ************************************************************************************************************
; Rewards:
; ************************************************************************************************************
Group Rewards
    GlobalVariable Property HH_SpecialRewardWait Auto Const Mandatory
    { how long to wait after spin camera or teleport finish before rewarding special locations. }
    GlobalVariable Property HH_NormalRewardWait Auto Const Mandatory
    { how long to wait for giving normal reward. }

    GlobalVariable Property HH_CountAll Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountRandom Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountSpecific Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountBus Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountDiner Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountDive Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountDrive Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountFactory Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountFarm Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountJunkyard Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountMilitary Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountMonument Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountPower Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountRed Auto Mandatory
    { Visit tracking }
    GlobalVariable Property HH_CountVault Auto Mandatory
    { Visit tracking }

    GlobalVariable Property HH_VisitedDrumlin1 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedDrumlin2 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedDrumlin3 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedDrumlin4 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedDrumlin5 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSlocums1 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSlocums2 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSlocums3 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSlocums4 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSpuckies1 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSpuckies2 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSpuckies3 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSuper1 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSuper2 Auto Mandatory
    { Corporate visit tracking }
    GlobalVariable Property HH_VisitedSuper3 Auto Mandatory
    { Corporate visit tracking }

    GlobalVariable Property HH_Rewarded_Bus Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Diner Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Dive Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Drive Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Drumlin Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Factory Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Farm Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Junkyard Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Military Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Monument Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Power Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Prost Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Recipe Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Red Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Skybox Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Slocums Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Spuckies Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Super Auto Mandatory
    { Reward tracking }
    GlobalVariable Property HH_Rewarded_Vault Auto Mandatory
    { Reward tracking }

    LeveledItem Property HH_Rewards_Bus Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Diner Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Dive Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Drive Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Drumlin Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Factory Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Farm Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Junkyard Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Military Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Monument Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Power Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Prost Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Red Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Skybox Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Slocums Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Spuckies Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Super Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Thanks Auto Mandatory
    { Rewards }
    LeveledItem Property HH_Rewards_Vault Auto Mandatory
    { Rewards }
EndGroup

; ************************************************************************************************************
; Other CK Properties:
; ************************************************************************************************************
GlobalVariable Property HH_OptionExcludeFH Auto Mandatory
{ Turn Far Harbor DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeNW Auto Mandatory
{ Turn Nuka-World DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeVT Auto Mandatory
{ Turn Vault-Tec DLC on/off in destinations (default: off) }
GlobalVariable Property HH_IsSpinning Auto Mandatory
{ Is the camera currently spinning? }
GlobalVariable Property HH_Category Auto Mandatory
{ Which category did player select? }
GlobalVariable Property HH_TargetID Auto Mandatory
{ Which location did player select? }
GlobalVariable Property pGameHour Auto Mandatory
{ Current game hour (from vanilla CK) }
Perk Property HH_TeleportNoFallDamage Auto Const Mandatory
{ Temp perk so teleport falls don't kill player }
ReferenceAlias Property PlayerRefAlias Auto Const Mandatory
{ Player Reference Alias in HH_Quest }

; ************************************************************************************************************
; Non-CK Variables Defined "Globally"
; ************************************************************************************************************
Actor Player                                                                    ; Player actor

; ************************************************************************************************************
; Category Constants
; ************************************************************************************************************

Int BUS_SHELTERS = 1 const                                                      ; Category ints (makes code easier to read)
Int DINERS  = 2 const
Int DIVES = 3 const
Int DRIVE_INS = 4 const
Int FACTORIES = 5 const
Int FARMS = 6 const
Int JUNKYARDS = 7 const
Int MILITARY_BASES = 8 const
Int MONUMENTS = 9 const
Int POWER_LIFTS = 10 const
Int RED_ROCKETS = 11 const
Int VAULTS = 12 const

; ************************************************************************************************************
; Timer ID Constants
; ************************************************************************************************************

Int HH_TIMER_STOPSPINNING = 1 const
Int HH_TIMER_REMOVEFALLPERK = 2 const
Int HH_TIMER_CALCULATEREWARDS = 3 const
Int HH_TIMER_REWARDS_SKYBOX = 4 const
Int HH_TIMER_REWARDS_PROST = 5 const
Int HH_TIMER_INITMOD = 6 const

; ************************************************************************************************************
; Data Structs
; ************************************************************************************************************

Struct TargetObjectStruct
    String Go_File
    Int TargetID
EndStruct

Struct GoStructTeleports
    Int teleportTarget
    Int teleportGoFile
    Int furnitureTarget
    Int furnitureGoFile
    GlobalVariable extraMonitor
    GlobalVariable SpecialRewardGlobal
    Int SpecialRewardTimer
EndStruct

Struct GoFileStruct
    String Name
EndStruct

GoStructTeleports[] DestGo_Bus                                                  ; Destination category arrays
GoStructTeleports[] DestGo_Diner
GoStructTeleports[] DestGo_Dive
GoStructTeleports[] DestGo_Drive
GoStructTeleports[] DestGo_Factory
GoStructTeleports[] DestGo_Farm
GoStructTeleports[] DestGo_Junkyard
GoStructTeleports[] DestGo_Military
GoStructTeleports[] DestGo_Monument
GoStructTeleports[] DestGo_Power
GoStructTeleports[] DestGo_Red
GoStructTeleports[] DestGo_Vault


GoFileStruct[] Go_Files                                                         ; array of plugin filenames for use with teleport ids
Int Go_File_FO4   = 0 const                                                     ; Ids to be used for indexes and mapping of plugin names
Int Go_File_HH    = 1 const
Int Go_File_NW    = 2 const
Int Go_File_FH    = 3 const
Int Go_File_VT    = 4 const

bool bHH_PlayerHasFH conditional                                                ; conditional variable check for menus
bool bHH_PlayerHasNW conditional                                                ; conditional variable check for menus
bool bHH_PlayerHasVT conditional                                                ; conditional variable check for menus
bool bHH_PlayerHasChoiceChopped conditional                                     ; conditional variable check for menus
bool bHH_OptionDevTracking conditional                                          ; conditional variable check for menus

InputEnableLayer layerDisableControls                                           ; Inputlayer to support disabling player controls to prevent odd behavior


; ------------------------------------------------------------------------------------------------------------
; EVENT: ON QUEST INIT
; ------------------------------------------------------------------------------------------------------------

Event OnQuestInit()
    Player = PlayerRefAlias.GetActorRef()                                       ; Player actor
    StartTimer(0.1, HH_TIMER_INITMOD)                                           ; Trigger callback to start initialization
EndEvent

; ------------------------------------------------------------------------------------------------------------
; HH INIT MOD: Dummy state to keep init function from running in multiple threads
; ------------------------------------------------------------------------------------------------------------

State Working
    Function HH_InitMod()
        ; nothing
    EndFunction
EndState

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_InitMod
; ------------------------------------------------------------------------------------------------------------

Function HH_InitMod()
    GotoState("Working")                                                        ; set dummy state to intercept any init calls while we're already working

    HH_Build_Destination_Arrays()                                               ; Setup the teleport destination arrays.
    HH_Check_DLCS()

    RegisterForRemoteEvent(PlayerRefAlias.GetActorRef(), "OnPlayerLoadGame")    ; Will do mod checks on every game load
    GoToState("")
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_Build_GoFiles_Array
; ------------------------------------------------------------------------------------------------------------

Function HH_Build_GoFiles_Array()
    Go_Files = new GoFileStruct[5]
    int iCounter = 0
    while iCounter < Go_Files.length
        Go_Files[iCounter] = new GoFileStruct
        iCounter += 1
    endWhile
    Go_Files[Go_File_FO4].Name = "Fallout4.esm"
    Go_Files[Go_File_HH].Name = "Hitchhiker.esp"
    Go_Files[Go_File_NW].Name = "DLCNukaWorld.esm"
    Go_Files[Go_File_FH].Name = "DLCCoast.esm"
    Go_Files[Go_File_VT].Name = "DLCworkshop03.esm"
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_Build_TeleportStructs
; ------------------------------------------------------------------------------------------------------------

GoStructTeleports[] Function HH_Build_TeleportStructs(int iCount = 0)
    ; ------------------------------------------------------------------------------------------------------------
    ; Initialize an array with given size and create empty entries with data structures then return it
    ; ------------------------------------------------------------------------------------------------------------

    GoStructTeleports[] Data = New GoStructTeleports[iCount]
    int iCounter=0
    while iCounter < Data.length
        Data[iCounter] = new GoStructTeleports
        iCounter += 1
    endWhile
    Return Data
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_Build_TeleportData
; ------------------------------------------------------------------------------------------------------------

Function HH_Build_TeleportData(Int iIndex, GoStructTeleports[] Data, Int iTeleportTarget, Int iTeleportGoFile, Int iFurnitureTarget, Int iFurnitureGoFile)
    Data[iIndex].furnitureTarget = iFurnitureTarget
    Data[iIndex].furnitureGoFile = iFurnitureGoFile
    Data[iIndex].teleportTarget = iTeleportTarget
    Data[iIndex].teleportGoFile = iTeleportGoFile
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_Build_Destination_Arrays
; ------------------------------------------------------------------------------------------------------------

Function HH_Build_Destination_Arrays()
    HH_Build_GoFiles_Array()

    ; ********************************************************************************************************
    ; Initialize the destination arrays (hex refIDs converted to decimal)
    ; ********************************************************************************************************

    ; use 0x0 for the furniture marker ref id if there is no furniture to attempt to use at the location.
    ; using a ref id will still cause a validation check to confirm it is a furniture type.

    ; syntax: HH_Build_TeleportData(iIndex, Data, iTeleportTarget, iTeleportGoFile, iFurnitureTarget, iFurnitureGoFile)
    DestGo_Bus = HH_Build_TeleportStructs(10)
    HH_Build_TeleportData( 0, DestGo_Bus, 0x016e35, Go_File_HH, 0x176407, Go_File_FO4)         ; College Square
    HH_Build_TeleportData( 1, DestGo_Bus, 0x016e36, Go_File_HH, 0x1763ed, Go_File_FO4)         ; D.B. Tech High School
    HH_Build_TeleportData( 2, DestGo_Bus, 0x016e37, Go_File_HH, 0x176420, Go_File_FO4)         ; Fallon's Dept Store
    HH_Build_TeleportData( 3, DestGo_Bus, 0x016e38, Go_File_HH, 0x176418, Go_File_FO4)         ; Fiddler's Green
    HH_Build_TeleportData( 4, DestGo_Bus, 0x016e39, Go_File_HH, 0x1763e3, Go_File_FO4)         ; Goodneighbor
    HH_Build_TeleportData( 5, DestGo_Bus, 0x016e3a, Go_File_HH, 0x17640a, Go_File_FO4)         ; Kendall Hospital
    HH_Build_TeleportData( 6, DestGo_Bus, 0x016e3b, Go_File_HH, 0x0fd030, Go_File_FO4)         ; Lexington Station
    HH_Build_TeleportData( 7, DestGo_Bus, 0x016e3c, Go_File_HH, 0x176403, Go_File_FO4)         ; Prospect Park
    HH_Build_TeleportData( 8, DestGo_Bus, 0x016e3d, Go_File_HH, 0x1763cd, Go_File_FO4)         ; Revere Beach Station
    HH_Build_TeleportData( 9, DestGo_Bus, 0x016e3e, Go_File_HH, 0x1763dd, Go_File_FO4)         ; University Point

    DestGo_Diner = HH_Build_TeleportStructs(30)
    HH_Build_TeleportData( 0, DestGo_Diner, 0x016e3f, Go_File_HH , 0x111ff8, Go_File_FO4)      ; Anna's Cafe
    HH_Build_TeleportData( 1, DestGo_Diner, 0x016e40, Go_File_HH , 0x21528e, Go_File_FO4)      ; Cambridge Campus Diner
    HH_Build_TeleportData( 2, DestGo_Diner, 0x038291, Go_File_NW , 0x038291, Go_File_NW )      ; DLC NW: Cappy's Cafe
    HH_Build_TeleportData( 3, DestGo_Diner, 0x016e38, Go_File_FH , 0x02a675, Go_File_FH )      ; DLC FH: Cliff's Edge Hotel
    HH_Build_TeleportData( 4, DestGo_Diner, 0x016e41, Go_File_HH , 0x23077a, Go_File_FO4)      ; Diamond City Concessions
    HH_Build_TeleportData( 5, DestGo_Diner, 0x016e42, Go_File_HH , 0x24814f, Go_File_FO4)      ; Diamond City Diner
    HH_Build_TeleportData( 6, DestGo_Diner, 0x00359f, Go_File_HH , 0x190f1d, Go_File_FO4)      ; Drumlin Diner Concord
    HH_Build_TeleportData( 7, DestGo_Diner, 0x016e43, Go_File_HH , 0x09f7ad, Go_File_FO4)      ; Drumlin Diner East Boston
    HH_Build_TeleportData( 8, DestGo_Diner, 0x016e44, Go_File_HH , 0x02bc85, Go_File_FO4)      ; Drumlin Diner Gibson Point Pier
    HH_Build_TeleportData( 9, DestGo_Diner, 0x016e45, Go_File_HH , 0x05dfd0, Go_File_FO4)      ; Drumlin Diner Jamaica Plain
    HH_Build_TeleportData(10, DestGo_Diner, 0x016e46, Go_File_HH , 0x0beb63, Go_File_FO4)      ; Drumlin Diner Salem
    HH_Build_TeleportData(11, DestGo_Diner, 0x016e47, Go_File_HH , 0x10d8d0, Go_File_FO4)      ; Fens Cafe
    HH_Build_TeleportData(12, DestGo_Diner, 0x08b4bf, Go_File_FO4, 0x0     , Go_File_FO4)      ; Fentons Food Stuffs
    HH_Build_TeleportData(13, DestGo_Diner, 0x0201d6, Go_File_NW , 0x0377cb, Go_File_NW )      ; DLC NW: Fizztop Grille
    HH_Build_TeleportData(14, DestGo_Diner, 0x016e48, Go_File_HH , 0x222fb1, Go_File_FO4)      ; Forest Grove Bakery
    HH_Build_TeleportData(15, DestGo_Diner, 0x016e49, Go_File_HH , 0x222f97, Go_File_FO4)      ; Forest Grove Crab Shack
    HH_Build_TeleportData(16, DestGo_Diner, 0x016e4a, Go_File_HH , 0x0eadf9, Go_File_FO4)      ; Handy Eats
    HH_Build_TeleportData(17, DestGo_Diner, 0x016e4b, Go_File_HH , 0x16c9b6, Go_File_FO4)      ; Joe's Spuckies Andrews Station
    HH_Build_TeleportData(18, DestGo_Diner, 0x003d39, Go_File_HH , 0x1accba, Go_File_FO4)      ; Joe's Spuckies Mean Pastries
    HH_Build_TeleportData(19, DestGo_Diner, 0x157575, Go_File_FO4, 0x0     , Go_File_FO4)      ; Joe's Spuckies Postal Square
    HH_Build_TeleportData(20, DestGo_Diner, 0x016e4c, Go_File_HH , 0x0e7b29, Go_File_FO4)      ; Pinelli's Bakery
    HH_Build_TeleportData(21, DestGo_Diner, 0x016e4d, Go_File_HH , 0x1726dc, Go_File_FO4)      ; Pizza Parlor
    HH_Build_TeleportData(22, DestGo_Diner, 0x004e0e, Go_File_FO4, 0x1437fe, Go_File_FO4)      ; Power Noodles
    HH_Build_TeleportData(23, DestGo_Diner, 0x00ec31, Go_File_HH , 0x1a68be, Go_File_FO4)      ; Quincy Diner
    HH_Build_TeleportData(24, DestGo_Diner, 0x016e4e, Go_File_HH , 0x068390, Go_File_FO4)      ; Revere Beach Ice Cream Parlor
    HH_Build_TeleportData(25, DestGo_Diner, 0x0a21f2, Go_File_FO4, 0x0     , Go_File_FO4)      ; Shenley's Oyster Bar
    HH_Build_TeleportData(26, DestGo_Diner, 0x003d3a, Go_File_HH , 0x1edfe7, Go_File_FO4)      ; Slocum's Joe Corporate HQ
    HH_Build_TeleportData(27, DestGo_Diner, 0x016e4f, Go_File_HH , 0x0fd601, Go_File_FO4)      ; Slocum's Joe Galleria
    HH_Build_TeleportData(28, DestGo_Diner, 0x016e50, Go_File_HH , 0x0e515c, Go_File_FO4)      ; Slocum's Joe Lexington
    HH_Build_TeleportData(29, DestGo_Diner, 0x016e51, Go_File_HH , 0x22781b, Go_File_FO4)      ; Slocum's Joe Monsignor Plaza
    DestGo_Diner[ 5].SpecialRewardGlobal    = HH_Rewarded_Skybox
    DestGo_Diner[ 5].SpecialRewardTimer     = HH_TIMER_REWARDS_SKYBOX
    DestGo_Diner[ 6].extraMonitor = HH_VisitedDrumlin1
    DestGo_Diner[ 7].extraMonitor = HH_VisitedDrumlin2
    DestGo_Diner[ 8].extraMonitor = HH_VisitedDrumlin3
    DestGo_Diner[ 9].extraMonitor = HH_VisitedDrumlin4
    DestGo_Diner[10].extraMonitor = HH_VisitedDrumlin5
    DestGo_Diner[17].extraMonitor = HH_VisitedSpuckies1
    DestGo_Diner[18].extraMonitor = HH_VisitedSpuckies2
    DestGo_Diner[19].extraMonitor = HH_VisitedSpuckies3
    DestGo_Diner[26].extraMonitor = HH_VisitedSlocums1
    DestGo_Diner[27].extraMonitor = HH_VisitedSlocums2
    DestGo_Diner[28].extraMonitor = HH_VisitedSlocums3
    DestGo_Diner[29].extraMonitor = HH_VisitedSlocums4

    DestGo_Dive = HH_Build_TeleportStructs(13)
    HH_Build_TeleportData( 0, DestGo_Dive, 0x018a9b, Go_File_FO4, 0x0a8dc6, Go_File_FO4)        ; Colonial Taphouse
    HH_Build_TeleportData( 1, DestGo_Dive, 0x023c30, Go_File_FO4, 0x0     , Go_File_FO4)        ; Concord Speakeasy
    HH_Build_TeleportData( 2, DestGo_Dive, 0x04c5ee, Go_File_NW , 0x044720, Go_File_NW )        ; DLC NW: Doc Phosphate's Saloon
    HH_Build_TeleportData( 3, DestGo_Dive, 0x13a16d, Go_File_FO4, 0x0b1430, Go_File_FO4)        ; Dugout Inn
    HH_Build_TeleportData( 4, DestGo_Dive, 0x006342, Go_File_HH , 0x223018, Go_File_FO4)        ; Forest Grove Pub Buffet
    HH_Build_TeleportData( 5, DestGo_Dive, 0x04c834, Go_File_FO4, 0x0     , Go_File_FO4)        ; Gwinnett Restaurant
    HH_Build_TeleportData( 6, DestGo_Dive, 0x18726f, Go_File_FO4, 0x0d1782, Go_File_FO4)        ; Nahant Bar Restaurant
    HH_Build_TeleportData( 7, DestGo_Dive, 0x00c624, Go_File_HH , 0x176a40, Go_File_FO4)        ; Prost Bar
    HH_Build_TeleportData( 8, DestGo_Dive, 0x00c625, Go_File_HH , 0x1a684a, Go_File_FO4)        ; Quincy Liquors
    HH_Build_TeleportData( 9, DestGo_Dive, 0x04541a, Go_File_FO4, 0x0f2a66, Go_File_FO4)        ; Shamrock Taphouse
    HH_Build_TeleportData(10, DestGo_Dive, 0x00ab01, Go_File_FH , 0x0034dc, Go_File_FH )        ; DLC FH: The Last Plank
    HH_Build_TeleportData(11, DestGo_Dive, 0x181284, Go_File_FO4, 0x10b203, Go_File_FO4)        ; The Third Rail
    HH_Build_TeleportData(12, DestGo_Dive, 0x00c626, Go_File_HH , 0x1c0282, Go_File_FO4)        ; Ticker Tape Lounge
    DestGo_Dive[ 7].SpecialRewardGlobal    = HH_Rewarded_Prost
    DestGo_Dive[ 7].SpecialRewardTimer     = HH_TIMER_REWARDS_PROST

    DestGo_Drive = HH_Build_TeleportStructs(12)
    HH_Build_TeleportData( 0, DestGo_Drive, 0x04a69f, Go_File_NW , 0x0532a5, Go_File_NW )       ; DLC NW: Bradberton Amphitheater
    HH_Build_TeleportData( 1, DestGo_Drive, 0x066246, Go_File_FO4, 0x123a11, Go_File_FO4)       ; Charles View Amphitheater
    HH_Build_TeleportData( 2, DestGo_Drive, 0x00ec33, Go_File_HH , 0x13be6a, Go_File_FO4)       ; Combat Zone
    HH_Build_TeleportData( 3, DestGo_Drive, 0x04c5ec, Go_File_NW , 0x04475f, Go_File_NW )       ; DLC NW: Dry Rock Gulch Theater
    HH_Build_TeleportData( 4, DestGo_Drive, 0x00ec34, Go_File_HH , 0x0     , Go_File_HH )       ; Easy City Downs
    HH_Build_TeleportData( 5, DestGo_Drive, 0x04eab5, Go_File_FH , 0x0     , Go_File_FH )       ; DLC FH: Eden Meadows Cinemas
    HH_Build_TeleportData( 6, DestGo_Drive, 0x075e76, Go_File_FO4, 0x055229, Go_File_FO4)       ; Memory Den
    HH_Build_TeleportData( 7, DestGo_Drive, 0x08cb76, Go_File_FO4, 0x0     , Go_File_FO4)       ; Pickman Gallery
    HH_Build_TeleportData( 8, DestGo_Drive, 0x006343, Go_File_HH , 0x195240, Go_File_FO4)       ; Starlight Drive-In
    HH_Build_TeleportData( 9, DestGo_Drive, 0x00e76f, Go_File_NW , 0x0     , Go_File_NW )       ; DLC NW: Starlight Interstellar Theater
    HH_Build_TeleportData(10, DestGo_Drive, 0x021d80, Go_File_NW , 0x021d73, Go_File_NW )       ; DLC NW: The Parlor
    HH_Build_TeleportData(11, DestGo_Drive, 0x006344, Go_File_HH , 0x0b7eed, Go_File_FO4)       ; Warren Theater

    DestGo_Factory = HH_Build_TeleportStructs(12)
    HH_Build_TeleportData( 0, DestGo_Factory, 0x075766, Go_File_FO4, 0x0     , Go_File_FO4)     ; Beantown Brewery
    HH_Build_TeleportData( 1, DestGo_Factory, 0x157c81, Go_File_FO4, 0x0     , Go_File_FO4)     ; Choice Chops
    HH_Build_TeleportData( 2, DestGo_Factory, 0x03d656, Go_File_FO4, 0x0     , Go_File_FO4)     ; Four Leaf Fishpacking Plant
    HH_Build_TeleportData( 3, DestGo_Factory, 0x194fb5, Go_File_FO4, 0x04c836, Go_File_FO4)     ; Gwinnett Brewery
    HH_Build_TeleportData( 4, DestGo_Factory, 0x03d832, Go_File_FO4, 0x0ada0b, Go_File_FO4)     ; Longneck Lukowski's
    HH_Build_TeleportData( 5, DestGo_Factory, 0x054840, Go_File_FO4, 0x0     , Go_File_FO4)     ; Mahkra Fishpacking
    HH_Build_TeleportData( 6, DestGo_Factory, 0x04d53f, Go_File_FO4, 0x0     , Go_File_FO4)     ; Parsons Creamery
    HH_Build_TeleportData( 7, DestGo_Factory, 0x0324f4, Go_File_FH , 0x0     , Go_File_FH )     ; DLC FH: Super Duper Mart Far Harbor
    HH_Build_TeleportData( 8, DestGo_Factory, 0x031ea2, Go_File_FO4, 0x064962, Go_File_FO4)     ; Super Duper Mart Lexington
    HH_Build_TeleportData( 9, DestGo_Factory, 0x006347, Go_File_HH , 0x0     , Go_File_FO4)     ; Super Duper Mart Quincy
    HH_Build_TeleportData(10, DestGo_Factory, 0x016f97, Go_File_FH , 0x0     , Go_File_FH )     ; DLC FH: Vim! Pop Factory
    HH_Build_TeleportData(11, DestGo_Factory, 0x026078, Go_File_NW , 0x0     , Go_File_NW )     ; DLC NW: World of Refreshment
    DestGo_Factory[ 7].extraMonitor = HH_VisitedSuper1
    DestGo_Factory[ 8].extraMonitor = HH_VisitedSuper2
    DestGo_Factory[ 9].extraMonitor = HH_VisitedSuper3

    DestGo_Farm = HH_Build_TeleportStructs(12)
    HH_Build_TeleportData( 0, DestGo_Farm, 0x06fa8b, Go_File_FO4, 0x0     , Go_File_FO4)        ; Abernathy Farm
    HH_Build_TeleportData( 1, DestGo_Farm, 0x09b1f7, Go_File_FO4, 0x0     , Go_File_FO4)        ; Breakheart Banks
    HH_Build_TeleportData( 2, DestGo_Farm, 0x09b1d5, Go_File_FO4, 0x0     , Go_File_FO4)        ; County Crossing
    HH_Build_TeleportData( 3, DestGo_Farm, 0x09b19f, Go_File_FO4, 0x0     , Go_File_FO4)        ; Finch Farm
    HH_Build_TeleportData( 4, DestGo_Farm, 0x075751, Go_File_FO4, 0x0     , Go_File_FO4)        ; Graygarden
    HH_Build_TeleportData( 5, DestGo_Farm, 0x1ae2eb, Go_File_FO4, 0x0     , Go_File_FO4)        ; Greentop Nursery
    HH_Build_TeleportData( 6, DestGo_Farm, 0x1ae2f7, Go_File_FO4, 0x0     , Go_File_FO4)        ; Nordhagen Beach
    HH_Build_TeleportData( 7, DestGo_Farm, 0x1ae2fb, Go_File_FO4, 0x0     , Go_File_FO4)        ; Oberland Station
    HH_Build_TeleportData( 8, DestGo_Farm, 0x1e97b4, Go_File_FO4, 0x0     , Go_File_FO4)        ; Somerville Place
    HH_Build_TeleportData( 9, DestGo_Farm, 0x09b1b3, Go_File_FO4, 0x0     , Go_File_FO4)        ; Tenpines Bluff
    HH_Build_TeleportData(10, DestGo_Farm, 0x1ae323, Go_File_FO4, 0x0     , Go_File_FO4)        ; The Slog
    HH_Build_TeleportData(11, DestGo_Farm, 0x075721, Go_File_FO4, 0x0     , Go_File_FO4)        ; Warwick Homestead

    DestGo_Junkyard = HH_Build_TeleportStructs(20)
    HH_Build_TeleportData( 0, DestGo_Junkyard, 0x059e52, Go_File_FO4, 0x0     , Go_File_FO4)    ; Big John's Salvage
    HH_Build_TeleportData( 1, DestGo_Junkyard, 0x01fc9b, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Echo Lake Lumber
    HH_Build_TeleportData( 2, DestGo_Junkyard, 0x212e70, Go_File_FO4, 0x0     , Go_File_FO4)    ; FMS Northern Star Wreck
    HH_Build_TeleportData( 3, DestGo_Junkyard, 0x011a82, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Fringe Cove Docks
    HH_Build_TeleportData( 4, DestGo_Junkyard, 0x016e35, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Horizon Flight 1207
    HH_Build_TeleportData( 5, DestGo_Junkyard, 0x04d134, Go_File_FO4, 0x0     , Go_File_FO4)    ; Hub City Auto Wreckers
    HH_Build_TeleportData( 6, DestGo_Junkyard, 0x0567c1, Go_File_FH , 0x00b1cf, Go_File_FH )    ; DLC FH: Huntress Island
    HH_Build_TeleportData( 7, DestGo_Junkyard, 0x0535c2, Go_File_FO4, 0x0     , Go_File_FO4)    ; Jalbert Brothers Disposal
    HH_Build_TeleportData( 8, DestGo_Junkyard, 0x02065a, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: MS Azalea
    HH_Build_TeleportData( 9, DestGo_Junkyard, 0x017648, Go_File_NW , 0x0     , Go_File_NW )    ; DLC NW: Nuka-World Junkyard
    HH_Build_TeleportData(10, DestGo_Junkyard, 0x04ffa7, Go_File_FH , 0x016dcf, Go_File_FH )    ; DLC FH: Oceanarium
    HH_Build_TeleportData(11, DestGo_Junkyard, 0x059b52, Go_File_FO4, 0x0     , Go_File_FO4)    ; Robotics Disposal Ground
    HH_Build_TeleportData(12, DestGo_Junkyard, 0x05422e, Go_File_FH , 0x00ac0f, Go_File_FH )    ; DLC FH: Rock Point Camp
    HH_Build_TeleportData(13, DestGo_Junkyard, 0x075728, Go_File_FO4, 0x19756e, Go_File_FO4)    ; Rotten Landfill
    HH_Build_TeleportData(14, DestGo_Junkyard, 0x04c8d5, Go_File_FO4, 0x0     , Go_File_FO4)    ; Scrap Palace
    HH_Build_TeleportData(15, DestGo_Junkyard, 0x0add8d, Go_File_FO4, 0x0     , Go_File_FO4)    ; Skylanes Flight 1665
    HH_Build_TeleportData(16, DestGo_Junkyard, 0x240223, Go_File_FO4, 0x0     , Go_File_FO4)    ; Skylanes Flight 1981
    HH_Build_TeleportData(17, DestGo_Junkyard, 0x0399cb, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Southwest Harbor
    HH_Build_TeleportData(18, DestGo_Junkyard, 0x02bb32, Go_File_FO4, 0x0     , Go_File_FO4)    ; USS Riptide Wreck
    HH_Build_TeleportData(19, DestGo_Junkyard, 0x06623f, Go_File_FO4, 0x0     , Go_File_FO4)    ; Wicked Shipping Fleet Lockup

    DestGo_Military = HH_Build_TeleportStructs(20)
    HH_Build_TeleportData( 0, DestGo_Military, 0x034345, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Acadia
    HH_Build_TeleportData( 1, DestGo_Military, 0x049100, Go_File_FO4, 0x0     , Go_File_FO4)    ; Boston Mayoral Shelter
    HH_Build_TeleportData( 2, DestGo_Military, 0x043e83, Go_File_FO4, 0x0     , Go_File_FO4)    ; Boston Police Rationing Site
    HH_Build_TeleportData( 3, DestGo_Military, 0x01fba9, Go_File_FO4, 0x0     , Go_File_FO4)    ; Coast Guard Pier
    HH_Build_TeleportData( 4, DestGo_Military, 0x023589, Go_File_FO4, 0x0     , Go_File_FO4)    ; Federal Ration Stockpile
    HH_Build_TeleportData( 5, DestGo_Military, 0x0add9d, Go_File_FO4, 0x0     , Go_File_FO4)    ; Federal Supply Cache 84NE
    HH_Build_TeleportData( 6, DestGo_Military, 0x0baacc, Go_File_FO4, 0x0     , Go_File_FO4)    ; Fort Hagen
    HH_Build_TeleportData( 7, DestGo_Military, 0x006345, Go_File_HH , 0x0     , Go_File_FO4)    ; Fort Hagen Satellite Array
    HH_Build_TeleportData( 8, DestGo_Military, 0x006346, Go_File_HH , 0x0     , Go_File_FO4)    ; Fort Strong
    HH_Build_TeleportData( 9, DestGo_Military, 0x006348, Go_File_HH , 0x0     , Go_File_FO4)    ; Listening Post Bravo
    HH_Build_TeleportData(10, DestGo_Military, 0x006349, Go_File_HH , 0x0     , Go_File_FO4)    ; National Guard Training Yard
    HH_Build_TeleportData(11, DestGo_Military, 0x05666f, Go_File_NW , 0x0     , Go_File_NW )    ; DLC NW: Northpoint Reservoir
    HH_Build_TeleportData(12, DestGo_Military, 0x04b18e, Go_File_NW , 0x01ad11, Go_File_NW )    ; DLC NW: Nuka-World Power Plant
    HH_Build_TeleportData(13, DestGo_Military, 0x00634a, Go_File_HH , 0x0     , Go_File_FO4)    ; Recon Bunker Theta
    HH_Build_TeleportData(14, DestGo_Military, 0x075716, Go_File_FO4, 0x0     , Go_File_FO4)    ; Revere Satellite Array
    HH_Build_TeleportData(15, DestGo_Military, 0x0adda5, Go_File_FO4, 0x0     , Go_File_FO4)    ; Sentinel Site
    HH_Build_TeleportData(16, DestGo_Military, 0x05975d, Go_File_FO4, 0x0     , Go_File_FO4)    ; S. Boston Military Checkpoint
    HH_Build_TeleportData(17, DestGo_Military, 0x0ab334, Go_File_FO4, 0x0     , Go_File_FO4)    ; The Castle
    HH_Build_TeleportData(18, DestGo_Military, 0x04e1f0, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: The Nucleus
    HH_Build_TeleportData(19, DestGo_Military, 0x00634b, Go_File_HH , 0x0     , Go_File_FO4)    ; USAF Satellite Station Olivia

    DestGo_Monument = HH_Build_TeleportStructs(31)
    HH_Build_TeleportData( 0, DestGo_Monument, 0x006360, Go_File_HH , 0x0     , Go_File_FO4)    ; Boston Airport
    HH_Build_TeleportData( 1, DestGo_Monument, 0x18dfa6, Go_File_FO4, 0x17c7e2, Go_File_FO4)    ; Boston Public Library
    HH_Build_TeleportData( 2, DestGo_Monument, 0x00ece6, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Brooke's Head Lighthouse
    HH_Build_TeleportData( 3, DestGo_Monument, 0x006361, Go_File_HH , 0x0     , Go_File_FO4)    ; Bunker Hill
    HH_Build_TeleportData( 4, DestGo_Monument, 0x0566b8, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Children of Atom Shrine
    HH_Build_TeleportData( 5, DestGo_Monument, 0x07570c, Go_File_FO4, 0x0     , Go_File_FO4)    ; Custom House Tower
    HH_Build_TeleportData( 6, DestGo_Monument, 0x006362, Go_File_HH , 0x0     , Go_File_FO4)    ; Diamond City
    HH_Build_TeleportData( 7, DestGo_Monument, 0x075e3e, Go_File_FO4, 0x0     , Go_File_FO4)    ; Fallen Skybridge
    HH_Build_TeleportData( 8, DestGo_Monument, 0x0cf3e1, Go_File_FO4, 0x0     , Go_File_FO4)    ; Faneuil Hall
    HH_Build_TeleportData( 9, DestGo_Monument, 0x04e0ef, Go_File_NW , 0x0     , Go_File_NW )    ; DLC NW: Ferris Wheel
    HH_Build_TeleportData(10, DestGo_Monument, 0x18773d, Go_File_FO4, 0x1e05a9, Go_File_FO4)    ; Garden Terrace
    HH_Build_TeleportData(11, DestGo_Monument, 0x02d271, Go_File_FO4, 0x0     , Go_File_FO4)    ; Gunners Plaza
    HH_Build_TeleportData(12, DestGo_Monument, 0x0f1de8, Go_File_FO4, 0x0     , Go_File_FO4)    ; Jamaica Plain
    HH_Build_TeleportData(13, DestGo_Monument, 0x006363, Go_File_HH , 0x0     , Go_File_FO4)    ; Kingsport Lighthouse
    HH_Build_TeleportData(14, DestGo_Monument, 0x245930, Go_File_FO4, 0x0     , Go_File_FO4)    ; Mass Fusion Building ; Roof. Might need street side spot to prevent bugging quests.
    HH_Build_TeleportData(15, DestGo_Monument, 0x1a5b65, Go_File_FO4, 0x0     , Go_File_FO4)    ; Mass State House
    HH_Build_TeleportData(16, DestGo_Monument, 0x006364, Go_File_HH , 0x0     , Go_File_FO4)    ; Minuteman Statue Lexington
    HH_Build_TeleportData(17, DestGo_Monument, 0x01d325, Go_File_FO4, 0x0     , Go_File_FO4)    ; Minuteman Statue Sanctuary
    HH_Build_TeleportData(18, DestGo_Monument, 0x0a970d, Go_File_FO4, 0x0     , Go_File_FO4)    ; Monsignor Plaza
    HH_Build_TeleportData(19, DestGo_Monument, 0x01d413, Go_File_FO4, 0x0     , Go_File_FO4)    ; Museum of Freedom
    HH_Build_TeleportData(20, DestGo_Monument, 0x15c507, Go_File_FO4, 0x0     , Go_File_FO4)    ; Museum of Witchcraft
    HH_Build_TeleportData(21, DestGo_Monument, 0x00ab27, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: National Park Visitor's Center
    HH_Build_TeleportData(22, DestGo_Monument, 0x1ae193, Go_File_FO4, 0x0     , Go_File_FO4)    ; North End Graveyard
    HH_Build_TeleportData(23, DestGo_Monument, 0x0379bd, Go_File_NW , 0x0     , Go_File_NW )    ; DLC NW: Nuka-Town USA
    HH_Build_TeleportData(24, DestGo_Monument, 0x00adb7, Go_File_NW , 0x00abbf, Go_File_NW )    ; DLC NW: Nuka-World Transit Center
    HH_Build_TeleportData(25, DestGo_Monument, 0x01dcb6, Go_File_FO4, 0x0     , Go_File_FO4)    ; Old North Church
    HH_Build_TeleportData(26, DestGo_Monument, 0x056919, Go_File_FH , 0x0     , Go_File_FH )    ; DLC FH: Radiant Crest Shrine
    HH_Build_TeleportData(27, DestGo_Monument, 0x1a6d09, Go_File_FO4, 0x0     , Go_File_FO4)    ; Swan's Pond
    HH_Build_TeleportData(28, DestGo_Monument, 0x021131, Go_File_FO4, 0x0     , Go_File_FO4)    ; Trinity Tower
    HH_Build_TeleportData(29, DestGo_Monument, 0x00ec55, Go_File_HH , 0x0     , Go_File_FO4)    ; USS Constitution 1st location
    HH_Build_TeleportData(30, DestGo_Monument, 0x1f2638, Go_File_FO4, 0x0     , Go_File_FO4)    ; USS Constitution 2nd location

    ; NOTE: POWER LIFTS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD

    DestGo_Power = HH_Build_TeleportStructs(15)
    HH_Build_TeleportData( 0, DestGo_Power, 0x1c5dfe, Go_File_FO4, 0x0     , Go_File_FO4)       ; Wilderness (-18, -7)
    HH_Build_TeleportData( 1, DestGo_Power, 0x1c5db4, Go_File_FO4, 0x0     , Go_File_FO4)       ; Mass Pike Interchange
    HH_Build_TeleportData( 2, DestGo_Power, 0x1d290e, Go_File_FO4, 0x0     , Go_File_FO4)       ; Wildwood Cemetery
    HH_Build_TeleportData( 3, DestGo_Power, 0x1c01bc, Go_File_FO4, 0x0     , Go_File_FO4)       ; Tucker Memorial Bridge
    HH_Build_TeleportData( 4, DestGo_Power, 0x1c01a5, Go_File_FO4, 0x0     , Go_File_FO4)       ; College Square
    HH_Build_TeleportData( 5, DestGo_Power, 0x1c01a7, Go_File_FO4, 0x0     , Go_File_FO4)       ; Layton Towers
    HH_Build_TeleportData( 6, DestGo_Power, 0x1c01a6, Go_File_FO4, 0x0     , Go_File_FO4)       ; Financial District
    HH_Build_TeleportData( 7, DestGo_Power, 0x1f7a8c, Go_File_FO4, 0x0     , Go_File_FO4)       ; Union Man's Circle
    HH_Build_TeleportData( 8, DestGo_Power, 0x1eacf8, Go_File_FO4, 0x0     , Go_File_FO4)       ; Parsons State Asylum
    HH_Build_TeleportData( 9, DestGo_Power, 0x1ec5a2, Go_File_FO4, 0x0     , Go_File_FO4)       ; Sunshine Tidings Co-Op
    HH_Build_TeleportData(10, DestGo_Power, 0x1c9d8e, Go_File_FO4, 0x0     , Go_File_FO4)       ; Mass Bay Medical Center
    HH_Build_TeleportData(11, DestGo_Power, 0x2483a7, Go_File_FO4, 0x0     , Go_File_FO4)       ; Beacon Hill
    HH_Build_TeleportData(12, DestGo_Power, 0x2483b1, Go_File_FO4, 0x0     , Go_File_FO4)       ; Cabot House
    HH_Build_TeleportData(13, DestGo_Power, 0x0496b9, Go_File_NW , 0x0     , Go_File_NW )       ; DLC NW: Bradberton North
    HH_Build_TeleportData(14, DestGo_Power, 0x056d10, Go_File_NW , 0x051ead, Go_File_NW )       ; DLC NW: Bradberton South

    ; NOTE: RED ROCKETS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD

    DestGo_Red = HH_Build_TeleportStructs(25)
    HH_Build_TeleportData( 0, DestGo_Red, 0x1cfe03, Go_File_FO4, 0x0     , Go_File_FO4)         ; Commonwealth (-11, -16)
    HH_Build_TeleportData( 1, DestGo_Red, 0x02649a, Go_File_FO4, 0x0     , Go_File_FO4)         ; Egret Tours Marina
    HH_Build_TeleportData( 2, DestGo_Red, 0x00634f, Go_File_HH , 0x0     , Go_File_FO4)         ; Graygarden
    HH_Build_TeleportData( 3, DestGo_Red, 0x016e3b, Go_File_HH , 0x0     , Go_File_FO4)         ; Electrical Hobbyist's Club
    HH_Build_TeleportData( 4, DestGo_Red, 0x006352, Go_File_HH , 0x0     , Go_File_FO4)         ; Lexington Ext 06
    HH_Build_TeleportData( 5, DestGo_Red, 0x006353, Go_File_HH , 0x0     , Go_File_FO4)         ; Commonwealth (2, -12)
    HH_Build_TeleportData( 6, DestGo_Red, 0x006354, Go_File_HH , 0x0     , Go_File_FO4)         ; Shaw High School
    HH_Build_TeleportData( 7, DestGo_Red, 0x006355, Go_File_HH , 0x0     , Go_File_FO4)         ; Neponset Park
    HH_Build_TeleportData( 8, DestGo_Red, 0x006356, Go_File_HH , 0x0     , Go_File_FO4)         ; Commonwealth (12, 4)
    HH_Build_TeleportData( 9, DestGo_Red, 0x006358, Go_File_HH , 0x0     , Go_File_FO4)         ; Commonwealth (-3, -9)
    HH_Build_TeleportData(10, DestGo_Red, 0x006359, Go_File_HH , 0x0     , Go_File_FO4)         ; Glowing Sea
    HH_Build_TeleportData(11, DestGo_Red, 0x24021f, Go_File_FO4, 0x0     , Go_File_FO4)         ; Commonwealth (-3, 2)
    HH_Build_TeleportData(12, DestGo_Red, 0x00635a, Go_File_HH , 0x0     , Go_File_FO4)         ; Lexington Ext 02
    HH_Build_TeleportData(13, DestGo_Red, 0x00635b, Go_File_HH , 0x0     , Go_File_FO4)         ; Wilson Atomatoys Factory
    HH_Build_TeleportData(14, DestGo_Red, 0x00635c, Go_File_HH , 0x0     , Go_File_FO4)         ; Commonwealth (20, 8)
    HH_Build_TeleportData(15, DestGo_Red, 0x00635d, Go_File_HH , 0x0     , Go_File_FO4)         ; Red Rocket Settlement
    HH_Build_TeleportData(16, DestGo_Red, 0x059286, Go_File_FO4, 0x05222f, Go_File_FO4)         ; Atom Cats Garage
    HH_Build_TeleportData(17, DestGo_Red, 0x00635e, Go_File_HH , 0x0     , Go_File_FO4)         ; Commonwealth (2, -10)
    HH_Build_TeleportData(18, DestGo_Red, 0x22f205, Go_File_FO4, 0x0     , Go_File_FO4)         ; Fort Hagen
    HH_Build_TeleportData(19, DestGo_Red, 0x00635f, Go_File_HH , 0x0     , Go_File_FO4)         ; Nahant Red Rocket
    HH_Build_TeleportData(20, DestGo_Red, 0x043a24, Go_File_FH , 0x023501, Go_File_FH )         ; DLC FH: Beaver Creek Red Rocket
    HH_Build_TeleportData(21, DestGo_Red, 0x0435aa, Go_File_FH , 0x0     , Go_File_FH )         ; DLC FH: Harbor North Red Rocket
    HH_Build_TeleportData(22, DestGo_Red, 0x01922f, Go_File_FH , 0x0     , Go_File_FH )         ; DLC FH: Harbor Southwest Red Rocket
    HH_Build_TeleportData(23, DestGo_Red, 0x00d393, Go_File_NW , 0x0     , Go_File_NW )         ; DLC NW: Hubologist's Camp
    HH_Build_TeleportData(24, DestGo_Red, 0x04c76f, Go_File_NW , 0x0     , Go_File_NW )         ; DLC NW: Nuka-World Red Rocket

    DestGo_Vault = HH_Build_TeleportStructs(10)
    HH_Build_TeleportData( 0, DestGo_Vault, 0x00634c, Go_File_HH , 0x0     , Go_File_FO4)       ; Sanctuary Hills
    HH_Build_TeleportData( 1, DestGo_Vault, 0x1ae19b, Go_File_FO4, 0x070f03, Go_File_FO4)       ; Vault-Tec Regional HQ
    HH_Build_TeleportData( 2, DestGo_Vault, 0x00634c, Go_File_HH , 0x0     , Go_File_FO4)       ; Vault 75
    HH_Build_TeleportData( 3, DestGo_Vault, 0x00634d, Go_File_HH , 0x0     , Go_File_FO4)       ; Vault 81 New
    HH_Build_TeleportData( 4, DestGo_Vault, 0x0     , Go_File_FO4, 0x0     , Go_File_FO4)       ; disabled empty (removed: Vault 81 secret)
    HH_Build_TeleportData( 5, DestGo_Vault, 0x002517, Go_File_VT , 0x0     , Go_File_VT )       ; DLC VT: Vault 88
    HH_Build_TeleportData( 6, DestGo_Vault, 0x006350, Go_File_HH , 0x0     , Go_File_FO4)       ; Vault 95
    HH_Build_TeleportData( 7, DestGo_Vault, 0x066235, Go_File_FO4, 0x0     , Go_File_FO4)       ; Vault 111
    HH_Build_TeleportData( 8, DestGo_Vault, 0x006351, Go_File_HH , 0x0     , Go_File_FO4)       ; Vault 114
    HH_Build_TeleportData( 9, DestGo_Vault, 0x036932, Go_File_FH , 0x0     , Go_File_FH )       ; DLC FH: Vault 118
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH START HITCHING
; ------------------------------------------------------------------------------------------------------------

Function HH_StartHitching()
    HH_DebugTraceBox("Hitchhiker: Started hitching...")

    ; IMPORTANT: Player has no controls after spin if still in book/pip menus, so wait until Pip-Boy is closed

    UnregisterForMenuOpenCloseEvent("PipboyMenu")                               ; Cancel any previous button spams. Safety check.
    Utility.WaitMenuMode(0.1)                                                   ; Give unregister a moment to work
    RegisterForMenuOpenCloseEvent("PipboyMenu")                                 ; then handle time change in the event
EndFunction

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON MENU OPEN CLOSE EVENT
; ------------------------------------------------------------------------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
    If (asMenuName == "PipboyMenu")                                             ; When the Pip-Boy
        If (!abOpening)                                                         ; closes...
            UnregisterForMenuOpenCloseEvent("PipboyMenu")                       ; Cancel player button spams.
            HH_Handler_TeleportOnPipBoyClose()
        EndIf
    EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH HANDLER TELEPORTONPIPBOYCLOSE
; ------------------------------------------------------------------------------------------------------------

Function HH_Handler_TeleportOnPipBoyClose()
            ; Thanks to ehtyeci for Vault Boy list!
            ; Thread: https://forums.nexusmods.com/index.php?/topic/6271136-i-there-a-list-of-perks-in-their-swf-forms/
            ; VB Viewer: http://powback.com/public/Fallout/?mobile=true

            HH_DisablePlayerControls()                                          ; Disable player controls so they don't interrupt the teleport sequence

            If HH_OptionTeleportSound.GetValueInt() == 1                        ; If player wants teleport sound,
                Int iInstanceID = DRSVertibirdFlightLoadOpen.Play(Player)       ; play teleport start sound at player
            EndIf

            If HH_OptionVaultBoy.GetValueInt() == 1                             ; If player wants Vault Boy animations, show thumbs up
                Game.ShowPerkVaultBoyOnHUD("Components\\VaultBoys\\Perks\\PerkClip_Default.swf")
                Utility.Wait(3)                                                 ; Give Vault Boy time to display
            EndIf

            Player.AddPerk(HH_TeleportNoFallDamage)                             ; IMPORTANT: Temp perk so teleport falls don't kill player! Necessary for lift locations.

            If HH_OptionVaultBoy.GetValueInt() == 1                             ; If player wants Vault Boy animations, show VANS ride
                Game.ShowPerkVaultBoyOnHUD("Components\\VaultBoys\\Perks\\PerkClip_207d1.swf")
                Utility.Wait(3)                                                 ; Give Vault Boy time to display
            EndIf

            If HH_OptionTeleportSound.GetValueInt() == 1                        ; If player wants teleport sound,
                Int iInstanceID = OBJHijackerTeleportOut2DA.Play(Player)        ; play teleport end sound at player
            EndIf

            ObjectReference DestinationMarker                                   ; Dynamically spawn xmarker at player
            Int Category = HH_Category.GetValueInt()                            ; Retrieve Category from global
            Int TargetID = HH_TargetID.GetValueInt()                            ; Retrieve TargetID from global

            ObjectReference TargetObject                                        ; Destination target as ObjectReference
            TargetObjectStruct FurnitureTargetData = new TargetObjectStruct
            GoStructTeleports[] Go_Type

            If Category == BUS_SHELTERS
                Go_Type = DestGo_Bus
            ElseIf Category == DINERS
                Go_Type = DestGo_Diner
            ElseIf Category == DIVES
                Go_Type = DestGo_Dive
            ElseIf Category == DRIVE_INS
                Go_Type = DestGo_Drive
            ElseIf Category == FACTORIES
                Go_Type = DestGo_Factory
            ElseIf Category == FARMS
                Go_Type = DestGo_Farm
            ElseIf Category == JUNKYARDS
                Go_Type = DestGo_Junkyard
            ElseIf Category == MILITARY_BASES
                Go_Type = DestGo_Military
            ElseIf Category == MONUMENTS
                Go_Type = DestGo_Monument
            ElseIf Category == POWER_LIFTS
                Go_Type = DestGo_Power
            ElseIf Category == RED_ROCKETS
                Go_Type = DestGo_Red
            Else
                Go_Type = DestGo_Vault
            EndIf

            If Go_Type[TargetID].extraMonitor                                   ; set corporate tracking monitor global if it exists
                Go_Type[TargetID].extraMonitor.SetValue(1)
            EndIf

            HH_EnablePlayerControls()
            HH_DebugTraceBox("Hitching to\nCategory: "+Category+"\nTargetID: "+TargetID+"\nHex2Dec: "+Go_Type[TargetID].teleportTarget+"\nHH Go_File: "+Go_Type[TargetID].teleportGoFile+" "+Go_Files[Go_Type[TargetID].teleportGoFile].Name)


            ; ************************************************************************************************
            ; Move the player in a manner that suits declared preferences!
            ; ************************************************************************************************

            DestinationMarker = Game.GetFormFromFile(Go_Type[TargetID].teleportTarget, Go_Files[Go_Type[TargetID].teleportGoFile].Name) as ObjectReference
            FurnitureTargetData.Go_File = Go_Files[Go_Type[TargetID].furnitureGoFile].Name
            FurnitureTargetData.TargetID = Go_Type[TargetID].furnitureTarget

            If HH_OptionFastTravel.GetValueInt() == 1                           ; If player wants time advancement.
                Game.FastTravel(DestinationMarker)                              ; move player to marker (with load screens?)
                HH_DebugTraceBox("HITCHHIKER: FAST TRAVEL CALLED.")
            Else
                Player.MoveTo(DestinationMarker)                                ; else move player without time change
                HH_DebugTraceBox("HITCHHIKER: MOVETO CALLED.")
            EndIf

            ; This wait is a hack to prevent the script from continuing during a loading screen
            Utility.Wait(0.01)

            If Go_Type[TargetID].SpecialRewardGlobal && Go_Type[TargetID].SpecialRewardGlobal.GetValueInt() == 0
                Int iRewardWaitTime = HH_SpecialRewardWait.GetValueInt()
                If HH_OptionSpinCamera.GetValueInt() == 1
                    iRewardWaitTime += HH_OptionSpinDuration.GetValueInt()
                EndIf
                StartTimer(iRewardWaitTime, Go_Type[TargetID].SpecialRewardTimer)
            EndIf

            If FurnitureTargetData.TargetID && FurnitureTargetData.TargetID > 0
                TargetObject = Game.GetFormFromFile(FurnitureTargetData.TargetID, FurnitureTargetData.Go_File) as ObjectReference
            EndIf

            bool bFurnitureUse
            If TargetObject
                bFurnitureUse = HH_TryToUseFurniture(Player, TargetObject)
            EndIf

            ; ********************************************************************************************************
            ; Optional automatic time change on teleport
            ; ********************************************************************************************************
            If HH_OptionSetTime.GetValueInt() == 1                              ; If player wants automatic time change (default is NO)
                Int PrefTime = HH_OptionSetTimePreference.GetValueInt()         ; get preferred time
                HH_ForceTime(PrefTime)                                          ; and set it
            EndIf

            ; ********************************************************************************************************
            ; Optional automatic weather change on teleport
            ; ********************************************************************************************************
            If !Player.IsInInterior()                                               ; If destination is NOT indoors...
                If HH_OptionSetWeather.GetValueInt() == 1                           ; If player wants automatic weather change (default is NO)
                    Int PrefWeather = HH_OptionSetWeatherPreference.GetValueInt()   ; get preferred weather
                    HH_ForceWeather(PrefWeather)                                    ; and set it
                EndIf
            EndIf

            If HH_OptionSpinCamera.GetValueInt() == 1                           ; If player wants spincam after teleport,
                If bFurnitureUse
                    Utility.Wait(4)                                             ; If furniture use successful wait 3 second for animation
                EndIf
                HH_SpinCamera()                                                 ; call the custom spin camera function
            EndIf

            StartTimer(10, HH_TIMER_REMOVEFALLPERK)                             ; Remove HH_TeleportNoFallDamage perk in 10 seconds

            Int iRewardWaitTime = HH_NormalRewardWait.GetValueInt()
            If HH_OptionSpinCamera.GetValueInt() == 1                           ; If Spin camera is enabled
                iRewardWaitTime += HH_OptionSpinDuration.GetValueInt()          ; add spin time to wait timer
            EndIf
            StartTimer(iRewardWaitTime, HH_TIMER_CALCULATEREWARDS)              ; Calculate rewards 30 seconds after spin duration
EndFunction

; -----------------------------------------------------------------------------------------------------------
; EVENT: ON TIMER
; -----------------------------------------------------------------------------------------------------------

Event OnTimer(int aiTimerID)
    If aiTimerID == HH_TIMER_STOPSPINNING
        HH_StopSpinning()
    ElseIf aiTimerID == HH_TIMER_REMOVEFALLPERK
        HH_RemoveFallPerk()
    ElseIf aiTimerID == HH_TIMER_CALCULATEREWARDS
        HH_CalculateRewards()
    ElseIf aiTimerID == HH_TIMER_REWARDS_SKYBOX
         HH_CheckRewardItem(Reward = HH_Rewards_Skybox, Rewarded = HH_Rewarded_Skybox)
    ElseIf aiTimerID == HH_TIMER_REWARDS_PROST
         HH_CheckRewardItem(Reward = HH_Rewards_Prost , Rewarded = HH_Rewarded_Prost)
    ElseIf aiTimerID == HH_TIMER_INITMOD
        HH_InitMod()
    Else
        ; Placeholder for additional timers
    EndIf
EndEvent

; -----------------------------------------------------------------------------------------------------------
; EVENT: HH REMOVEFALLPERK
; -----------------------------------------------------------------------------------------------------------

Function HH_RemoveFallPerk()
        Player.RemovePerk(HH_TeleportNoFallDamage)                              ; Temp perk removed after teleport is safely completed
        If HH_OptionHeal.GetValueInt() == 1                                     ; If player wants healed after teleport,
            Player.ResetHealthAndLimbs()                                        ; reset health and limbs
        EndIf
        HH_CountAll.Mod(1)
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SPIN CAMERA
; ------------------------------------------------------------------------------------------------------------

Function HH_SpinCamera()
    If HH_OptionSpinGhost.GetValueInt() == 1                                    ; If player wants no spin damage (default)
        If HH_OptionSpinCamera.GetValueInt() == 1                               ; If player wants spincam after teleport,
            Player.SetGhost()                                                   ; IMPORTANT: Player immune to all damage!
            If bHH_OptionDevTracking                                            ; If player wants dev messages...
                Debug.Notification("Hitchhiker: Player is a ghost!")            ; display dev message
            EndIf
        EndIf                                                                   ; *** Set ghost now BEFORE the spin! ***
    EndIf                                                                       ; NOTE: Unghosting happens in HH_StopSpinning()

    Game.ForceFirstPerson()                                                     ; IMPORTANT: Must start/run spin in first person!

    ; Thx steve40 for distance & setini code!
    Float CamMinDistance = HH_OptionCamMinDistance.GetValue()                   ; Player chooses min distance (default: 100, vanilla: 0)
    Float CamMaxDistance = HH_OptionCamMaxDistance.GetValue()                   ; Player chooses max distance (default: 200, vanilla: 150)
    Utility.SetIniFloat("fVanityModeMinDist:Camera", CamMinDistance)            ; Set min
    Utility.SetIniFloat("fVanityModeMaxDist:Camera", CamMaxDistance)            ; Set max

    Utility.SetINIBool("bForceAutoVanityMode:Camera", true)                     ; Spin the idle camera around player

    HH_IsSpinning.SetValue(1)                                                   ; Flag player / camera as spinning

    StartTimer(HH_OptionSpinDuration.GetValueInt(), HH_TIMER_STOPSPINNING)      ; Wait define time (default: 20 sec) then call StopSpinning
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH STOP SPINNING
; ------------------------------------------------------------------------------------------------------------

Function HH_StopSpinning()
    CancelTimer(HH_TIMER_STOPSPINNING)                                  ; Cancel any StopSpinning timer in case we called manually somewhere

    If Player.IsGhost()                                                         ; If player is a ghost,
        Player.SetGhost(false)                                                  ; IMPORTANT: Undo player's temporary invulnerability
        If bHH_OptionDevTracking                                                ; If player wants dev messages
            If Player.IsGhost() == false                                        ; If player is no longer a ghost,
                Debug.Notification("Hitchhiker: Player is not a ghost.")        ; display dev message
            EndIf
        EndIf
    EndIf

    If HH_IsSpinning.GetValueInt() == 1                                         ; If player is spinning,
        Utility.SetINIBool("bForceAutoVanityMode:Camera", false)                ; stop spinning
        Game.ForceFirstPerson()                                                 ; IMPORTANT: Call this or spin will last forever!
        HH_IsSpinning.SetValue(0)                                               ; Flag player / camera as no longer spinning
    EndIf                                                                       ; Done with optional spincam effect
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH_Check_Destination_Plugin
; ------------------------------------------------------------------------------------------------------------

bool Function HH_Check_Destination_Plugin(GoStructTeleports[] Destinations, Int TargetID, Int PluginID)
    ; returns true if our target teleport id is the compare check id
    return Destinations[TargetID].teleportGoFile == PluginID as bool
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET RANDOM DESTINATION
; ------------------------------------------------------------------------------------------------------------

Function HH_SetRandomDestination(Int Category)
    Int TargetCount
    GoStructTeleports[] TargetData
    Int TargetID
    bool ReRoll
    bool ExcludeFH = HH_OptionExcludeFH.GetValue()
    bool ExcludeNW = HH_OptionExcludeNW.GetValue()
    bool ExcludeVT = HH_OptionExcludeVT.GetValue()

    If !bHH_PlayerHasFH
        ExcludeFH = true
    EndIf

    If !bHH_PlayerHasNW
        ExcludeNW = true
    EndIf

    If !bHH_PlayerHasVT
        ExcludeVT = true
    EndIf

    If Category == BUS_SHELTERS
        TargetData = DestGo_Bus
    ElseIf Category == DINERS
        TargetData = DestGo_Diner
    ElseIf Category == DIVES
        TargetData = DestGo_Dive
    ElseIf Category == DRIVE_INS
        TargetData = DestGo_Drive
    ElseIf Category == FACTORIES
        TargetData = DestGo_Factory
    ElseIf Category == FARMS
        TargetData = DestGo_Farm
    ElseIf Category == JUNKYARDS
        TargetData = DestGo_Junkyard
    ElseIf Category == MILITARY_BASES
        TargetData = DestGo_Military
    ElseIf Category == MONUMENTS
        TargetData = DestGo_Monument
    ElseIf Category == POWER_LIFTS
        TargetData = DestGo_Power
    ElseIf Category == RED_ROCKETS
        TargetData = DestGo_Red
    ElseIf Category == VAULTS
        TargetData = DestGo_Vault
    Else
        ; category requested is invalid so abort.
        return
    EndIf

    TargetCount = TargetData.Length

    HH_DebugTraceBox("Hitchhiker\nCategory is " + Category + ".\n TargetCount is " + TargetCount +".")

    ; ********************************************************************************************************
    ; Do-while functionality. Only loops if rolled destination is unwanted DLC.
    ; ********************************************************************************************************

    ReRoll = true

    While ReRoll
        ReRoll = false
        TargetID = Utility.RandomInt(0, (TargetCount - 1))                      ; Roll random 0 through (count - 1)

        If TargetData[TargetID].teleportTarget == 0
            Reroll = true
        ElseIf ExcludeFH && HH_Check_Destination_Plugin(TargetData, TargetID, Go_File_FH)
            ReRoll = true
            HH_DebugTraceBox("Hitchhiker: FH ReRoll.")
        ElseIf ExcludeNW && HH_Check_Destination_Plugin(TargetData, TargetID, Go_File_NW)
            ReRoll = true
            HH_DebugTraceBox("Hitchhiker: NW ReRoll.")
        ElseIf ExcludeVT && HH_Check_Destination_Plugin(TargetData, TargetID, Go_File_VT)
            ReRoll = true
            HH_DebugTraceBox("Hitchhiker: VT ReRoll.")
        EndIf
    EndWhile

    HH_Category.SetValue(Category)
    HH_TargetID.SetValue(TargetID)

    HH_DebugTraceBox("Hitchhiker\nCategory is " + Category + ".\nTargetID is " + TargetID +".")
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH TRY TO USE FURNITURE
; ------------------------------------------------------------------------------------------------------------

bool Function HH_TryToUseFurniture(Actor Person, ObjectReference TargetRef)
    bool DidItWork = false

    If !HH_OptionSitFurniture.GetValue() as bool                                ; If our option to skip furniture sitting is enabled get out
        return DidItWork
    EndIf

    If TargetRef.GetBaseObject() is Furniture                                   ; If target can be used (chair, wall lean, etc)
        If TargetRef.IsFurnitureInUse(True) == False                            ; and target is not in use right now (ignores reserved)
            DidItWork = TargetRef.Activate(Person)                              ; then attempt to use the furniture
        EndIf
    EndIf

    Return DidItWork
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE TIME
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceTime(Int TargetHour)
    Int CurrentHour = pGameHour.GetValueInt()                                   ; Get current game hour
    Int MyDuration                                                              ; and determine how long to wait

    If TargetHour < 0 || TargetHour > 24                                        ; set a default if the time variable is invalid
        TargetHour = 9
    EndIf

    If CurrentHour < TargetHour                                                 ; If target is later in same day,
        MyDuration = TargetHour - CurrentHour                                   ; waiting period is easy to calculate
    Else
        Int Difference = CurrentHour - TargetHour
        MyDuration = 24 - Difference                                            ; else duration is difference subtracted from midnight
    EndIf

    If MyDuration > 0 && MyDuration < 24                                        ; If duration will result in a time change,
        ; PassTime is erratic for some reason: Game.PassTime(MyDuration)
        ; Replacing with something that actually works...
        ; Thanks to: https://forums.nexusmods.com/index.php?/topic/776172-setting-game-time-to-a-specific-time/

        While MyDuration < 4                                                    ; Game.PassTime is bugged and does 4 hour increments regardless
            Game.PassTime(4)                                                    ; of passed value if > 0. Do loop and reduce offset 4 hours
            MyDuration -= 4
        EndWhile

        pGameHour.Mod(MyDuration)                                               ; jump the rest of the way to our desired time
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE WEATHER
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceWeather(Int MyForecast)
    If !Player.IsInInterior()                                                   ; If destination is NOT indoors...
        Weather MyWeather

        If MyForecast == 1
            MyWeather = CommonwealthClear                                       ; Clear
        ElseIf MyForecast == 2
            MyWeather = CommonwealthDusty                                       ; Dusty
        ElseIf MyForecast == 3
            MyWeather = CommonwealthFoggy                                       ; Foggy
        ElseIf MyForecast == 4
            MyWeather = CommonwealthMisty                                       ; Misty
        ElseIf MyForecast == 5
            MyWeather = CommonwealthMistyRainy                                  ; Misty Rainy
        ElseIf MyForecast == 6
            MyWeather = CommonwealthOvercast                                    ; Overcast
        ElseIf MyForecast == 7
            MyWeather = CommonwealthGSRadstorm                                  ; Radstorm
        ElseIf MyForecast == 8
            MyWeather = CommonwealthRain                                        ; Rain
        Else
            MyWeather = DefaultWeather                                          ; Default Weather (outdoors)
        EndIf

        MyWeather.ForceActive()                                                 ; Force weather change now
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH MARK TALES ON MAP
; ------------------------------------------------------------------------------------------------------------

Function HH_MarkTalesOnMap()
    Int[] ArrTales = New Int[14]                                                ; Hex array of map marker refs

    ArrTales[ 0] = 0x02bb11                                                     ; #1 My Brain and I (Boston Mayoral Shelter)
    ArrTales[ 1] = 0x02c691                                                     ; #2 The Starlet Sniper (Coast Guard Pier)
    ArrTales[ 2] = 0x02c241                                                     ; #3 Attack of the Metal Men (Dunwich Borers)
    ArrTales[ 3] = 0x066905                                                     ; #4 Invasion of the Zetans (Hubris Comics)
    ArrTales[ 4] = 0x02c170                                                     ; #6 Attack of the Fishmen (Skylanes Flight 1981)
    ArrTales[ 5] = 0x02495a                                                     ; #7 Deep Sea Terror (Outpost Zimonja)
    ArrTales[ 6] = 0x01e307                                                     ; #8 The Man Who Could Stop Time (Vault 114/Parkstreet Station)
    ArrTales[ 7] = 0x14d16f                                                     ; #9 When Apes Go Bananas (Railroad HQ)
    ArrTales[ 8] = 0x0adda4                                                     ; #10 Giant Insects Invade (Sentinel Site)
    ArrTales[ 9] = 0x02b7cc                                                     ; #12 Have Dog Will Travel (The Institute)
    ArrTales[10] = 0x0add89                                                     ; #13 Curse of the Burned (Crater of Atom)
    ArrTales[11] = 0x08cb75                                                     ; #41 The Mad Russian's Revenge (Pickman Gallery)
    ArrTales[12] = 0x01d6e7                                                     ; #43 Rise of the Mutants (Trinity Church)
    ArrTales[13] = 0x02b88f                                                     ; #121 Rise of the Radiated (East Boston Prep School)

    Int i = 0
    ObjectReference MapRef
    While i < 14
        MapRef = Game.GetFormFromFile(ArrTales[i], Go_Files[Go_File_FO4].Name) as ObjectReference
        MapRef.AddToMap()           ; add map marker to map
        If MapRef.IsDisabled()
            Debug.Trace("HITCHHIKER: Enabling index " + i + " MapMarker " + MapRef)
            MapRef.Enable()
        EndIf
        i += 1
    EndWhile
EndFunction

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON PLAYER LOAD GAME
; ------------------------------------------------------------------------------------------------------------

Event Actor.OnPlayerLoadGame(Actor akSender)
    HH_Check_DLCS()                                                             ; recheck for installed DLC in case they are added or removed
    HH_Build_Destination_Arrays()                                               ; added in case the script is ever modified
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH CHECK DLCS
; ------------------------------------------------------------------------------------------------------------

Function HH_Check_DLCS()
    HH_CheckChoiceChopped()                                                     ; Does player have Choice Chopped mod?
    bHH_PlayerHasFH = Game.IsPluginInstalled("DLCCoast.esm")                    ; Does player have Far Harbor DLC?
    bHH_PlayerHasNW = Game.IsPluginInstalled("DLCNukaWorld.esm")                ; Does player have Nuka-World DLC?
    bHH_PlayerHasVT = Game.IsPluginInstalled("DLCworkshop03.esm")               ; Does player have Vault-Tec DLC?
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH CHECK CHOICE CHOPPED
; ------------------------------------------------------------------------------------------------------------

Function HH_CheckChoiceChopped()                                                ; Does player have Choice Chopped mod?
    bHH_PlayerHasChoiceChopped = Game.IsPluginInstalled("ChoiceChopped.esp")    ; CC & HH both add Dandelion Wine to cooking stations,
EndFunction                                                                     ; so HH only adds wine if no CC (prevents duplicate recipes)

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH CALCULATE REWARDS
; ------------------------------------------------------------------------------------------------------------

Function HH_CalculateRewards()
    float fRequiredVisits = HH_OptionSetRewards.Value                                 ; Default is 5 per category but player can change in menu
                                                                                ; Category reqs can be repeat visits or hitches to new sites

    Int Category = HH_Category.GetValueInt()
    bool bRewardWait = HH_OptionSetRewards.GetValueInt()

    ;syntax HH_CheckRewardItem(RequiredVisits, WaitForVisits, GlobalVisitCount, RewardItem, GlobalRewardedFlag)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountBus     , HH_Rewards_Bus     , HH_Rewarded_Bus)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountDiner   , HH_Rewards_Diner   , HH_Rewarded_Diner)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountDive    , HH_Rewards_Dive    , HH_Rewarded_Dive)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountDrive   , HH_Rewards_Drive   , HH_Rewarded_Drive)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountFactory , HH_Rewards_Factory , HH_Rewarded_Factory)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountFarm    , HH_Rewards_Farm    , HH_Rewarded_Farm)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountJunkyard, HH_Rewards_Junkyard, HH_Rewarded_Junkyard)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountMilitary, HH_Rewards_Military, HH_Rewarded_Military)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountMonument, HH_Rewards_Monument, HH_Rewarded_Monument)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountPower   , HH_Rewards_Power   , HH_Rewarded_Power)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountRed     , HH_Rewards_Red     , HH_Rewarded_Red)
    HH_CheckRewardItem(fRequiredVisits, bRewardWait, HH_CountVault   , HH_Rewards_Vault   , HH_Rewarded_Vault)

    HH_CalculateGrandPrize()

    ; CORPORATE REWARDS
    HH_CalculateCorporateDrumlin()
    HH_CalculateCorporateSlocums()
    HH_CalculateCorporateSpuckies()
    HH_CalculateCorporateSuperDuperMart()
EndFunction

Function HH_CheckRewardItem(float fRequiredVisits = -1.0, bool bRewardWait = true, GlobalVariable VisitCount = None, Form Reward = None, GlobalVariable Rewarded = None)
    If !Reward || !Rewarded                                                     ; error check for missing requirements
        Debug.TraceFunction("HITCHHIKER: HH_CheckRewardItem()\n    Invalid Reward or Global flag.")
        return
    ElseIf !VisitCount                                                          ; if count not defined we're calling for explicit add item
        Player.AddItem(Reward)
        Rewarded.SetValue(1)
    ElseIf !Rewarded.Value && (!bRewardWait || VisitCount.Value >= fRequiredVisits)
        Player.AddItem(Reward)
        Rewarded.SetValue(1)
    EndIf
    Utility.Wait(0.01)                                                          ; small wait while in menu mode reviewing new item to block script processing
EndFunction

Function HH_CalculateGrandPrize()
    If !HH_Rewarded_Recipe.GetValue()
        ; Grab updated current values for grand prize calculation

        bool[] CheckReq = New bool[12]
        CheckReq[ 0] = HH_Rewarded_Bus.GetValue()
        CheckReq[ 1] = HH_Rewarded_Diner.GetValue()
        CheckReq[ 2] = HH_Rewarded_Dive.GetValue()
        CheckReq[ 3] = HH_Rewarded_Drive.GetValue()
        CheckReq[ 4] = HH_Rewarded_Factory.GetValue()
        CheckReq[ 5] = HH_Rewarded_Farm.GetValue()
        CheckReq[ 6] = HH_Rewarded_Junkyard.GetValue()
        CheckReq[ 7] = HH_Rewarded_Military.GetValue()
        CheckReq[ 8] = HH_Rewarded_Monument.GetValue()
        CheckReq[ 9] = HH_Rewarded_Power.GetValue()
        CheckReq[10] = HH_Rewarded_Red.GetValue()
        CheckReq[11] = HH_Rewarded_Vault.GetValue()

        Int i = 0
        bool Failed = false

        While i < CheckReq.Length && !Failed
            If !CheckReq[i]
                Failed = true
            EndIf

            i += 1
        EndWhile

        If !Failed                                                              ; If requirement has been met in all categories,
            Player.AddItem(HH_Rewards_Thanks)                                   ; award the grand prize list to player
            ; HH_Rewarded_Recipe.SetValue(1) ERROR BY TGM: This flag is toggled by HH_UnlockRecipe script when note is read!
            HH_MarkTalesOnMap()
        EndIf
    EndIf
EndFunction

Function HH_CalculateCorporateDrumlin()
    If HH_Rewarded_Drumlin.GetValueInt() == 0
        bool VisitedDrumlin1 = HH_VisitedDrumlin1.GetValue()
        bool VisitedDrumlin2 = HH_VisitedDrumlin2.GetValue()
        bool VisitedDrumlin3 = HH_VisitedDrumlin3.GetValue()
        bool VisitedDrumlin4 = HH_VisitedDrumlin4.GetValue()
        bool VisitedDrumlin5 = HH_VisitedDrumlin5.GetValue()

        If VisitedDrumlin1 && VisitedDrumlin2 && VisitedDrumlin3 && VisitedDrumlin4 && VisitedDrumlin5
            Player.AddItem(HH_Rewards_Drumlin)
            HH_Rewarded_Drumlin.SetValue(1)
        EndIf
    EndIf
EndFunction

Function HH_CalculateCorporateSlocums()
    If HH_Rewarded_Slocums.GetValueInt() == 0
        bool VisitedSlocums1 = HH_VisitedSlocums1.GetValue()
        bool VisitedSlocums2 = HH_VisitedSlocums2.GetValue()
        bool VisitedSlocums3 = HH_VisitedSlocums3.GetValue()
        bool VisitedSlocums4 = HH_VisitedSlocums4.GetValue()

        If VisitedSlocums1 && VisitedSlocums2 && VisitedSlocums3 && VisitedSlocums4
            Player.AddItem(HH_Rewards_Slocums)
            HH_Rewarded_Slocums.SetValue(1)
        EndIf
    EndIf
EndFunction

Function HH_CalculateCorporateSpuckies()
    If HH_Rewarded_Spuckies.GetValueInt() == 0
        bool VisitedSpuckies1 = HH_VisitedSpuckies1.GetValue()
        bool VisitedSpuckies2 = HH_VisitedSpuckies2.GetValue()
        bool VisitedSpuckies3 = HH_VisitedSpuckies3.GetValue()

        If VisitedSpuckies1 && VisitedSpuckies2 && VisitedSpuckies3
            Player.AddItem(HH_Rewards_Spuckies)
            HH_Rewarded_Spuckies.SetValue(1)
        EndIf
    EndIf
EndFunction

Function HH_CalculateCorporateSuperDuperMart()
    If HH_Rewarded_Super.GetValueInt() == 0
        bool VisitedSuper1 = HH_VisitedSuper1.GetValue()
        bool VisitedSuper2 = HH_VisitedSuper2.GetValue()
        bool VisitedSuper3 = HH_VisitedSuper3.GetValue()

        If bHH_PlayerHasFH                                                      ; If player does NOT have Far Harbor DLC,
            VisitedSuper1 = true                                                ; do not require Far Harbor Super Duper Mart
        EndIf

        If VisitedSuper1 && VisitedSuper2 && VisitedSuper3
            Player.AddItem(HH_Rewards_Super)
            HH_Rewarded_Super.SetValue(1)
        EndIf
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH DEBUGTRACEBOX
; ------------------------------------------------------------------------------------------------------------

Function HH_DebugTraceBox(String TraceString)
    If bHH_OptionDevTracking
        Debug.TraceAndBox(TraceString)
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH ENABLEDEBUG
; ------------------------------------------------------------------------------------------------------------

Function HH_EnableDebug()
    bHH_OptionDevTracking = true
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH DISABLEDEBUG
; ------------------------------------------------------------------------------------------------------------

Function HH_DisableDebug()
    bHH_OptionDevTracking = false                                               ; TGM: Changed "true" to "false" here 20180201
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH DISABLEPLAYERCONTROLS
; ------------------------------------------------------------------------------------------------------------

Function HH_DisablePlayerControls()
    layerDisableControls = InputEnableLayer.Create()
    layerDisableControls.DisablePlayerControls()
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH ENABLEPLAYERCONTROLS
; ------------------------------------------------------------------------------------------------------------

Function HH_EnablePlayerControls()
    layerDisableControls = None                                                 ; per documentation setting layer to None disables it once all references to it are gone
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: VALIDATE DATA
; ------------------------------------------------------------------------------------------------------------

Function Validate_Data()
    ; Used as a debug tool to verify teleport targets will be reachable. Open console and type: CQF HH_Quest Validate_Data
    Validate_Data_Helper(DestGo_Bus, "Bus")
    Validate_Data_Helper(DestGo_Diner, "Diner")
    Validate_Data_Helper(DestGo_Dive, "Dive")
    Validate_Data_Helper(DestGo_Drive, "Drive")
    Validate_Data_Helper(DestGo_Factory, "Factory")
    Validate_Data_Helper(DestGo_Farm, "Farm")
    Validate_Data_Helper(DestGo_Junkyard, "Junkyard")
    Validate_Data_Helper(DestGo_Military, "Military")
    Validate_Data_Helper(DestGo_Monument, "Monument")
    Validate_Data_Helper(DestGo_Power, "Power")
    Validate_Data_Helper(DestGo_Red, "Red")
    Validate_Data_Helper(DestGo_Vault, "Vault")
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: VALIDATE DATA HELPER
; ------------------------------------------------------------------------------------------------------------

Function Validate_Data_Helper(GoStructTeleports[] Data, String sSource)
    ; This will loop the data structure trying to grab the ref of the teleport target and verify it can be used.
    ; If it is non-persistent it will fail if not in the loaded area.
    Debug.Trace("HITCHHIKER VALIDATE: " + sSource + "\n")
    int iCounter = 0
    while iCounter < Data.Length
        Debug.Trace("  Testing index " + iCounter)
        if !(Game.GetFormFromFile(Data[iCounter].teleportTarget, Go_Files[Data[iCounter].teleportGoFile].Name) as ObjectReference)
            Debug.Trace("      FAILED Target:  #" + iCounter + " " + Data[iCounter].teleportTarget + " " + Go_Files[Data[iCounter].teleportGoFile].Name)
        endif
        iCounter += 1
    endwhile
EndFunction
