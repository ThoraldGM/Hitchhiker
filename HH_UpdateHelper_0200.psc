Scriptname HH_UpdateHelper_0200 extends Quest
{ It just works. }

;/

Fallout 4 Papyrus script by BigAndFlabby 20180129 | Updated by ThoraldGM 20180130
Hitchhiker mod: https://www.nexusmods.com/fallout4/mods/29273
Modforge: https://modforge.net

"TGM: " = comments added by ThoraldGM

/;

HH_QuestScript Property HHQuestScript Auto Const

Event OnQuestInit()
    StartTimerGameTime(0.1, 0)
EndEvent

Event OnTimerGameTime(int auiTimerID)
    If HHQuestScript.IsRunning()                                                ; TGM: IsRunning doesn't require Quest property type?
        HHQuestScript.HH_InitMod()
        Stop()                                                                  ; TGM: Stops HH_Update_Helper_0200 quest!
    else    ; if quest isn't running then we don't need to fix anything
        Stop()                                                                  ; TGM: Stops HH_Update_Helper_0200 quest!
    EndIf
EndEvent
