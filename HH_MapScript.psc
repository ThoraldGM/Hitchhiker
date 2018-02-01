Scriptname HH_MapScript extends ObjectReference
{ It just works. }

;/

Fallout 4 Papyrus script by ThoraldGM | https://modforge.net | Updated 20180201
Hitchhiker mod: https://www.nexusmods.com/fallout4/mods/29273

SCRIPT SECTIONS:

LINE 0052: PROPERTIES
LINE 0241: ON READ
LINE 0260: HH SHOW MAIN MENU
LINE 0298: HH SHOW THE ANY MENU
LINE 0325: HH SHOW THE SPECIFIC MENU
LINE 0358: HH SHOW MENU BUS SHELTERS
LINE 0380: HH SHOW MENU DINERS 1
LINE 0404: HH SHOW MENU DINERS 2
LINE 0428: HH SHOW MENU DINERS 3
LINE 0450: HH SHOW MENU DIVES
LINE 0472: HH SHOW MENU DRIVE INS
LINE 0494: HH SHOW MENU FACTORIES
LINE 0516: HH SHOW MENU FARMS
LINE 0538: HH SHOW MENU JUNKYARDS 1
LINE 0562: HH SHOW MENU JUNKYARDS 2
LINE 0584: HH SHOW MENU MILITARY BASES 1
LINE 0608: HH SHOW MENU MILITARY BASES 2
LINE 0630: HH SHOW MENU MONUMENTS 1
LINE 0654: HH SHOW MENU MONUMENTS 2
LINE 0678: HH SHOW MENU MONUMENTS 3
LINE 0700: HH SHOW MENU POWER LIFTS 1
LINE 0741: HH SHOW MENU POWER LIFTS 2
LINE 0782: HH SHOW MENU RED ROCKET 1
LINE 0836: HH SHOW MENU RED ROCKET 2
LINE 0884: HH SHOW MENU VAULTS
LINE 0906: HH SHOW DLC OPTIONS
LINE 0942: HH SHOW CAMERA OPTIONS
LINE 0972: HH SHOW SET MAX
LINE 1004: HH SHOW SET MIN
LINE 1036: HH SHOW SET DURATION
LINE 1068: HH SHOW TELEPORT OPTIONS
LINE 1124: HH SHOW SET TIME
LINE 1160: HH SHOW SET WEATHER
LINE 1196: HH SHOW ADVANCED OPTIONS
LINE 1242: HH SHOW SET REWARDS
LINE 1276: HH SET MENU DEFAULTS
LINE 1301: ON MENU OPEN CLOSE EVENT

/;

; ------------------------------------------------------------------------------------------------------------
; PROPERTIES
; ------------------------------------------------------------------------------------------------------------

; ************************************************************************************************************
; Player menu options:
; ************************************************************************************************************
GlobalVariable Property HH_OptionCamMaxDistance Auto Mandatory
{ Max camera distance (default: 200, vanilla: 150) }
GlobalVariable Property HH_OptionCamMinDistance Auto Mandatory
{ Min camera distance (default: 100, vanilla: 0) }
GlobalVariable Property HH_OptionExcludeFH Auto Mandatory
{ Turn Far Harbor DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeNW Auto Mandatory
{ Turn Nuka-World DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeVT Auto Mandatory
{ Turn Vault-Tec DLC on/off in destinations (default: off) }
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
{ When destination is furniture, choose whether to use it (default: yes) }
GlobalVariable Property HH_OptionSpinCamera Auto Mandatory
{ Does player want teleport to spin camera? (default: yes) }
GlobalVariable Property HH_OptionSpinDuration Auto Mandatory
{ How long should camera spin? (default: 20 seconds) }
GlobalVariable Property HH_OptionSpinGhost Auto Mandatory
{ Does player want invulnerable spin? (default: yes) }
GlobalVariable Property HH_OptionTeleportSound Auto Mandatory
{ Does player want teleport sound? (default: yes) }
GlobalVariable Property HH_OptionVaultBoy Auto Mandatory
{ Does player want Vault Boy animations? (default: yes) }

; ************************************************************************************************************
; Menus:
; ************************************************************************************************************
Message Property HH_MenuMessage Auto Const Mandatory
{ Main menu }
Message Property HH_DestMessageAny Auto Const Mandatory
{ Any menu }
Message Property HH_DestMessageSpecific Auto Const Mandatory
{ Specific menu }
Message Property HH_DestMessageSpecificBusShelters Auto Const Mandatory
{ Specific: Bus Shelters }
Message Property HH_DestMessageSpecificDiners1 Auto Const Mandatory
{ Specific: Diners 1 }
Message Property HH_DestMessageSpecificDiners2 Auto Const Mandatory
{ Specific: Diners 2 }
Message Property HH_DestMessageSpecificDiners3 Auto Const Mandatory
{ Specific: Diners 3 }
Message Property HH_DestMessageSpecificDives Auto Const Mandatory
{ Specific: Dives }
Message Property HH_DestMessageSpecificDriveIns Auto Const Mandatory
{ Specific: Drive-Ins }
Message Property HH_DestMessageSpecificFactories Auto Const Mandatory
{ Specific: Factories }
Message Property HH_DestMessageSpecificFarms Auto Const Mandatory
{ Specific: Farms }
Message Property HH_DestMessageSpecificJunkyards1 Auto Const Mandatory
{ Specific: Junkyards 1 }
Message Property HH_DestMessageSpecificJunkyards2 Auto Const Mandatory
{ Specific: Junkyards 2 }
Message Property HH_DestMessageSpecificMilitaryBases1 Auto Const Mandatory
{ Specific: Military Bases 1 }
Message Property HH_DestMessageSpecificMilitaryBases2 Auto Const Mandatory
{ Specific: Military Bases 2 }
Message Property HH_DestMessageSpecificMonuments1 Auto Const Mandatory
{ Specific: Monuments 1 }
Message Property HH_DestMessageSpecificMonuments2 Auto Const Mandatory
{ Specific: Monuments 2 }
Message Property HH_DestMessageSpecificMonuments3 Auto Const Mandatory
{ Specific: Monuments 3 }
Message Property HH_DestMessageSpecificPowerLifts1 Auto Const Mandatory
{ Specific: Power Lifts 1 }
Message Property HH_DestMessageSpecificPowerLifts2 Auto Const Mandatory
{ Specific: Power Lifts 2 }
Message Property HH_DestMessageSpecificRedRocket1 Auto Const Mandatory
{ Specific: Red Rockets 1 }
Message Property HH_DestMessageSpecificRedRocket2 Auto Const Mandatory
{ Specific: Red Rockets 2 }
Message Property HH_DestMessageSpecificVaults Auto Const Mandatory
{ Specific: Vaults }

Message Property HH_MenuMessageDLCOptions Auto Const Mandatory
{ DLCOptions menu }

Message Property HH_MenuMessageCameraOptions Auto Const Mandatory
{ CameraOptions menu }
Message Property HH_MenuMessageSetMax Auto Const Mandatory
{ Camera: Set Max Distance }
Message Property HH_MenuMessageSetMin Auto Const Mandatory
{ Camera: Set Min Distance }
Message Property HH_MenuMessageSetDuration Auto Const Mandatory
{ Camera: Set Spin Duration }

Message Property HH_MenuMessageTeleportOptions Auto Const Mandatory
{ TeleportOptions menu }
Message Property HH_MenuMessageSetTime Auto Const Mandatory
{ SetTime menu }
Message Property HH_MenuMessageSetWeather Auto Const Mandatory
{ SetWeather menu }

Message Property HH_MenuMessageAdvancedOptions Auto Const Mandatory
{ AdvancedOptions menu }
Message Property HH_MenuMessageSetRewards Auto Const Mandatory
{ SetRewards menu }

; ************************************************************************************************************
; Rewards:
; ************************************************************************************************************
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

; ************************************************************************************************************
; Everything else:
; ************************************************************************************************************
FormList Property pShipmentItemList Auto Const Mandatory
{ Vanilla CK list of all component shipments }
GlobalVariable Property HH_IsSpinning Auto Mandatory
{ Is the camera currently spinning? }
GlobalVariable Property HH_Category Auto Mandatory
{ Which category did player select? }
GlobalVariable Property HH_TargetID Auto Mandatory
{ Which location did player select? }
GlobalVariable Property HH_ShowMenu Auto Mandatory
{ Don't show menu when map not in inventory }
GlobalVariable Property HH_Version Auto Mandatory
{ Current version of Hitchhiker (for map menu) }
Quest Property HH_Quest Auto Const Mandatory
{ Hitchhiker main quest }
HH_QuestScript Property HHQuestScript Auto
{ Hitchhiker main quest script }

Actor Player                                                                    ; Player actor

Float CurrentStatus                                                             ; Placeholder for current global values (for map menu)

Int BUS_SHELTERS = 1 const                                                      ; Category ints (makes code easier to read)
Int DINERS = 2 const
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

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON READ
; ------------------------------------------------------------------------------------------------------------

Event OnRead()
    Player = Game.GetPlayer()                                                   ; Player actor

    If GetContainer() != Player                                                 ; If hitchhiker map is not in inventory (on ground, etc)
        HH_ShowMenu.SetValue(0)                                                 ; do not show the menu
    EndIf

    If HH_ShowMenu.GetValue() as Int == 1                                       ; Default value is zero so "awesome" message plays on add
        Utility.WaitMenuMode(2)                                                 ; Give magazine a moment to fill menu background
        HH_ShowMainMenu()                                                       ; then show the main menu
    Else
        HH_ShowMenu.SetValue(1)                                                 ; Added to inventory, so show menu from now on
    EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MAIN MENU
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMainMenu()
    CurrentStatus = HH_Version.GetValue()                                       ; Grab the current version number
    Int MainButtonPressed = HH_MenuMessage.Show(CurrentStatus)                  ; MAIN menu shows and waits for player response

    If MainButtonPressed == 0                                                   ; Main: Choose Random Location
        HH_ShowTheAnyMenu()
    ElseIf MainButtonPressed == 1                                               ; Main: Choose Specific Location
        HH_ShowTheSpecificMenu()
    ElseIf MainButtonPressed == 2                                               ; Main: Force Time Now (after Pip-Boy closes)
        ; Advancing time should be done outside pipboy.
        UnregisterForMenuOpenCloseEvent("PipboyMenu")                           ; Cancel any previous button spams
        Utility.WaitMenuMode(0.1)                                               ; Give unregister a moment to work
        RegisterForMenuOpenCloseEvent("PipboyMenu")                             ; then handle time change in the event
    ElseIf MainButtonPressed == 3                                               ; Main: Force Weather Now
        Int PrefWeather = HH_OptionSetWeatherPreference.GetValue() as Int
        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_ForceWeather(PrefWeather)
    ElseIf MainButtonPressed == 4                                               ; Main: Spin Idle Camera Now
        HHQuestScript.HH_SpinCamera()
    ElseIf MainButtonPressed == 5                                               ; Main: Stop Idle Camera Now
        HHQuestScript.HH_StopSpinning()
    ElseIf MainButtonPressed == 6                                               ; Main: Camera Options
        HH_ShowCameraOptions()
    ElseIf MainButtonPressed == 7                                               ; Main: Teleport Options
        HH_ShowTeleportOptions()
    ElseIf MainButtonPressed == 8                                               ; Main: Restore Defaults
        HH_SetMenuDefaults()
        Utility.WaitMenuMode(0.1)
        HH_ShowMainMenu()
    ElseIf MainButtonPressed == 9                                               ; Main: Exit Menu
        ; Exit Menu
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW THE ANY MENU
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowTheAnyMenu()
    Int Selected = HH_DestMessageAny.Show()                                     ; ANY menu shows and waits for player response

    If Selected == 0                                                            ; If anywhere,
        Selected = Utility.RandomInt(1, 12)                                     ; roll a category for player
    EndIf

    HHQuestScript.HH_DebugTraceBox("Hitchhiker: Selected category is " + Selected + ".")

    If Selected > 0 && Selected <= 12
        HHQuestScript.HH_SetRandomDestination(Selected)
        Int CountRandom = HH_CountRandom.GetValue() as Int
        HH_CountRandom.SetValue(CountRandom + 1)
        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowMainMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW THE SPECIFIC MENU
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowTheSpecificMenu()
    Int SpecButtonPressed = HH_DestMessageSpecific.Show()                       ; SPEC menu shows and waits for player response

    If SpecButtonPressed == 0
        HH_ShowMenuBusShelters()
    ElseIf SpecButtonPressed == 1
        HH_ShowMenuDiners1()
    ElseIf SpecButtonPressed == 2
        HH_ShowMenuDriveIns()
    ElseIf SpecButtonPressed == 3
        HH_ShowMenuDives()
    ElseIf SpecButtonPressed == 4
        HH_ShowMenuFactories()
    ElseIf SpecButtonPressed == 5
        HH_ShowMenuFarms()
    ElseIf SpecButtonPressed == 6
        HH_ShowMenuJunkyards1()
    ElseIf SpecButtonPressed == 7
        HH_ShowMenuMilitaryBases1()
    ElseIf SpecButtonPressed == 8
        HH_ShowMenuMonuments1()
    ElseIf SpecButtonPressed == 9
        HH_ShowMenuPowerLifts1()
    ElseIf SpecButtonPressed == 10
        HH_ShowMenuRedRocket1()
    ElseIf SpecButtonPressed == 11
        HH_ShowMenuVaults()
    Else
        HH_ShowMainMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU BUS SHELTERS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuBusShelters()
    Int Selected = HH_DestMessageSpecificBusShelters.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(BUS_SHELTERS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountBus = HH_CountBus.GetValue() as Int
        HH_CountBus.SetValue(CountBus + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU DINERS 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuDiners1()
    Int Selected = HH_DestMessageSpecificDiners1.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(DINERS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountDiner = HH_CountDiner.GetValue() as Int
        HH_CountDiner.SetValue(CountDiner + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuDiners2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU DINERS 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuDiners2()
    Int Selected = HH_DestMessageSpecificDiners2.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(DINERS)
        HH_TargetID.SetValue((Selected + 10))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountDiner = HH_CountDiner.GetValue() as Int
        HH_CountDiner.SetValue(CountDiner + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuDiners3()
    Else
        HH_ShowMenuDiners1()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU DINERS 3
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuDiners3()
    Int Selected = HH_DestMessageSpecificDiners3.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(DINERS)
        HH_TargetID.SetValue((Selected + 20))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountDiner = HH_CountDiner.GetValue() as Int
        HH_CountDiner.SetValue(CountDiner + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowMenuDiners2()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU DIVES
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuDives()
    Int Selected = HH_DestMessageSpecificDives.Show()

    If Selected >= 0 && Selected <= 12
        HH_Category.SetValue(DIVES)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountDive = HH_CountDive.GetValue() as Int
        HH_CountDive.SetValue(CountDive + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU DRIVE INS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuDriveIns()
    Int Selected = HH_DestMessageSpecificDriveIns.Show()

    If Selected >= 0 && Selected <= 11
        HH_Category.SetValue(DRIVE_INS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountDrive = HH_CountDrive.GetValue() as Int
        HH_CountDrive.SetValue(CountDrive + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU FACTORIES
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuFactories()
    Int Selected = HH_DestMessageSpecificFactories.Show()

    If Selected >= 0 && Selected <= 11
        HH_Category.SetValue(FACTORIES)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountFactory = HH_CountFactory.GetValue() as Int
        HH_CountFactory.SetValue(CountFactory + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU FARMS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuFarms()
    Int Selected = HH_DestMessageSpecificFarms.Show()

    If Selected >= 0 && Selected <= 11
        HH_Category.SetValue(FARMS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountFarm = HH_CountFarm.GetValue() as Int
        HH_CountFarm.SetValue(CountFarm + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU JUNKYARDS 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuJunkyards1()
    Int Selected = HH_DestMessageSpecificJunkyards1.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(JUNKYARDS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountJunkyard = HH_CountJunkyard.GetValue() as Int
        HH_CountJunkyard.SetValue(CountJunkyard + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuJunkyards2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU JUNKYARDS 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuJunkyards2()
    Int Selected = HH_DestMessageSpecificJunkyards2.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(JUNKYARDS)
        HH_TargetID.SetValue((Selected + 10))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountJunkyard = HH_CountJunkyard.GetValue() as Int
        HH_CountJunkyard.SetValue(CountJunkyard + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowMenuJunkyards1()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU MILITARY BASES 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuMilitaryBases1()
    Int Selected = HH_DestMessageSpecificMilitaryBases1.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(MILITARY_BASES)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountMilitary = HH_CountMilitary.GetValue() as Int
        HH_CountMilitary.SetValue(CountMilitary + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuMilitaryBases2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU MILITARY BASES 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuMilitaryBases2()
    Int Selected = HH_DestMessageSpecificMilitaryBases2.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(MILITARY_BASES)
        HH_TargetID.SetValue((Selected + 10))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountMilitary = HH_CountMilitary.GetValue() as Int
        HH_CountMilitary.SetValue(CountMilitary + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowMenuMilitaryBases1()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU MONUMENTS 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuMonuments1()
    Int Selected = HH_DestMessageSpecificMonuments1.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(MONUMENTS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountMonument = HH_CountMonument.GetValue() as Int
        HH_CountMonument.SetValue(CountMonument + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuMonuments2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU MONUMENTS 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuMonuments2()
    Int Selected = HH_DestMessageSpecificMonuments2.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(MONUMENTS)
        HH_TargetID.SetValue((Selected + 10))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountMonument = HH_CountMonument.GetValue() as Int
        HH_CountMonument.SetValue(CountMonument + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    ElseIf Selected == 10
        HH_ShowMenuMonuments3()
    Else
        HH_ShowMenuMonuments1()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU MONUMENTS 3
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuMonuments3()
    Int Selected = HH_DestMessageSpecificMonuments3.Show()

    If Selected >= 0 && Selected <= 10
        HH_Category.SetValue(MONUMENTS)
        HH_TargetID.SetValue((Selected + 20))
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountMonument = HH_CountMonument.GetValue() as Int
        HH_CountMonument.SetValue(CountMonument + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowMenuMonuments2()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU POWER LIFTS 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuPowerLifts1()
    ; Power lifts are oldest part of file. Note the extra work because ABC order != TargetID order.

    Int Selected = HH_DestMessageSpecificPowerLifts1.Show()

    If Selected == 0
        HH_TargetID.SetValue(11)
    ElseIf Selected == 1
        HH_TargetID.SetValue(13)
    ElseIf Selected == 2
        HH_TargetID.SetValue(14)
    ElseIf Selected == 3
        HH_TargetID.SetValue(12)
    ElseIf Selected == 4
        HH_TargetID.SetValue(4)
    ElseIf Selected == 5
        HH_TargetID.SetValue(6)
    ElseIf Selected == 6
        HH_TargetID.SetValue(5)
    ElseIf Selected == 7
        HH_ShowMenuPowerLifts2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf

    If Selected >= 0 && Selected <= 6
        HH_Category.SetValue(POWER_LIFTS)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountPower = HH_CountPower.GetValue() as Int
        HH_CountPower.SetValue(CountPower + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU POWER LIFTS 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuPowerLifts2()
    ; Power lifts are oldest part of file. Note the extra work because ABC order != TargetID order.

    Int Selected = HH_DestMessageSpecificPowerLifts2.Show()

    If Selected == 0
        HH_TargetID.SetValue(10)
    ElseIf Selected == 1
        HH_TargetID.SetValue(1)
    ElseIf Selected == 2
        HH_TargetID.SetValue(8)
    ElseIf Selected == 3
        HH_TargetID.SetValue(9)
    ElseIf Selected == 4
        HH_TargetID.SetValue(3)
    ElseIf Selected == 5
        HH_TargetID.SetValue(7)
    ElseIf Selected == 6
        HH_TargetID.SetValue(0)
    ElseIf Selected == 7
        HH_TargetID.SetValue(2)
    Else
        HH_ShowMenuPowerLifts1()
    EndIf

    If Selected >= 0 && Selected <= 7
        HH_Category.SetValue(POWER_LIFTS)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountPower = HH_CountPower.GetValue() as Int
        HH_CountPower.SetValue(CountPower + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU RED ROCKET 1
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuRedRocket1()
    ; Red Rockets are oldest part of file. Note the extra work because ABC order != TargetID order.

    Int Selected = HH_DestMessageSpecificRedRocket1.Show()

    If Selected == 0
        HH_TargetID.SetValue(16)
    ElseIf Selected == 1
        HH_TargetID.SetValue(20)
    ElseIf Selected == 2
        HH_TargetID.SetValue(0)
    ElseIf Selected == 3
        HH_TargetID.SetValue(11)
    ElseIf Selected == 4
        HH_TargetID.SetValue(9)
    ElseIf Selected == 5
        HH_TargetID.SetValue(17)
    ElseIf Selected == 6
        HH_TargetID.SetValue(5)
    ElseIf Selected == 7
        HH_TargetID.SetValue(8)
    ElseIf Selected == 8
        HH_TargetID.SetValue(14)
    ElseIf Selected == 9
        HH_TargetID.SetValue(1)
    ElseIf Selected == 10
        HH_TargetID.SetValue(3)
    ElseIf Selected == 11
        HH_TargetID.SetValue(18)
    ElseIf Selected == 12
        HH_ShowMenuRedRocket2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf

    If Selected >= 0 && Selected <= 11
        HH_Category.SetValue(RED_ROCKETS)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountRed = HH_CountRed.GetValue() as Int
        HH_CountRed.SetValue(CountRed + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU RED ROCKET 2
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuRedRocket2()
    ; Red Rockets are oldest part of file. Note the extra work because ABC order != TargetID order.

    Int Selected = HH_DestMessageSpecificRedRocket2.Show()

    If Selected == 0
        HH_TargetID.SetValue(10)
    ElseIf Selected == 1
        HH_TargetID.SetValue(2)
    ElseIf Selected == 2
        HH_TargetID.SetValue(21)
    ElseIf Selected == 3
        HH_TargetID.SetValue(22)
    ElseIf Selected == 4
        HH_TargetID.SetValue(23)
    ElseIf Selected == 5
        HH_TargetID.SetValue(12)
    ElseIf Selected == 6
        HH_TargetID.SetValue(4)
    ElseIf Selected == 7
        HH_TargetID.SetValue(19)
    ElseIf Selected == 8
        HH_TargetID.SetValue(7)
    ElseIf Selected == 9
        HH_TargetID.SetValue(24)
    ElseIf Selected == 10
        HH_TargetID.SetValue(15)
    ElseIf Selected == 11
        HH_TargetID.SetValue(6)
    ElseIf Selected == 12
        HH_TargetID.SetValue(13)
    Else
        HH_ShowMenuRedRocket1()
    EndIf

    If Selected >= 0 && Selected <= 12
        HH_Category.SetValue(RED_ROCKETS)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountRed = HH_CountRed.GetValue() as Int
        HH_CountRed.SetValue(CountRed + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW MENU VAULTS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowMenuVaults()
    Int Selected = HH_DestMessageSpecificVaults.Show()

    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(VAULTS)
        HH_TargetID.SetValue(Selected)
        Int CountSpecific = HH_CountSpecific.GetValue() as Int
        Int CountVault = HH_CountVault.GetValue() as Int
        HH_CountVault.SetValue(CountVault + 1)
        HH_CountSpecific.SetValue(CountSpecific + 1)

        Utility.WaitMenuMode(0.1)
        HHQuestScript.HH_StartHitching()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW DLC OPTIONS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowDLCOptions()
    Int DLCOptionsBP = HH_MenuMessageDLCOptions.Show()                          ; DLCOptions shows and waits for player response

    If DLCOptionsBP == 0                                                        ; DLCOptions: Disable All DLC Randoms
        HH_OptionExcludeFH.SetValue(1)
        HH_OptionExcludeNW.SetValue(1)
        HH_OptionExcludeVT.SetValue(1)
    ElseIf DLCOptionsBP == 1                                                    ; DLCOptions: Enable All DLC Randoms
        HH_OptionExcludeFH.SetValue(0)
        HH_OptionExcludeNW.SetValue(0)
        HH_OptionExcludeVT.SetValue(0)
    ElseIf DLCOptionsBP == 2                                                    ; DLCOptions: Disable Far Harbor Randoms
        HH_OptionExcludeFH.SetValue(1)
    ElseIf DLCOptionsBP == 3                                                    ; DLCOptions: Enable Far Harbor Randoms
        HH_OptionExcludeFH.SetValue(0)
    ElseIf DLCOptionsBP == 4                                                    ; DLCOptions: Disable Nuka-World Randoms
        HH_OptionExcludeNW.SetValue(1)
    ElseIf DLCOptionsBP == 5                                                    ; DLCOptions: Enable Nuka-World Randoms
        HH_OptionExcludeNW.SetValue(0)
    ElseIf DLCOptionsBP == 6                                                    ; DLCOptions: Disable Vault-Tec Randoms
        HH_OptionExcludeVT.SetValue(1)
    ElseIf DLCOptionsBP == 7                                                    ; DLCOptions: Enable Vault-Tec Randoms
        HH_OptionExcludeVT.SetValue(0)
    ElseIf DLCOptionsBP == 8                                                    ; DLCOptions: Back
        HH_ShowMainMenu()
    EndIf

    If DLCOptionsBP >= 0 && DLCOptionsBP < 8                                    ; If player selected enable/disable button,
        HH_ShowDLCOptions()                                                     ; refresh the DLCOptions menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW CAMERA OPTIONS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowCameraOptions()
    Int CameraOptionsBP = HH_MenuMessageCameraOptions.Show()                    ; CameraOptions shows and waits for player response

    If CameraOptionsBP == 0                                                     ; CameraOptions: Disable Spin Camera
        HH_OptionSpinCamera.SetValue(0)
    ElseIf CameraOptionsBP == 1                                                 ; CameraOptions: Enable Spin Camera
        HH_OptionSpinCamera.SetValue(1)
    ElseIf CameraOptionsBP == 2                                                 ; CameraOptions: Disable Spin Ghost
        HH_OptionSpinGhost.SetValue(0)
    ElseIf CameraOptionsBP == 3                                                 ; CameraOptions: Enable Spin Ghost
        HH_OptionSpinGhost.SetValue(1)
    ElseIf CameraOptionsBP == 4                                                 ; CameraOptions: Set Camera Max Distance
        HH_ShowSetMax()
    ElseIf CameraOptionsBP == 5                                                 ; CameraOptions: Set Camera Min Distance
        HH_ShowSetMin()
    ElseIf CameraOptionsBP == 6                                                 ; CameraOptions: Set Spin Duration
        HH_ShowSetDuration()
    ElseIf CameraOptionsBP == 7                                                 ; CameraOptions: Back
        HH_ShowMainMenu()
    EndIf

    If CameraOptionsBP >= 0 && CameraOptionsBP < 4                              ; If player selected enable/disable button,
        HH_ShowCameraOptions()                                                  ; refresh the CameraOptions menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET MAX
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetMax()
    Float MaxNum

    CurrentStatus = HH_OptionCamMaxDistance.GetValue()
    Int SetMaxBP = HH_MenuMessageSetMax.Show(CurrentStatus)                     ; SetMax shows and waits for player response

    If SetMaxBP == 0                                                            ; SetMax: 150 (vanilla default)
        MaxNum = 150
    ElseIf SetMaxBP == 1                                                        ; SetMax: 200 (mod default)
        MaxNum = 200
    ElseIf SetMaxBP == 2                                                        ; SetMax: 250
        MaxNum = 250
    ElseIf SetMaxBP == 3                                                        ; SetMax: 500
        MaxNum = 500
    ElseIf SetMaxBP == 4                                                        ; SetMax: 750
        MaxNum = 750
    ElseIf SetMaxBP == 5                                                        ; SetMax: 1000
        MaxNum = 1000
    ElseIf SetMaxBP == 6                                                        ; SetMax: Back
        HH_ShowCameraOptions()
    EndIf

    If SetMaxBP < 6                                                             ; If player selected a value,
        HH_OptionCamMaxDistance.SetValue(MaxNum)                                ; set camera max distance
        HH_ShowSetMax()                                                         ; and refresh the SetMax menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET MIN
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetMin()
    Float MinNum

    CurrentStatus = HH_OptionCamMinDistance.GetValue()
    Int SetMinBP = HH_MenuMessageSetMin.Show(CurrentStatus)                     ; SetMin shows and waits for player response

    If SetMinBP == 0                                                            ; SetMin: 0 (vanilla default)
        MinNum = 0
    ElseIf SetMinBP == 1                                                        ; SetMin: 100 (mod default)
        MinNum = 100
    ElseIf SetMinBP == 2                                                        ; SetMin: 150
        MinNum = 150
    ElseIf SetMinBP == 3                                                        ; SetMin: 200
        MinNum = 200
    ElseIf SetMinBP == 4                                                        ; SetMin: 250
        MinNum = 250
    ElseIf SetMinBP == 5                                                        ; SetMin: 500
        MinNum = 500
    ElseIf SetMinBP == 6                                                        ; SetMin: Back
        HH_ShowCameraOptions()
    EndIf

    If SetMinBP < 6                                                             ; If player selected a value,
        HH_OptionCamMinDistance.SetValue(MinNum)                                ; set camera min distance
        HH_ShowSetMin()                                                         ; and refresh the SetMin menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET DURATION
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetDuration()
    Float MinNum

    CurrentStatus = HH_OptionSpinDuration.GetValue()
    Int SetMinBP = HH_MenuMessageSetDuration.Show(CurrentStatus)                ; SetDuration shows and waits for player response

    If SetMinBP == 0                                                            ; SetDuration: 10
        MinNum = 10
    ElseIf SetMinBP == 1                                                        ; SetDuration: 15
        MinNum = 15
    ElseIf SetMinBP == 2                                                        ; SetDuration: 20 (mod default)
        MinNum = 20
    ElseIf SetMinBP == 3                                                        ; SetDuration: 25
        MinNum = 25
    ElseIf SetMinBP == 4                                                        ; SetDuration: 30
        MinNum = 30
    ElseIf SetMinBP == 5                                                        ; SetDuration: 60
        MinNum = 60
    ElseIf SetMinBP == 6                                                        ; SetDuration: Back
        HH_ShowCameraOptions()
    EndIf

    If SetMinBP < 6                                                             ; If player selected a value,
        HH_OptionSpinDuration.SetValue(MinNum)                                  ; set camera spin duration
        HH_ShowSetDuration()                                                    ; and refresh the SetDuration menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW TELEPORT OPTIONS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowTeleportOptions()
    Int TeleportOptionsBP = HH_MenuMessageTeleportOptions.Show()                ; TeleportOptions shows and waits for player response

    If TeleportOptionsBP == 0                                                   ; TeleportOptions: DLC Destination Options
        HH_ShowDLCOptions()
    ElseIf TeleportOptionsBP == 1                                               ; TeleportOptions: Disable Auto Time Change
        HH_OptionSetTime.SetValue(0)
    ElseIf TeleportOptionsBP == 2                                               ; TeleportOptions: Enable Auto Time Change
        HH_OptionSetTime.SetValue(1)
    ElseIf TeleportOptionsBP == 3                                               ; TeleportOptions: Set Preferred Time
        HH_ShowSetTime()
    ElseIf TeleportOptionsBP == 4                                               ; TeleportOptions: Disable Auto Weather Change
        HH_OptionSetWeather.SetValue(0)
    ElseIf TeleportOptionsBP == 5                                               ; TeleportOptions: Enable Auto Weather Change
        HH_OptionSetWeather.SetValue(1)
    ElseIf TeleportOptionsBP == 6                                               ; TeleportOptions: Set Preferred Weather
        HH_ShowSetWeather()
    ElseIf TeleportOptionsBP == 7                                               ; TeleportOptions: Disable Heal On Teleport
        HH_OptionHeal.SetValue(0)
    ElseIf TeleportOptionsBP == 8                                               ; TeleportOptions: Enable Heal On Teleport
        HH_OptionHeal.SetValue(1)
    ElseIf TeleportOptionsBP == 9                                               ; TeleportOptions: Disable Loading Screens
        HH_OptionFastTravel.SetValue(0)
    ElseIf TeleportOptionsBP == 10                                              ; TeleportOptions: Enable Loading Screens
        HH_OptionFastTravel.SetValue(1)
    ElseIf TeleportOptionsBP == 11                                              ; TeleportOptions: Disable Spin Camera
        HH_OptionSpinCamera.SetValue(0)
    ElseIf TeleportOptionsBP == 12                                              ; TeleportOptions: Enable Spin Camera
        HH_OptionSpinCamera.SetValue(1)
    ElseIf TeleportOptionsBP == 13                                              ; TeleportOptions: Disable Teleport Sounds
        HH_OptionTeleportSound.SetValue(0)
    ElseIf TeleportOptionsBP == 14                                              ; TeleportOptions: Enable Teleport Sounds
        HH_OptionTeleportSound.SetValue(1)
    ElseIf TeleportOptionsBP == 15                                              ; TeleportOptions: Disable Vault Boys
        HH_OptionVaultBoy.SetValue(0)
    ElseIf TeleportOptionsBP == 16                                              ; TeleportOptions: Enable Vault Boys
        HH_OptionVaultBoy.SetValue(1)
    ElseIf TeleportOptionsBP == 17                                              ; TeleportOptions: Advanced Options
        HH_ShowAdvancedOptions()
    ElseIf TeleportOptionsBP == 18                                              ; TeleportOptions: Back
        HH_ShowMainMenu()
    EndIf

    If TeleportOptionsBP >= 1 && TeleportOptionsBP < 17                         ; If player selected enable/disable button,
        If TeleportOptionsBP == 3 || TeleportOptionsBP == 6
            ; do not refresh submenu choices
        Else
            HH_ShowTeleportOptions()                                            ; refresh the TeleportOptions menu on screen
        EndIf
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET TIME
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetTime()
    Float PrefTime

    CurrentStatus = HH_OptionSetTimePreference.GetValue()
    Int SetTimeBP = HH_MenuMessageSetTime.Show(CurrentStatus)                   ; SetTime shows and waits for player response

    If SetTimeBP == 0                                                           ; SetTime: 3 AM
        PrefTime = 3
    ElseIf SetTimeBP == 1                                                       ; SetTime: 6 AM
        PrefTime = 6
    ElseIf SetTimeBP == 2                                                       ; SetTime: 9 AM
        PrefTime = 9
    ElseIf SetTimeBP == 3                                                       ; SetTime: Noon
        PrefTime = 12
    ElseIf SetTimeBP == 4                                                       ; SetTime: 3 PM
        PrefTime = 15
    ElseIf SetTimeBP == 5                                                       ; SetTime: 6 PM
        PrefTime = 18
    ElseIf SetTimeBP == 6                                                       ; SetTime: 9 PM
        PrefTime = 21
    ElseIf SetTimeBP == 7                                                       ; SetTime: Midnight
        PrefTime = 24
    ElseIf SetTimeBP == 8                                                       ; SetTime: Back
        HH_ShowTeleportOptions()
    EndIf

    If SetTimeBP < 8                                                            ; If player selected a value,
        HH_OptionSetTimePreference.SetValue(PrefTime)                           ; set preferred time
        HH_ShowSetTime()                                                        ; and refresh the SetTime menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET WEATHER
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetWeather()
    Float PrefWeather

    CurrentStatus = HH_OptionSetWeatherPreference.GetValue()
    Int SetWeatherBP = HH_MenuMessageSetWeather.Show(CurrentStatus)             ; SetWeather shows and waits for player response

    If SetWeatherBP == 0                                                        ; SetWeather: CommonwealthClear
        PrefWeather = 1
    ElseIf SetWeatherBP == 1                                                    ; SetWeather: CommonwealthDusty
        PrefWeather = 2
    ElseIf SetWeatherBP == 2                                                    ; SetWeather: CommonwealthFoggy
        PrefWeather = 3
    ElseIf SetWeatherBP == 3                                                    ; SetWeather: CommonwealthMisty
        PrefWeather = 4
    ElseIf SetWeatherBP == 4                                                    ; SetWeather: CommonwealthMistyRainy
        PrefWeather = 5
    ElseIf SetWeatherBP == 5                                                    ; SetWeather: CommonwealthOvercast
        PrefWeather = 6
    ElseIf SetWeatherBP == 6                                                    ; SetWeather: CommonwealthGSRadstorm
        PrefWeather = 7
    ElseIf SetWeatherBP == 7                                                    ; SetWeather: CommonwealthRain
        PrefWeather = 8
    ElseIf SetWeatherBP == 8                                                    ; SetWeather: Back
        HH_ShowTeleportOptions()
    EndIf

    If SetWeatherBP < 8                                                         ; If player selected a value,
        HH_OptionSetWeatherPreference.SetValue(PrefWeather)                     ; set preferred weather
        HH_ShowSetWeather()                                                     ; and refresh the SetWeather menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW ADVANCED OPTIONS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowAdvancedOptions()
    Int AdvancedOptionsBP = HH_MenuMessageAdvancedOptions.Show()                ; AdvancedOptions shows and waits for player response

    If AdvancedOptionsBP == 0                                                   ; AdvancedOptions: Enable Always CenterOnCell
    ;empty
    ElseIf AdvancedOptionsBP == 1                                               ; AdvancedOptions: Disable Always CenterOnCell
    ;empty
    ElseIf AdvancedOptionsBP == 2                                               ; AdvancedOptions: Enable Developer Messages
        HHQuestScript.HH_EnableDebug()
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 3                                               ; AdvancedOptions: Disable Developer Messages
        HHQuestScript.HH_DisableDebug()
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 4                                               ; AdvancedOptions: Set Rewards
        HH_ShowSetRewards()
    ElseIf AdvancedOptionsBP == 5                                               ; AdvancedOptions: Set X Offset (XYZ removed in v2.0 refactoring)
    ;empty
    ElseIf AdvancedOptionsBP == 6                                               ; AdvancedOptions: Set Y Offset (XYZ removed in v2.0 refactoring)
    ;empty
    ElseIf AdvancedOptionsBP == 7                                               ; AdvancedOptions: Set Z Offset (XYZ removed in v2.0 refactoring)
    ;empty
    ElseIf AdvancedOptionsBP == 8                                               ; AdvancedOptions: Ship Happens
        Int ShipSize = pShipmentItemList.GetSize()
        Int i = 0
        While i < ShipSize
            Player.AddItem(pShipmentItemList.GetAt(i), 5)
            i += 1
        EndWhile
        
    ; FURNITURE TOGGLE WOULD NOT FIT IN TELEPORT OPTIONS MENU BECAUSE CONDITIONALS IN THAT MENU MAXED OUT NUMBER OF AVAILABLE OPTIONS
    
    ElseIf AdvancedOptionsBP == 9                                                ; AdvancedOptions: Sit At Nearby Furniture When Arriving
        HH_OptionSitFurniture.SetValue(1)
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 10                                               ; AdvancedOptions: Don't Sit At Nearby Furniture When Arriving
        HH_OptionSitFurniture.SetValue(0)
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 11                                               ; AdvancedOptions: Back
        HH_ShowTeleportOptions()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET REWARDS
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetRewards()
    Float MinNum

    CurrentStatus = HH_OptionSetRewards.GetValue()
    Int SetX = HH_MenuMessageSetRewards.Show(CurrentStatus)                     ; SetRewards shows and waits for player response

    If SetX == 0                                                                ; SetRewards: 0 (Now, Spoilers On Next Hitch)
        MinNum = 0
    ElseIf SetX == 1                                                            ; SetRewards: 1
        MinNum = 1
    ElseIf SetX == 2                                                            ; SetRewards: 2
        MinNum = 2
    ElseIf SetX == 3                                                            ; SetRewards: 3
        MinNum = 3
    ElseIf SetX == 4                                                            ; SetRewards: 4
        MinNum = 4
    ElseIf SetX == 5                                                            ; SetRewards: 5 (Default)
        MinNum = 5
    ElseIf SetX == 6                                                            ; SetRewards: 10
        MinNum = 10
    ElseIf SetX == 7                                                            ; SetRewards: Back
        HH_ShowAdvancedOptions()
    EndIf

    If SetX < 7                                                                 ; If player selected a value,
        HH_OptionSetRewards.SetValue(MinNum)                                    ; set rewards
        HH_ShowSetRewards()                                                     ; and refresh the rewards menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET MENU DEFAULTS
; ------------------------------------------------------------------------------------------------------------

Function HH_SetMenuDefaults()
    HHQuestScript.HH_DisableDebug()
    HH_OptionCamMaxDistance.SetValue(200)
    HH_OptionCamMinDistance.SetValue(100)
    HHQuestScript.HH_DisableDebug()
    HH_OptionExcludeFH.SetValue(1)
    HH_OptionExcludeNW.SetValue(1)
    HH_OptionExcludeVT.SetValue(1)
    HH_OptionFastTravel.SetValue(1)
    HH_OptionSetTime.SetValue(0)
    HH_OptionSetTimePreference.SetValue(9)
    HH_OptionSetWeather.SetValue(0)
    HH_OptionSetWeatherPreference.SetValue(1)
    HH_OptionSitFurniture.SetValue(1)
    HH_OptionSpinCamera.SetValue(1)
    HH_OptionSpinDuration.SetValue(20)
    HH_OptionSpinGhost.SetValue(1)
    HH_OptionHeal.SetValue(0)
    HH_OptionTeleportSound.SetValue(1)
EndFunction

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON MENU OPEN CLOSE EVENT
; ------------------------------------------------------------------------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
    UnregisterForMenuOpenCloseEvent("PipboyMenu")                               ; Cancel player button spams

    If (asMenuName== "PipboyMenu")                                              ; When the Pip-Boy
        If (!abOpening)                                                         ; closes,
            Int PrefTime = HH_OptionSetTimePreference.GetValue() as Int         ; get player's preferred time
            HHQuestScript.HH_ForceTime(PrefTime)                                ; Send time to ForceTime function
        EndIf
    EndIf
EndEvent
