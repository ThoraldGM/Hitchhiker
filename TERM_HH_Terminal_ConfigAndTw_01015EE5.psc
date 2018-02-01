;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_HH_Terminal_ConfigAndTw_01015EE5 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
; IMPORTANT: Game.PassTime has erratic results when menus are open, so wait until Pip-Boy is closed
Actor PlayerREF = Game.GetPlayer()
PlayerREF.MoveTo(PlayerREF)
HHQuestScript.HH_ForceTime(HH_OptionSetTimePreference.GetValueInt())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
HHQuestScript.HH_ForceWeather(HH_OptionSetWeatherPreference.Value as Int)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
HHQuestScript.HH_DisableDebug()
HH_OptionCamMaxDistance.SetValue(200)
HH_OptionCamMinDistance.SetValue(100)
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
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

HH_QuestScript Property HHQuestScript Auto Const

; ************************************************************************************************************
; Player menu options:
; ************************************************************************************************************
GlobalVariable Property HH_OptionCamMaxDistance Auto Const Mandatory
{ Max camera distance (default: 200, vanilla: 150) }
GlobalVariable Property HH_OptionCamMinDistance Auto Const Mandatory
{ Min camera distance (default: 100, vanilla: 0) }
GlobalVariable Property HH_OptionExcludeFH Auto Const Mandatory
{ Turn Far Harbor DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeNW Auto Const Mandatory
{ Turn Nuka-World DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionExcludeVT Auto Const Mandatory
{ Turn Vault-Tec DLC on/off in destinations (default: off) }
GlobalVariable Property HH_OptionFastTravel Auto Const Mandatory
{ Does player want loading screens? (default: yes) }
GlobalVariable Property HH_OptionHeal Auto Const Mandatory
{ Does player want to heal after teleport? (default: no) }
GlobalVariable Property HH_OptionSetRewards Auto Const Mandatory
{ How many hitches per category trigger rewards? (default: 5) }
GlobalVariable Property HH_OptionSetTime Auto Const Mandatory
{ Change time after teleport? (default: no) }
GlobalVariable Property HH_OptionSetTimePreference Auto Const Mandatory
{ Preferred game hour (player sets in menu) }
GlobalVariable Property HH_OptionSetWeather Auto Const Mandatory
{ Change weather after teleport? (default: no) }
GlobalVariable Property HH_OptionSetWeatherPreference Auto Const Mandatory
{ Preferred game weather (player sets in menu) }
GlobalVariable Property HH_OptionSitFurniture Auto Const Mandatory
{ If destination is furniture, choose whether to use it (default: yes) }
GlobalVariable Property HH_OptionSpinCamera Auto Const Mandatory
{ Does player want teleport to spin camera? (default: yes) }
GlobalVariable Property HH_OptionSpinDuration Auto Const Mandatory
{ How long should camera spin? (default: 20 seconds) }
GlobalVariable Property HH_OptionSpinGhost Auto Const Mandatory
{ Does player want invulnerable spin? (default: yes) }
GlobalVariable Property HH_OptionTeleportSound Auto Const Mandatory
{ Does player want teleport sound? (default: yes) }
GlobalVariable Property HH_OptionVaultBoy Auto Const Mandatory
{ Does player want Vault Boy animations? (default: yes) }
