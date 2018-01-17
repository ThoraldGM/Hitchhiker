Scriptname HH_UnlockRecipe extends ObjectReference
{ It just works. }

;/

Fallout 4 Papyrus script by ThoraldGM | http://thoraldgm.com | Updated 20180111
Hitchhiker mod: (url pending)

/;

GlobalVariable Property HH_Rewarded_Recipe Auto Mandatory
{ Cooking station checks whether this value is 0 or 1 }

Event OnRead()
    HH_Rewarded_Recipe.SetValue(1)  ; Player can now craft Dandelion Wine at cooking station
EndEvent
