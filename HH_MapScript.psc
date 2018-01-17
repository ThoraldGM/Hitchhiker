Scriptname HH_MapScript extends ObjectReference
{ It just works. }

;/

Fallout 4 Papyrus script by ThoraldGM | http://thoraldgm.com | Updated 20180110
Hitchhiker mod: (url pending)

SCRIPT SECTIONS:

LINE 0054: PROPERTIES
LINE ####: ON READ
LINE ####: HH SHOW MAIN MENU
LINE ####: HH SHOW THE ANY MENU
LINE ####: HH SHOW THE SPECIFIC MENU
LINE ####: HH SHOW MENU BUS SHELTERS
LINE ####: HH SHOW MENU DINERS 1
LINE ####: HH SHOW MENU DINERS 2
LINE ####: HH SHOW MENU DINERS 3
LINE ####: HH SHOW MENU DIVES
LINE ####: HH SHOW MENU DRIVE INS
LINE ####: HH SHOW MENU FACTORIES
LINE ####: HH SHOW MENU FARMS
LINE ####: HH SHOW MENU JUNKYARDS 1
LINE ####: HH SHOW MENU JUNKYARDS 2
LINE ####: HH SHOW MENU MILITARY BASES 1
LINE ####: HH SHOW MENU MILITARY BASES 2
LINE ####: HH SHOW MENU MONUMENTS 1
LINE ####: HH SHOW MENU MONUMENTS 2
LINE ####: HH SHOW MENU MONUMENTS 3
LINE ####: HH SHOW MENU POWER LIFTS 1
LINE ####: HH SHOW MENU POWER LIFTS 2
LINE ####: HH SHOW MENU RED ROCKET 1
LINE ####: HH SHOW MENU RED ROCKET 2
LINE ####: HH SHOW MENU VAULTS
LINE ####: HH SHOW DLC OPTIONS
LINE ####: HH SHOW CAMERA OPTIONS
LINE ####: HH SHOW SET MAX
LINE ####: HH SHOW SET MIN
LINE ####: HH SHOW SET DURATION
LINE ####: HH SHOW TELEPORT OPTIONS
LINE ####: HH SHOW SET TIME
LINE ####: HH SHOW SET WEATHER
LINE ####: HH SHOW ADVANCED OPTIONS
LINE ####: HH SHOW SET X
LINE ####: HH SHOW SET Y
LINE ####: HH SHOW SET Z
LINE ####: HH SET MENU DEFAULTS
LINE ####: ON MENU OPEN CLOSE EVENT

/;
 
; ------------------------------------------------------------------------------------------------------------
; PROPERTIES
; ------------------------------------------------------------------------------------------------------------

; ************************************************************************************************************
; Player menu options (23 here. Plus Force Time Now, Force Weather Now, Spin Idle Camera Now, & Restore Defaults):
; ************************************************************************************************************
GlobalVariable Property HH_OptionAlwaysCOC Auto Mandatory
{ Does player prefer CenterOnCell instead of MoveTo? }
GlobalVariable Property HH_OptionCamMaxDistance Auto Mandatory
{ Max camera distance (default: 200, vanilla: 150) }
GlobalVariable Property HH_OptionCamMinDistance Auto Mandatory
{ Min camera distance (default: 100, vanilla: 0) }
GlobalVariable Property HH_OptionDevTracking Auto Mandatory
{ Does player want dev messages? (default: no) }
GlobalVariable Property HH_OptionExcludeDLC Auto Mandatory
{ Turn all DLC on/off in random destinations (default: off) }
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
GlobalVariable Property HH_OptionOffsetX Auto Mandatory
{ Player can choose X offset (default: 250) }
GlobalVariable Property HH_OptionOffsetY Auto Mandatory
{ Player can choose Y offset (default: 250) }
GlobalVariable Property HH_OptionOffsetZ Auto Mandatory
{ Player can choose Z offset (default: 500) }
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
Message Property HH_MenuMessageSetX Auto Const Mandatory
{ SetX menu }
Message Property HH_MenuMessageSetY Auto Const Mandatory
{ SetY menu }
Message Property HH_MenuMessageSetZ Auto Const Mandatory
{ SetZ menu }

; ************************************************************************************************************
; Everything else:
; ************************************************************************************************************
FormList Property pShipmentItemList Auto Const Mandatory
{ Vanilla CK list of all component shipments }
GlobalVariable Property HH_IsSpinning Auto Mandatory
{ Is the camera currently spinning? }
GlobalVariable Property HH_PlayerHasFH Auto Mandatory
{ Does player have Far Harbor DLC? }
GlobalVariable Property HH_PlayerHasNW Auto Mandatory
{ Does player have Nuka-World DLC? }
GlobalVariable Property HH_PlayerHasPC Auto Mandatory
{ Is player gaming on a PC? (Prereq for COC option) }
GlobalVariable Property HH_PlayerHasVT Auto Mandatory
{ Does player have Vault-Tec DLC? }
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

Int BUS_SHELTERS = 1                                                            ; Category ints (makes code easier to read)
Int DINERS = 2
Int DIVES = 3
Int DRIVE_INS = 4
Int FACTORIES = 5
Int FARMS = 6
Int JUNKYARDS = 7
Int MILITARY_BASES = 8
Int MONUMENTS = 9
Int POWER_LIFTS = 10
Int RED_ROCKETS = 11
Int VAULTS = 12

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON READ
; ------------------------------------------------------------------------------------------------------------

Event OnRead()
    Player = Game.GetPlayer()                                                   ; Player actor
    Bool FarHarborInstalled = Game.IsPluginInstalled("DLCCoast.esm")            ; Does player have Far Harbor DLC?
    Bool NukaWorldInstalled = Game.IsPluginInstalled("DLCNukaWorld.esm")        ; Does player have Nuka-World DLC?
    Bool VaultTecInstalled = Game.IsPluginInstalled("DLCworkshop03.esm")        ; Does player have Vault-Tec DLC?
    
    Utility.WaitMenuMode(0.1)                                                   ; Wait a moment before using DLC checks
    
    If FarHarborInstalled                                                       ; If Far Harbor DLC installed,
        HH_PlayerHasFH.SetValue(1)                                              ; unlock FH destinations
    EndIf
    
    If NukaWorldInstalled                                                       ; If Nuka-World DLC installed,                          
        HH_PlayerHasNW.SetValue(1)                                              ; unlock NW destinations
    EndIf
    
    If VaultTecInstalled                                                        ; If Vault-Tec DLC installed,
        HH_PlayerHasVT.SetValue(1)                                              ; unlock VT destination
    EndIf
    
    Utility.WaitMenuMode(0.1)                                                   ; Wait a moment before using actor
    
    If GetContainer() != Player                                                 ; If hitchhiker map is not in inventory (on ground, etc)
        HH_ShowMenu.SetValue(0)                                                 ; do not show the menu
    EndIf
    
    If HH_ShowMenu.GetValue() as Int == 1                                       ; Default value is zero so "awesome" message plays on add
        Utility.WaitMenuMode(2)                                                 ; Give magazine a chance to fill menu background
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
    
        ; IMPORTANT: Game.PassTime has erratic results when menus are open, so wait until Pip-Boy is closed
        
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
    
    If HH_OptionDevTracking.GetValue() as Int == 1
        Debug.TraceAndBox("Hitchhiker: Selected category is " + Selected + ".")
    EndIf
    
    If Selected > 0 && Selected <= 12
        HHQuestScript.HH_SetRandomDestination(Selected)
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
    
    If Selected >= 0 && Selected <= 9
        HH_Category.SetValue(MONUMENTS)
        HH_TargetID.SetValue((Selected + 20))
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
        HH_TargetID.SetValue(18)
    ElseIf Selected == 8
        HH_TargetID.SetValue(8)
    ElseIf Selected == 9
        HH_TargetID.SetValue(14)
    ElseIf Selected == 10
        HH_TargetID.SetValue(1)
    ElseIf Selected == 11
        HH_TargetID.SetValue(3)
    ElseIf Selected == 12
        HH_ShowMenuRedRocket2()
    Else
        HH_ShowTheSpecificMenu()
    EndIf
    
    If Selected >= 0 && Selected <= 11
        HH_Category.SetValue(RED_ROCKETS)
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
        HH_OptionExcludeDLC.SetValue(1)
        HH_OptionExcludeFH.SetValue(1)
        HH_OptionExcludeNW.SetValue(1)
        HH_OptionExcludeVT.SetValue(1)
    ElseIf DLCOptionsBP == 1                                                    ; DLCOptions: Enable All DLC Randoms
        HH_OptionExcludeDLC.SetValue(0)
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
    ElseIf TeleportOptionsBP == 15                                              ; TeleportOptions: Advanced Options
        HH_ShowAdvancedOptions()
    ElseIf TeleportOptionsBP == 16                                              ; TeleportOptions: Back
        HH_ShowMainMenu()
    EndIf
    
    If TeleportOptionsBP >= 1 && TeleportOptionsBP < 15                         ; If player selected enable/disable button,
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

    If AdvancedOptionsBP == 0                                                   ; AdvancedOptions: Enable Developer Messages
        HH_OptionDevTracking.SetValue(1)
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 1                                               ; AdvancedOptions: Disable Developer Messages
        HH_OptionDevTracking.SetValue(0)
        HH_ShowAdvancedOptions()
    ElseIf AdvancedOptionsBP == 2                                               ; AdvancedOptions: Set X Offset
        HH_ShowSetX()
    ElseIf AdvancedOptionsBP == 3                                               ; AdvancedOptions: Set Y Offset
        HH_ShowSetY()
    ElseIf AdvancedOptionsBP == 4                                               ; AdvancedOptions: Set Z Offset
        HH_ShowSetZ()
    ElseIf AdvancedOptionsBP == 5                                               ; AdvancedOptions: Ship Happens
        Int ShipSize = pShipmentItemList.GetSize()
        Int i = 0
        While i < ShipSize
            Player.AddItem(pShipmentItemList.GetAt(i))
            i += 1
        EndWhile
    ElseIf AdvancedOptionsBP == 6                                               ; AdvancedOptions: Back
        HH_ShowTeleportOptions()
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET X
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetX()
    Float MinNum
    
    CurrentStatus = HH_OptionOffsetX.GetValue()
    Int SetX = HH_MenuMessageSetX.Show(CurrentStatus)                           ; SetX shows and waits for player response
    
    If SetX == 0                                                                ; SetX: 0
        MinNum = 0
    ElseIf SetX == 1                                                            ; SetX: 100
        MinNum = 100
    ElseIf SetX == 2                                                            ; SetX: 250 (mod default)
        MinNum = 250
    ElseIf SetX == 3                                                            ; SetX: 500
        MinNum = 500
    ElseIf SetX == 4                                                            ; SetX: 750
        MinNum = 750
    ElseIf SetX == 5                                                            ; SetX: 1000
        MinNum = 1000
    ElseIf SetX == 6                                                            ; SetX: Back
        HH_ShowAdvancedOptions()
    EndIf
    
    If SetX < 6                                                                 ; If player selected a value,
        HH_OptionOffsetX.SetValue(MinNum)                                       ; set X offset
        HH_ShowSetX()                                                           ; and refresh the SetX menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET Y
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetY()
    Float MinNum
    
    CurrentStatus = HH_OptionOffsetY.GetValue()
    Int SetY = HH_MenuMessageSetY.Show(CurrentStatus)                           ; SetY shows and waits for player response
    
    If SetY == 0                                                                ; SetY: 0
        MinNum = 0
    ElseIf SetY == 1                                                            ; SetY: 100
        MinNum = 100
    ElseIf SetY == 2                                                            ; SetY: 250 (mod default)
        MinNum = 250
    ElseIf SetY == 3                                                            ; SetY: 500
        MinNum = 500
    ElseIf SetY == 4                                                            ; SetY: 750
        MinNum = 750
    ElseIf SetY == 5                                                            ; SetY: 1000
        MinNum = 1000
    ElseIf SetY == 6                                                            ; SetY: Back
        HH_ShowAdvancedOptions()
    EndIf
    
    If SetY < 6                                                                 ; If player selected a value,
        HH_OptionOffsetY.SetValue(MinNum)                                       ; set Y offset
        HH_ShowSetY()                                                           ; and refresh the SetY menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SHOW SET Z
; ------------------------------------------------------------------------------------------------------------

Function HH_ShowSetZ()
    Float MinNum
    
    CurrentStatus = HH_OptionOffsetZ.GetValue()
    Int SetZ = HH_MenuMessageSetZ.Show(CurrentStatus)                           ; SetZ shows and waits for player response
    
    If SetZ == 0                                                                ; SetZ: 0
        MinNum = 0
    ElseIf SetZ == 1                                                            ; SetZ: 100
        MinNum = 100
    ElseIf SetZ == 2                                                            ; SetZ: 250
        MinNum = 250
    ElseIf SetZ == 3                                                            ; SetZ: 500 (mod default)
        MinNum = 500
    ElseIf SetZ == 4                                                            ; SetZ: 750
        MinNum = 750
    ElseIf SetZ == 5                                                            ; SetZ: 1000
        MinNum = 1000
    ElseIf SetZ == 6                                                            ; SetZ: Back
        HH_ShowAdvancedOptions()
    EndIf
    
    If SetZ < 6                                                                 ; If player selected a value,
        HH_OptionOffsetZ.SetValue(MinNum)                                       ; set Z offset
        HH_ShowSetZ()                                                           ; and refresh the SetZ menu on screen
    EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET MENU DEFAULTS
; ------------------------------------------------------------------------------------------------------------

Function HH_SetMenuDefaults()
    HH_OptionCamMaxDistance.SetValue(200)
    HH_OptionCamMinDistance.SetValue(100)
    HH_OptionDevTracking.SetValue(0)
    HH_OptionExcludeDLC.SetValue(1)
    HH_OptionExcludeFH.SetValue(1)
    HH_OptionExcludeNW.SetValue(1)
    HH_OptionExcludeVT.SetValue(1)
    HH_OptionFastTravel.SetValue(1)
    HH_OptionOffsetX.SetValue(250)
    HH_OptionOffsetY.SetValue(250)
    HH_OptionOffsetZ.SetValue(500)
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
            Utility.Wait(5)
            HHQuestScript.HH_ForceTime(PrefTime)                                ; Send time to ForceTime function
        EndIf
    EndIf
EndEvent