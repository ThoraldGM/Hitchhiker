Scriptname HH_LaunchScript extends Quest Conditional
{ It just works. }

;/

Fallout 4 Papyrus script by BigAndFlabby 20180129 | Updated by ThoraldGM 20180130
Hitchhiker mod: https://www.nexusmods.com/fallout4/mods/29273
Modforge: https://modforge.net

"TGM: " = comments added by ThoraldGM

/;

Actor PlayerREF

Armor Property PipBoy Auto Const Mandatory
{ PipBoy armor record to check for before giving map }
FormList Property HH_IgnoreLocations Auto Const Mandatory
{ List of locations to ignore during beginning of game }                        ; TGM: Pre-war Sanctuary Hills, Vault 111
GlobalVariable Property HH_ShowMenu Auto Const Mandatory
{ Don't show menu when map placed in inventory }
Book Property HH_Map Auto Const Mandatory
{ Hitchhiker map }
Book Property HH_Postcard_Welcome Auto Const Mandatory
{ Modforge Postcard }
Holotape Property HH_Holotape Auto Const Mandatory
{ Hitchhiker guide holotape }

Event OnQuestInit()
    PlayerREF = Game.GetPlayer()
    StartTimer(Utility.RandomInt(1,10), 0)                                      ; TGM: Is random just for fun or essential wait function?
EndEvent

Event OnTimer(int aiTimerID)
    RegisterForRemoteEvent(PlayerREF, "OnLocationChange")
    HH_Check_PlayerReady()                                                      ; run ready check
EndEvent

Event Actor.OnLocationChange(Actor akActor, Location akOldLoc, Location akNewLoc)
    If (HH_IgnoreLocations.HasForm(akNewLoc))                                   ; check blacklisted locations. assume not ready
        return                                                                  ; if player is in one of them
    EndIf

    HH_Check_PlayerReady()
EndEvent

Function HH_Check_PlayerReady()
    If (PlayerREF.GetItemCount(PipBoy))
        HH_GiveMap()
        Stop()                                                                  ; TGM: Stops HH_MapLaunchHelper quest!
    EndIf
EndFunction

Function HH_GiveMap()
    If (PlayerREF.GetItemCount(HH_Map))                                         ; TGM: Added condition to remove old map if present
        PlayerREF.RemoveItem(HH_Map)
        Utility.Wait(0.1)                                                       ; TGM: Give old map a moment to go away before adding new map
    EndIf
    
    HH_ShowMenu.SetValue(0)                                                     ; don't show menu when map placed in inventory
    Utility.Wait(0.1)                                                           ; TGM: Give global a moment to update before spawn checks it
    PlayerREF.AddItem(HH_Map)                                                   ; spawn hitchhiker map in player inventory
    
    If (PlayerREF.GetItemCount(HH_Postcard_Welcome)) == 0                       ; TGM: Added inventory check to avoid postcard duplication
        PlayerREF.AddItem(HH_Postcard_Welcome)                                  ; TGM: If postcard was moved to storage, player gets duplicate
    EndIf
    
    PlayerREF.AddItem(HH_Holotape)                                              ; give player the holotape
EndFunction
