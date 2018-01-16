Scriptname HH_QuestScript extends Quest
{ It just works. }

; Fallout 4 Papyrus script by ThoraldGM | http://thoraldgm.com | Updated 20171214
; Hitchhiker mod: (url pending)

; SCRIPT SECTIONS:

; LINE : PROPERTIES
; LINE : ON INIT
; LINE : HH START HITCHING
; LINE : ON QUEST INIT
; LINE : (OPTIONAL AUTO TIME CHANGE)
; LINE : (OPTIONAL AUTO WEATHER CHANGE)
; LINE : HH SPIN CAMERA
; LINE : ON TIMER
; LINE : HH STOP SPINNING
; LINE : HH SET DESTINATION
; LINE : HH SET RANDOM DESTINATION
; LINE : HH IS IN FAR HARBOR
; LINE : HH IS IN NUKA WORLD
; LINE : HH QUERY QUEST
; LINE : IS FURNITURE
; LINE : HH TRY TO USE FURNITURE
; LINE : HH FORCE TIME
; LINE : HH FORCE WEATHER

; ------------------------------------------------------------------------------------------------------------
; PROPERTIES
; ------------------------------------------------------------------------------------------------------------

; ************************************************************************************************************
; Player menu options (21 total):
; ************************************************************************************************************
GlobalVariable Property HH_OptionCamMaxDistance Auto Mandatory									; Max camera distance (default: 200, vanilla: 150)
GlobalVariable Property HH_OptionCamMinDistance Auto Mandatory									; Min camera distance (default: 100, vanilla: 0)
GlobalVariable Property HH_OptionDevTracking Auto Mandatory										; Does player want dev messages? (default: no)
GlobalVariable Property HH_OptionExcludeDLC Auto Mandatory										; Turn all DLC on/off in available destinations (default: on if installed)
GlobalVariable Property HH_OptionExcludeFH Auto Mandatory										; Turn Far Harbor DLC on/off in destinations (default: on if installed)
GlobalVariable Property HH_OptionExcludeNW Auto Mandatory										; Turn Nuka-World DLC on/off in destinations (default: on if installed)
GlobalVariable Property HH_OptionExcludeVT Auto Mandatory										; Turn Vault-Tec DLC on/off in destinations (default: on if installed)
GlobalVariable Property HH_OptionFastTravel Auto Mandatory										; Does player want loading screens? (default: yes)
GlobalVariable Property HH_OptionHeal Auto Mandatory											; Does player want to heal after teleport? (default: no)
GlobalVariable Property HH_OptionOffsetX Auto Mandatory											; Player can choose X offset (default: 250)
GlobalVariable Property HH_OptionOffsetY Auto Mandatory											; Player can choose Y offset (default: 250)
GlobalVariable Property HH_OptionOffsetZ Auto Mandatory											; Player can choose Z offset (default: 500)
GlobalVariable Property HH_OptionSetTime Auto Mandatory											; Change time after teleport? (default: no)
GlobalVariable Property HH_OptionSetTimePreference Auto Mandatory								; Preferred game hour (player sets in menu)
GlobalVariable Property HH_OptionSetWeather Auto Mandatory										; Change weather after teleport? (default: no)
GlobalVariable Property HH_OptionSetWeatherPreference Auto Mandatory							; Preferred game weather (player sets in menu)
GlobalVariable Property HH_OptionSitFurniture Auto Mandatory									; If destination is furniture, choose whether to use it (default: yes)
GlobalVariable Property HH_OptionSpinCamera Auto Mandatory										; Does player want teleport to spin camera? (default: yes)
GlobalVariable Property HH_OptionSpinDuration Auto Mandatory									; How long should camera spin? (default: 20 seconds)
GlobalVariable Property HH_OptionSpinGhost Auto Mandatory										; Does player want invulnerable spin? (default: yes)
GlobalVariable Property HH_OptionTeleportSound Auto Mandatory									; Does player want teleport sound? (default: yes)

; ************************************************************************************************************
; Ref quests to avoid persistence / bloat:
; ************************************************************************************************************
Quest Property QuestRefBusShelters Auto Const Mandatory											; Quest stores Bus Shelters ref aliases
Quest Property QuestRefDiners Auto Const Mandatory												; Quest stores Diners ref aliases
Quest Property QuestRefDives Auto Const Mandatory												; Quest stores Dives ref aliases
Quest Property QuestRefDriveIns Auto Const Mandatory											; Quest stores Drive-Ins ref aliases
Quest Property QuestRefFactories Auto Const Mandatory											; Quest stores Factories ref aliases
Quest Property QuestRefFarms Auto Const Mandatory												; Quest stores Farms ref aliases
Quest Property QuestRefJunkyards Auto Const Mandatory											; Quest stores Junkyards ref aliases
Quest Property QuestRefMilitaryBases Auto Const Mandatory										; Quest stores Military Bases ref aliases
Quest Property QuestRefMonuments Auto Const Mandatory											; Quest stores Monuments ref aliases
Quest Property QuestRefPowerLifts Auto Const Mandatory											; Quest stores Power Lifts ref aliases
Quest Property QuestRefRedRocket Auto Const Mandatory											; Quest stores Red Rocket ref aliases
Quest Property QuestRefVaults Auto Const Mandatory												; Quest stores Vaults ref aliases
Quest QuestToGrab

; ************************************************************************************************************
; Weather:
; ************************************************************************************************************
Weather Property DefaultWeather Auto Const Mandatory											; Default weather (outdoors)
Weather Property CommonwealthClear Auto Const Mandatory											; Clear
Weather Property CommonwealthDusty Auto Const Mandatory											; Dusty
Weather Property CommonwealthFoggy Auto Const Mandatory											; Foggy
Weather Property CommonwealthMisty Auto Const Mandatory											; Misty
Weather Property CommonwealthMistyRainy Auto Const Mandatory									; Misty Rainy
Weather Property CommonwealthOvercast Auto Const Mandatory										; Overcast
Weather Property CommonwealthGSRadstorm Auto Const Mandatory									; Radstorm
Weather Property CommonwealthRain Auto Const Mandatory											; Rain

; ************************************************************************************************************
; Everything else:
; ************************************************************************************************************
Actor Player																					; Player actor
Book Property HH_Map Auto Const Mandatory														; Hitchhiker map
FormList Property HH_IsFurniture Auto Const Mandatory											; Formlist of formlists of furnitures
GlobalVariable Property HH_IsSpinning Auto Mandatory											; Is the camera currently spinning?
GlobalVariable Property HH_PlayerHasFH Auto Mandatory											; Does player have Far Harbor DLC?
GlobalVariable Property HH_PlayerHasNW Auto Mandatory											; Does player have Nuka-World DLC?
GlobalVariable Property HH_PlayerHasVT Auto Mandatory											; Does player have Vault-Tec DLC?
GlobalVariable Property HH_RefAliasID Auto Mandatory											; Which specific location did player select?
GlobalVariable Property HH_ShowMenu Auto Mandatory												; Don't show menu when map placed in inventory
GlobalVariable Property pGameHour Auto Mandatory												; Current game hour (from vanilla CK)
Perk Property HH_TeleportNoFallDamage Auto Const Mandatory										; Temp perk so teleport falls don't kill player
Sound Property DRSVertibirdFlightLoadOpen Auto Const Mandatory									; Teleport start sound effect
Sound Property OBJHijackerTeleportOut2DA Auto Const Mandatory									; Teleport end sound effect
STATIC Property pXMarker Auto Const Mandatory													; Xmarker (from vanilla CK)
STATIC Property pXMarkerHeading Auto Const Mandatory											; Xmarker heading (from vanilla CK)
STATIC Property pCOCMarkerHeading Auto Const Mandatory											; COC Xmarker heading (from vanilla CK)

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON INIT
; ------------------------------------------------------------------------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()																	; Player actor
	Utility.Wait(0.1)																			; Wait a moment before using actor
	
	If Player.GetItemCount(HH_Map) == 0															; If player doesn't have hitchhiker map,
		HH_ShowMenu.SetValue(0)																	; don't show menu when map placed in inventory
		Utility.Wait(5)																			; wait 5 seconds
		Player.AddItem(HH_Map)																	; spawn hitchhiker map in player inventory
	EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH START HITCHING
; ------------------------------------------------------------------------------------------------------------

Function HH_StartHitching()
	RegisterForRemoteEvent(QuestToGrab, "OnQuestInit")											; Listen for refs quest start
	Utility.Wait(0.1)																			; Wait a moment for registration to finish
	
	If HH_OptionTeleportSound.GetValue() as Int == 1											; If player wants teleport sound,
		Int iInstanceID = DRSVertibirdFlightLoadOpen.Play(Player)								; play teleport start sound at player
	EndIf

	QuestToGrab.Start()																			; Start the refs quest
EndFunction

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON QUEST INIT
; ------------------------------------------------------------------------------------------------------------

Event Quest.OnQuestInit(Quest akSender)															; When quest starts & aliases are filled
	ObjectReference DestinationMarker
	ObjectReference TargetRef

	If akSender																					; Selected quest's refs are filled
	
		Int RefAliasID = HH_RefAliasID.GetValue() as Int										; Retrieve the ref's AliasID from global
		Utility.Wait(0.1)
		TargetRef = (akSender.GetAlias(RefAliasID) as ReferenceAlias).GetReference()
		
		akSender.Stop()																			; Done with quest until next time
	EndIf
	
	Player.AddPerk(HH_TeleportNoFallDamage)														; IMPORTANT: Temp perk so teleport falls don't kill player!
	
	If HH_OptionSpinGhost.GetValue() as Int == 1												; If player wants no spin damage (default)
		If HH_OptionSpinCamera.GetValue() as Int == 1											; If player wants spincam after teleport,
			Player.SetGhost()																	; IMPORTANT: Player immune to all damage!
		EndIf																					; *** Set ghost now BEFORE the spin! ***
		
		If HH_OptionDevTracking.GetValue() as Int == 1											; If player wants dev messages...
			If Player.IsGhost()																	; If player is a ghost,
				Debug.Notification("Hitchhiker: Player is a ghost!")							; display dev message
			EndIf
		EndIf
	EndIf																						; NOTE: Unghosting happens in HH_SpinCamera()
	
	If HH_OptionTeleportSound.GetValue() as Int == 1											; If player wants teleport sound,
		Int iInstanceID = OBJHijackerTeleportOut2DA.Play(Player)								; play teleport end sound at player
	EndIf
	
	DestinationMarker = Player.PlaceAtMe(pXMarker)												; Dynamically spawn xmarker at player
	
	STATIC TargetBase = TargetRef.GetBaseObject() as STATIC										; Check if target base object is an X/COC marker/header

	If TargetBase == pXMarker || TargetBase == pXMarkerHeading || TargetBase == pCOCMarkerHeading	; Do not use XYZ offsets if destination is a marker
		DestinationMarker.MoveTo(TargetRef)															; so teleport will place player directly on the X
	Else																						; else move marker to static ref with XYZ offsets
		Float OffsetX = HH_OptionOffsetX.GetValue()												; Player sets X (default 250)
		Float OffsetY = HH_OptionOffsetY.GetValue()												; Player sets Y (default 250)
		Float OffsetZ = HH_OptionOffsetZ.GetValue()												; Player sets Z (default 500)
		Utility.Wait(0.1)
		DestinationMarker.MoveTo(TargetRef, OffsetX, OffsetY, OffsetZ)							; Move marker with XYZ offsets
		DestinationMarker.MoveToNearestNavmeshLocation()										; Then move marker to nearest navmesh
	EndIf
	
	If HH_OptionFastTravel.GetValue() as Int == 1												; If player wants loading screens,
		Game.FastTravel(DestinationMarker)														; move player to marker (with load screens?)
	Else
		Player.MoveTo(DestinationMarker)														; else move player (with black screen)
	EndIf
	
	Utility.Wait(0.1)

	; "If TargetRef Is Furniture" caused illegal typecast compiler error, so I wrote a custom function
	HH_TryToUseFurniture(Player, TargetRef)
	
	; ********************************************************************************************************
	; Optional automatic time change on teleport
	; ********************************************************************************************************
	If HH_OptionSetTime.GetValue() as Int == 1													; If player wants automatic time change (default is NO)
		Int PrefTime = HH_OptionSetTimePreference.GetValue() as Int								; get preferred time
		HH_ForceTime(PrefTime)																	; and set it
	EndIf

	; ********************************************************************************************************
	; Optional automatic weather change on teleport
	; ********************************************************************************************************
	If !Player.IsInInterior()																	; If destination is NOT indoors...
		If HH_OptionSetWeather.GetValue() as Int == 1											; If player wants automatic weather change (default is NO)
			Int PrefWeather = HH_OptionSetWeatherPreference.GetValue() as Int					; get preferred weather
			HH_ForceWeather(PrefWeather)														; and set it
		EndIf
	EndIf

	If HH_OptionSpinCamera.GetValue() as Int == 1												; If player wants spincam after teleport,
		HH_SpinCamera()																			; call the custom spin camera function
	EndIf
	
	StartTimer(10, 2)																			; Remove HH_TeleportNoFallDamage perk in 10 seconds
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SPIN CAMERA
; ------------------------------------------------------------------------------------------------------------

Function HH_SpinCamera()
	Int SpinSeconds
	Game.ForceFirstPerson()																		; IMPORTANT: Must start/run spin in first person!
	
	; Thx steve40 for distance & setini code
	Float CamMinDistance = HH_OptionCamMinDistance.GetValue()									; Player chooses min distance (default: 100, vanilla: 0)
	Float CamMaxDistance = HH_OptionCamMaxDistance.GetValue()									; Player chooses max distance (default: 200, vanilla: 150)
	Utility.SetIniFloat("fVanityModeMinDist:Camera", CamMinDistance)							; Set min
	Utility.SetIniFloat("fVanityModeMaxDist:Camera", CamMaxDistance)							; Set max
	
	Utility.Wait(1)																				; Wait a moment
	Utility.SetINIBool("bForceAutoVanityMode:Camera", true)										; Spin the idle camera around player
	
	HH_IsSpinning.SetValue(1)																	; Flag player / camera as spinning
	
	SpinSeconds = HH_OptionSpinDuration.GetValue() as Int										; Player chooses how long to spin (default: 20 seconds)
	StartTimer(SpinSeconds, 1)																	; Wait SpinSeconds then call StopSpinning from OnTimer event
EndFunction

; -----------------------------------------------------------------------------------------------------------
; EVENT: ON TIMER
; -----------------------------------------------------------------------------------------------------------

Event OnTimer(int aiTimerID)																	; Cancel timer
	If aiTimerID == 1
		HH_StopSpinning()																		; Call StopSpinning function
	ElseIf aiTimerID == 2
		Player.RemovePerk(HH_TeleportNoFallDamage)												; Temp perk removed after teleport is safely completed
		
		If HH_OptionHeal.GetValue() as Int == 1													; If player wants healed after teleport,
			Player.ResetHealthAndLimbs()														; reset health and limbs
		EndIf
		
	Else
		; Placeholder for additional timers
	EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH STOP SPINNING
; ------------------------------------------------------------------------------------------------------------

Function HH_StopSpinning()
	CancelTimer(1)																				; Cancel any lingering StopSpinning timers
	
	If Player.IsGhost()																			; If player is a ghost,
		Player.SetGhost(false)																	; IMPORTANT: Undo player's temporary invulnerability
		
		If HH_OptionDevTracking.GetValue() as Int == 1											; If player wants dev messages
			If Player.IsGhost() == false														; If player is no longer a ghost,
				Debug.Notification("Hitchhiker: Player is not a ghost.")						; display dev message
			EndIf
		EndIf
	EndIf
	
	If HH_IsSpinning.GetValue() as Int == 1														; If player is spinning,
		Utility.SetINIBool("bForceAutoVanityMode:Camera", false)								; stop spinning
		
		Game.ForceFirstPerson()																	; IMPORTANT: Call this or spin will last forever!
		
		HH_IsSpinning.SetValue(0)																; Flag player / camera as no longer spinning
		
	EndIf																						; Done with optional spincam effect
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET DESTINATION
; ------------------------------------------------------------------------------------------------------------

Function HH_SetDestination(Quest RefQuest, Int RefAliasID)
	QuestToGrab = RefQuest
	HH_RefAliasID.SetValue(RefAliasID)
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET RANDOM DESTINATION
; ------------------------------------------------------------------------------------------------------------

Function HH_SetRandomDestination(Int Category)
	Quest RefQuest
	Int RefAliasCount
	Int RefAliasID
	Int ReRoll	
	Int ExcludeDLC = HH_OptionExcludeDLC.GetValue() as Int
	Int ExcludeFH = HH_OptionExcludeFH.GetValue() as Int
	Int ExcludeNW = HH_OptionExcludeNW.GetValue() as Int
	Int ExcludeVT = HH_OptionExcludeVT.GetValue() as Int
	
	If HH_PlayerHasFH.GetValue() as Int == 0
		ExcludeFH = 1
	EndIf
	
	If HH_PlayerHasNW.GetValue() as Int == 0
		ExcludeNW = 1
	EndIf
	
	If HH_PlayerHasVT.GetValue() as Int == 0
		ExcludeVT = 1
	EndIf

	If Category == 1
		RefQuest = QuestRefBusShelters
		RefAliasCount = 10
	ElseIf Category == 2
		RefQuest = QuestRefDiners
		RefAliasCount = 30
	ElseIf Category == 3
		RefQuest = QuestRefDriveIns
		RefAliasCount = 12
	ElseIf Category == 4
		RefQuest = QuestRefDives
		RefAliasCount = 13
	ElseIf Category == 5
		RefQuest = QuestRefFactories
		RefAliasCount = 12
	ElseIf Category == 6
		RefQuest = QuestRefFarms
		RefAliasCount = 12
	ElseIf Category == 7
		RefQuest = QuestRefJunkyards
		RefAliasCount = 20
	ElseIf Category == 8
		RefQuest = QuestRefMilitaryBases
		RefAliasCount = 20
	ElseIf Category == 9
		RefQuest = QuestRefMonuments
		RefAliasCount = 30
	ElseIf Category == 10
		RefQuest = QuestRefPowerLifts
		RefAliasCount = 15
	ElseIf Category == 11
		RefQuest = QuestRefRedRocket
		RefAliasCount = 25
	Else
		RefQuest = QuestRefVaults
		RefAliasCount = 10
	EndIf	
	
	; ********************************************************************************************************
	; Do-while functionality. Only loops if rolled destination is unwanted DLC.
	; ********************************************************************************************************
	
	ReRoll = 1
	
	While ReRoll == 1
		ReRoll = 0
		RefAliasID = Utility.RandomInt(0, (RefAliasCount - 1))									; Roll random 0 through (count - 1)
		
		If ExcludeDLC == 1 || ExcludeFH == 1
			If HH_IsInFarHarbor(RefQuest, RefAliasID) == 1
				ReRoll = 1
			EndIf
		EndIf
		
		If !ReRoll
			If ExcludeDLC == 1 || ExcludeNW == 1
				If HH_IsInNukaWorld(RefQuest, RefAliasID) == 1
					ReRoll = 1
				EndIf
			EndIf
		EndIf
		
		If !ReRoll
			If ExcludeDLC == 1 || ExcludeVT == 1
				If RefQuest == QuestRefVaults && RefAliasID == 5
					ReRoll = 1
				EndIf
			EndIf
		EndIf
	EndWhile

	QuestToGrab = RefQuest
	HH_RefAliasID.SetValue(RefAliasID)
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH IS IN FAR HARBOR
; ------------------------------------------------------------------------------------------------------------

Int Function HH_IsInFarHarbor(Quest TargetQuest, Int TargetAliasID)
	Int Located = 0
	
	If TargetQuest == QuestRefBusShelters
		; No bus shelters
	ElseIf TargetQuest == QuestRefDiners
		If TargetAliasID == 3
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefDives
		If TargetAliasID == 10
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefDriveIns
		If TargetAliasID == 5
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefFactories
		If TargetAliasID == 7 || TargetAliasID == 10
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefFarms
		; No farms
	ElseIf TargetQuest == QuestRefJunkyards
		Int[] MyArray
		MyArray.Add(1)
		MyArray.Add(3)
		MyArray.Add(4)
		MyArray.Add(6)
		MyArray.Add(8)
		MyArray.Add(10)
		MyArray.Add(12)
		MyArray.Add(17)
		If MyArray.Find(TargetAliasID) >= 0
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefMilitaryBases
		If TargetAliasID == 0 || TargetAliasID == 18
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefMonuments
		If TargetAliasID == 2 || TargetAliasID == 21 || TargetAliasID == 26
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefPowerLifts
		; No power lifts
	ElseIf TargetQuest == QuestRefRedRocket
		If TargetAliasID == 20 || TargetAliasID == 21 || TargetAliasID == 22
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefVaults
		If TargetAliasID == 9
			Located = 1
		EndIf
	Else
		Debug.TraceAndBox("HITCHHIKER: NULL IN FH CHECK!")
	EndIf
	
	If Located
		Return 1
	Else
		Return 0
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH IS IN NUKA WORLD
; ------------------------------------------------------------------------------------------------------------

Int Function HH_IsInNukaWorld(Quest TargetQuest, Int TargetAliasID)
	Int Located = 0
	
	If TargetQuest == QuestRefBusShelters
		; No bus shelters
	ElseIf TargetQuest == QuestRefDiners
		If TargetAliasID == 2 || TargetAliasID == 13
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefDives
		If TargetAliasID == 2
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefDriveIns
		If TargetAliasID == 0 || TargetAliasID == 3 || TargetAliasID == 9 || TargetAliasID == 10
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefFactories
		If TargetAliasID == 11
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefFarms
		; No farms
	ElseIf TargetQuest == QuestRefJunkyards
		If TargetAliasID == 9
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefMilitaryBases
		If TargetAliasID == 11 || TargetAliasID == 12
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefMonuments
		If TargetAliasID == 4 || TargetAliasID == 9 || TargetAliasID == 23 || TargetAliasID == 24
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefPowerLifts
		If TargetAliasID == 13 || TargetAliasID == 14
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefRedRocket
		If TargetAliasID == 23 || TargetAliasID == 24
			Located = 1
		EndIf
	ElseIf TargetQuest == QuestRefVaults
		; No vaults
	Else
		Debug.TraceAndBox("HITCHHIKER: NULL IN NW CHECK!")
	EndIf
	
	If Located
		Return 1
	Else
		Return 0
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH QUERY QUEST
; ------------------------------------------------------------------------------------------------------------

Quest Function HH_QueryQuest()
	Return QuestToGrab
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: IS FURNITURE
; ------------------------------------------------------------------------------------------------------------

; Declared in properties: FormList Property HH_IsFurniture Auto Const Mandatory
; NESTED: Property is a formlist of formlists of furnitures. (Total = 302 NPC/Player furniture actions)
; [0] IsFurnitureBed			 34
; [1] IsFurnitureBedWorkshop	 20
; [2] IsFurnitureBench			 19
; [3] IsFurnitureChair			 57
; [4] IsFurnitureCouch			 24
; [5] IsFurnitureInstitute		 11
; [6] IsFurnitureInv			  6
; [7] IsFurnitureKneel			  6
; [8] IsFurnitureMisc			104
; [9] IsFurnitureStand			  8
; [10] IsFurnitureStool			 13

Int Function IsFurniture(ObjectReference TargetToCheck)
	Form TargetBaseObject = TargetToCheck.GetBaseObject()
	FormList FurnList = HH_IsFurniture															; FormList declared in properties
	FormList NestedList
	Int FurnSize = FurnList.GetSize()
	Int i = 0
	Int Found = 0
	
	While i < FurnSize && !Found																; Stop loop if form found in furniture
		NestedList = FurnList.GetAt(i) as FormList												; Loop grabs next unchecked formlist
		
		If NestedList.HasForm(TargetBaseObject)													; If found,
			Found = 1																			; mark as found and break loop
		Else
			i += 1																				; else iterate and keep looking
		EndIf
	EndWhile
	
	Return Found																				; return found (1) or not found (0) to caller
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH TRY TO USE FURNITURE
; ------------------------------------------------------------------------------------------------------------

Int Function HH_TryToUseFurniture(Actor Person, ObjectReference TargetRef)
	Int DidItWork = 0
	
	If IsFurniture(TargetRef) == 1																; If target can be used (chair, wall lean, etc)
		If TargetRef.IsFurnitureInUse(True) == False											; and target is not in use right now (ignores reserved)
			If Person.SnapIntoInteraction(TargetRef)											; then attempt to use the furniture
				DidItWork = 1
			EndIf
		EndIf
	EndIf
	
	Return DidItWork
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE TIME
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceTime(Int TargetHour)
	Int CurrentHour = pGameHour.GetValue() as Int												; Get current game hour
	Int MyDuration 																				; and determine how long to wait
	
	If TargetHour < 0 || TargetHour > 24
		TargetHour = 9
	EndIf
	
	If CurrentHour < TargetHour																	; If target is later in same day,
		MyDuration = TargetHour - CurrentHour													; waiting period is easy to calculate
	Else
		MyDuration = 24 - (CurrentHour - TargetHour)											; else duration is difference subtracted from midnight
	EndIf
	
	If MyDuration > 0 && MyDuration < 24														; If duration will result in a time change,
		Game.PassTime(MyDuration)																; wait that duration
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE WEATHER
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceWeather(Int MyForecast)
	If !Player.IsInInterior()																	; If destination is NOT indoors...
		Weather MyWeather
		
		If MyForecast == 1
			MyWeather = CommonwealthClear														; Clear
		ElseIf MyForecast == 2
			MyWeather = CommonwealthDusty														; Dusty
		ElseIf MyForecast == 3
			MyWeather = CommonwealthFoggy														; Foggy
		ElseIf MyForecast == 4
			MyWeather = CommonwealthMisty														; Misty
		ElseIf MyForecast == 5
			MyWeather = CommonwealthMistyRainy													; Misty Rainy
		ElseIf MyForecast == 6
			MyWeather = CommonwealthOvercast													; Overcast
		ElseIf MyForecast == 7
			MyWeather = CommonwealthGSRadstorm													; Radstorm
		ElseIf MyForecast == 8
			MyWeather = CommonwealthRain														; Rain
		Else
			MyWeather = DefaultWeather															; Default Weather (outdoors)
		EndIf
		
		MyWeather.ForceActive()																	; Force weather change now
	EndIf
EndFunction
