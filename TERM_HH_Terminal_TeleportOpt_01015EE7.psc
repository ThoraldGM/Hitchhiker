;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_HH_Terminal_TeleportOpt_01015EE7 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSetTime.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSetTime.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSetWeather.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSetWeather.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionHeal.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionHeal.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionFastTravel.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_11
Function Fragment_Terminal_11(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionFastTravel.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_12
Function Fragment_Terminal_12(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinCamera.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_13
Function Fragment_Terminal_13(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinCamera.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_14
Function Fragment_Terminal_14(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionTeleportSound.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_15
Function Fragment_Terminal_15(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionTeleportSound.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_16
Function Fragment_Terminal_16(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionVaultBoy.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_17
Function Fragment_Terminal_17(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionVaultBoy.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_18
Function Fragment_Terminal_18(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSitFurniture.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_19
Function Fragment_Terminal_19(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSitFurniture.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_26
Function Fragment_Terminal_26(ObjectReference akTerminalRef)
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
Int ShipSize = pShipmentItemList.GetSize()
Int i = 0
While i < ShipSize
    PlayerREF.AddItem(pShipmentItemList.GetAt(i), 5)
    i += 1
EndWhile
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property HH_OptionSetTime Auto Const Mandatory

GlobalVariable Property HH_OptionSetWeather Auto Const Mandatory

GlobalVariable Property HH_OptionHeal Auto Const Mandatory

GlobalVariable Property HH_OptionSpinCamera Auto Const Mandatory

GlobalVariable Property HH_OptionTeleportSound Auto Const Mandatory

GlobalVariable Property HH_OptionVaultBoy Auto Const Mandatory

FormList Property pShipmentItemList Auto Const Mandatory

GlobalVariable Property HH_OptionFastTravel Auto Const Mandatory

GlobalVariable Property HH_OptionSitFurniture Auto Const Mandatory
