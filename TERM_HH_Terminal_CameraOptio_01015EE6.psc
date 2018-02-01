;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_HH_Terminal_CameraOptio_01015EE6 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
PlayerREF.MoveTo(PlayerREF)
HHQuestScript.HH_SpinCamera()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
PlayerREF.MoveTo(PlayerREF)
HHQuestScript.HH_StopSpinning()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinCamera.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinCamera.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinGhost.Value = 0
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
HH_OptionSpinGhost.Value = 1
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

HH_QuestScript Property HHQuestScript Auto Const

GlobalVariable Property HH_OptionSpinGhost Auto Const Mandatory

GlobalVariable Property HH_OptionSpinCamera Auto Const Mandatory
