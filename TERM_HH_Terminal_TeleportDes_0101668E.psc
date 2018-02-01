;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_HH_Terminal_TeleportDes_0101668E Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(6)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(7)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(8)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
HH_StartHitching(9)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function HH_StartHitching(int iDestination)
    HH_Category.Value = iCategory
    HH_TargetID.Value = iDestination
    HH_CountVar.Mod(1)
    HH_CountSpecific.Mod(1)
    HHQuestScript.HH_StartHitching()
    HH_DestMessage_ClosePipBoy.Show()
EndFunction

Group CustomSet
    Int Property iCategory Auto Const Mandatory
    { Category ID matching constant from HH_QuestScript }
    GlobalVariable Property HH_CountVar Auto Const Mandatory
    { Global Variable matching category counter HH_CountXXX template }
EndGroup

Group HH_Globals
    HH_QuestScript Property HHQuestScript Auto Const Mandatory
    GlobalVariable Property HH_Category Auto Const Mandatory
    GlobalVariable Property HH_TargetID Auto Const Mandatory
    GlobalVariable Property HH_CountSpecific Auto Const Mandatory
    Message Property HH_DestMessage_ClosePipBoy Auto Const Mandatory
EndGroup
