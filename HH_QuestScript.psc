Scriptname HH_QuestScript extends Quest
{ It just works. }

;/

Fallout 4 Papyrus script by ThoraldGM | http://thoraldgm.com | Updated 20180111
Hitchhiker mod: (url pending)

SCRIPT SECTIONS:

LINE 0032: PROPERTIES
LINE ####: ON INIT
LINE ####: HH START HITCHING
LINE ####: ON MENU OPEN CLOSE EVENT
LINE ####: (OPTIONAL AUTO TIME CHANGE)
LINE ####: (OPTIONAL AUTO WEATHER CHANGE)
LINE ####: HH SPIN CAMERA
LINE ####: ON TIMER
LINE ####: HH STOP SPINNING
LINE ####: HH SET RANDOM DESTINATION
LINE ####: HH IS IN FAR HARBOR
LINE ####: HH IS IN NUKA WORLD
LINE ####: IS FURNITURE
LINE ####: HH TRY TO USE FURNITURE
LINE ####: HH FORCE TIME
LINE ####: HH FORCE WEATHER
LINE ####: HH MARK TALES ON MAP

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
; Weather:
; ************************************************************************************************************
Weather Property DefaultWeather Auto Const Mandatory
{ Default weather (outdoors) }
Weather Property CommonwealthClear Auto Const Mandatory
{ Clear }
Weather Property CommonwealthDusty Auto Const Mandatory
{ Dusty }
Weather Property CommonwealthFoggy Auto Const Mandatory
{ Foggy }
Weather Property CommonwealthMisty Auto Const Mandatory
{ Misty }
Weather Property CommonwealthMistyRainy Auto Const Mandatory
{ Misty Rainy }
Weather Property CommonwealthOvercast Auto Const Mandatory
{ Overcast }
Weather Property CommonwealthGSRadstorm Auto Const Mandatory
{ Radstorm }
Weather Property CommonwealthRain Auto Const Mandatory
{ Rain }

; ************************************************************************************************************
; Postcards:
; ************************************************************************************************************
Book Property HH_Postcard_Bus Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Diner Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Dive Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Drive Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Factory Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Farm Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Junkyard Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Military Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Monument Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Power Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Red Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Vault Auto Const Mandatory
{ Modforge Postcard }
Book Property HH_Postcard_Welcome Auto Const Mandatory
{ Modforge Postcard }

; ************************************************************************************************************
; Other CK Properties:
; ************************************************************************************************************
Book Property HH_Map Auto Const Mandatory
{ Hitchhiker map }
Book Property HH_Note_Recipe Auto Const Mandatory
{ Dandelion Wine Recipe }
FormList Property HH_IsFurniture Auto Const Mandatory
{ Formlist of formlists of furnitures }
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
{ Don't show menu when map placed in inventory }
GlobalVariable Property pGameHour Auto Mandatory
{ Current game hour (from vanilla CK) }
Perk Property HH_TeleportNoFallDamage Auto Const Mandatory
{ Temp perk so teleport falls don't kill player }
Sound Property DRSVertibirdFlightLoadOpen Auto Const Mandatory
{ Teleport start sound effect }
Sound Property OBJHijackerTeleportOut2DA Auto Const Mandatory
{ Teleport end sound effect }
STATIC Property pXMarker Auto Const Mandatory
{ Xmarker (from vanilla CK) }
STATIC Property pXMarkerHeading Auto Const Mandatory
{ Xmarker heading (from vanilla CK) }
STATIC Property pCOCMarkerHeading Auto Const Mandatory
{ COC Xmarker heading (from vanilla CK) }
STATIC Property HH_TrinityMarker Auto Const Mandatory
{ Map marker for Trinity Plaza }

; ************************************************************************************************************
; Non-CK Variables Defined "Globally"
; ************************************************************************************************************
Actor Player																	; Player actor

Int BUS_SHELTERS = 1															; Category ints (makes code easier to read)
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

String GO_FILE = "Fallout4.esm"													; Vanilla or DLC destination?

Int[] Go_Bus																	; Destination arrays (hex refIDs converted to decimal)
Int[] Go_Diner
Int[] Go_Dive
Int[] Go_Drive
Int[] Go_Factory
Int[] Go_Farm
Int[] Go_Junkyard
Int[] Go_Military
Int[] Go_Monument
Int[] Go_Power
Int[] Go_Red
Int[] Go_Vault

String[] Coc_Bus																; Destination arrays (CenterOnCell strings)
String[] Coc_Diner
String[] Coc_Dive
String[] Coc_Drive
String[] Coc_Factory
String[] Coc_Farm
String[] Coc_Junkyard
String[] Coc_Military
String[] Coc_Monument
String[] Coc_Power
String[] Coc_Red
String[] Coc_Vault

Int[] Visited_Bus																; Arrays track whether destinations have been visited
Int[] Visited_Diner
Int[] Visited_Dive
Int[] Visited_Drive
Int[] Visited_Factory
Int[] Visited_Farm
Int[] Visited_Junkyard
Int[] Visited_Military
Int[] Visited_Monument
Int[] Visited_Power
Int[] Visited_Red
Int[] Visited_Vault

ObjectReference TrinityMarker													; Covers Trinity Plaza patrol marker in HH_MarkTalesOnMap

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON INIT
; ------------------------------------------------------------------------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()													; Player actor
	Utility.Wait(0.1)															; Wait a moment before use
	
	If Debug.GetPlatformName() as Bool											; If player is on PC,
		HH_PlayerHasPC.SetValue(1)												; update HasPC global (for COC option)
	EndIf
	
	If Player.GetItemCount(HH_Map) == 0											; If player doesn't have hitchhiker map,
		HH_ShowMenu.SetValue(0)													; don't show menu when map placed in inventory
		Utility.Wait(5)															; wait 5 seconds
		Player.AddItem(HH_Map)													; spawn hitchhiker map in player inventory
	EndIf
	
	Utility.Wait(5)
	Player.AddItem(HH_Postcard_Welcome)
	Utility.Wait(5)
	Player.AddItem(HH_Note_Recipe)
	Utility.Wait(5)
	HH_MarkTalesOnMap()
	
	; ********************************************************************************************************
	; Initialize the destination arrays (hex refIDs converted to decimal)
	; ********************************************************************************************************

	Go_Bus = New Int[10]														; Array of Bus Shelters (hex refIDs converted to decimal)
	Go_Bus[0] = 1532935															; College Square
	Go_Bus[1] = 1532909															; D.B. Tech High School
	Go_Bus[2] = 1532960															; Fallon's Dept Store
	Go_Bus[3] = 1532952															; Fiddler's Green
	Go_Bus[4] = 1532899															; Goodneighbor
	Go_Bus[5] = 1532938															; Kendall Hospital
	Go_Bus[6] = 1036336															; Lexington Station
	Go_Bus[7] = 1532931															; Prospect Park
	Go_Bus[8] = 1532877															; Revere Beach Station
	Go_Bus[9] = 1521373															; University Point

	Go_Diner = New Int[30]														; Array of Diners (hex refIDs converted to decimal)
	Go_Diner[0] = 1122296														; Anna's Cafe
	Go_Diner[1] = 2183822														; Cambridge Campus Diner
	Go_Diner[2] = 230033														; DLC NW: Cappy's Cafe
	Go_Diner[3] = 173685														; DLC FH: Cliff's Edge Hotel
	Go_Diner[4] = 2295674														; Diamond City Concessions
	Go_Diner[5] = 2392399														; Diamond City Diner
	Go_Diner[6] = 2359733														; Drumlin Diner Concord
	Go_Diner[7] = 653229														; Drumlin Diner East Boston
	Go_Diner[8] = 1691105														; Drumlin Diner Gibson Point Pier
	Go_Diner[9] = 384976														; Drumlin Diner Jamaica Plain
	Go_Diner[10] = 331602														; Drumlin Diner Salem
	Go_Diner[11] = 1104080														; Fens Cafe
	Go_Diner[12] = 570559														; Fentons Food Stuffs
	Go_Diner[13] = 227275														; DLC NW: Fizztop Grille
	Go_Diner[14] = 2240433														; Forest Grove Bakery
	Go_Diner[15] = 2240407														; Forest Grove Crab Shack
	Go_Diner[16] = 978915														; Handy Eats
	Go_Diner[17] = 1738539														; Joe's Spuckies Andrews Station
	Go_Diner[18] = 1690551														; Joe's Spuckies Mean Pastries
	Go_Diner[19] = 1406325														; Joe's Spuckies Postal Square
	Go_Diner[20] = 978894														; Pinelli's Bakery
	Go_Diner[21] = 1517424														; Pizza Parlor
	Go_Diner[22] = 12384														; Power Noodles
	Go_Diner[23] = 1463497														; Quincy Diner
	Go_Diner[24] = 426896														; Revere Beach Ice Cream Parlor
	Go_Diner[25] = 664050														; Shenley's Oyster Bar
	Go_Diner[26] = 2337293														; Slocum's Joe Corporate HQ
	Go_Diner[27] = 978903														; Slocum's Joe Galleria
	Go_Diner[28] = 1033582														; Slocum's Joe Lexington
	Go_Diner[29] = 2258997														; Slocum's Joe Monsignor Plaza

	Go_Dive = New Int[13]														; Array of Dives (hex refIDs converted to decimal)
	Go_Dive[0] = 101019															; Colonial Taphouse
	Go_Dive[1] = 146480															; Concord Speakeasy
	Go_Dive[2] = 280352															; DLC NW: Doc Phosphate's Saloon
	Go_Dive[3] = 406929															; Dugout Inn
	Go_Dive[4] = 2240517														; Forest Grove Pub Buffet
	Go_Dive[5] = 313396															; Gwinnett Restaurant
	Go_Dive[6] = 857986															; Nahant Bar Restaurant
	Go_Dive[7] = 1534528														; Prost Bar
	Go_Dive[8] = 1730482														; Quincy Liquors
	Go_Dive[9] = 993894															; Shamrock Taphouse
	Go_Dive[10] = 13532															; DLC FH: The Last Plank
	Go_Dive[11] = 1094147														; The Third Rail
	Go_Dive[12] = 1835650														; Ticker Tape Lounge

	Go_Drive = New Int[12]														; Array of Drive-Ins (hex refIDs converted to decimal)
	Go_Drive[0] = 304799														; DLC NW: Bradberton Amphitheater
	Go_Drive[1] = 418374														; Charles View Amphitheater
	Go_Drive[2] = 667329														; Combat Zone
	Go_Drive[3] = 280574														; DLC NW: Dry Rock Gulch Theater
	Go_Drive[4] = 512351														; Easy City Downs
	Go_Drive[5] = 19439															; DLC FH: Eden Meadows Cinemas
	Go_Drive[6] = 348713														; Memory Den
	Go_Drive[7] = 355872														; Pickman Gallery
	Go_Drive[8] = 1762068														; Starlight Drive-In
	Go_Drive[9] = 59247															; DLC NW: Starlight Interstellar Theater
	Go_Drive[10] = 138624														; DLC NW: The Parlor
	Go_Drive[11] = 753389														; Warren Theater

	Go_Factory = New Int[12]													; Array of Factories (hex refIDs converted to decimal)
	Go_Factory[0] = 1703801														; Beantown Brewery
	Go_Factory[1] = 1401756														; Choice Chops
	Go_Factory[2] = 251478														; Four Leaf Fishpacking Plant
	Go_Factory[3] = 313398														; Gwinnett Brewery
	Go_Factory[4] = 251954														; Longneck Lukowski's
	Go_Factory[5] = 346176														; Mahkra Fishpacking
	Go_Factory[6] = 316735														; Parsons Creamery
	Go_Factory[7] = 227672														; DLC FH: Super Duper Mart Far Harbor
	Go_Factory[8] = 321315														; Super Duper Mart Lexington
	Go_Factory[9] = 1177129														; Super Duper Mart Quincy
	Go_Factory[10] = 94102														; DLC FH: Vim! Pop Factory
	Go_Factory[11] = 103732														; DLC NW: World of Refreshment

	Go_Farm = New Int[12]														; Array of Farms (hex refIDs converted to decimal)
	Go_Farm[0] = 457355															; Abernathy Farm
	Go_Farm[1] = 635383															; Breakheart Banks
	Go_Farm[2] = 635349															; County Crossing
	Go_Farm[3] = 635295															; Finch Farm
	Go_Farm[4] = 481105															; Graygarden
	Go_Farm[5] = 1762027														; Greentop Nursery
	Go_Farm[6] = 1762039														; Nordhagen Beach
	Go_Farm[7] = 1762043														; Oberland Station
	Go_Farm[8] = 1762062														; Somerville Place
	Go_Farm[9] = 635315															; Tenpines Bluff
	Go_Farm[10] = 1762083														; The Slog
	Go_Farm[11] = 481057														; Warwick Homestead

	Go_Junkyard = New Int[20]													; Array of Junkyards (hex refIDs converted to decimal)
	Go_Junkyard[0] = 368210														; Big John's Salvage
	Go_Junkyard[1] = 37875														; DLC FH: Echo Lake Lumber
	Go_Junkyard[2] = 2174576													; FMS Northern Star Wreck
	Go_Junkyard[3] = 132938														; DLC FH: Fringe Cove Docks
	Go_Junkyard[4] = 37874														; DLC FH: Horizon Flight 1207
	Go_Junkyard[5] = 1602063													; Hub City Auto Wreckers
	Go_Junkyard[6] = 45519														; DLC FH: Huntress Island
	Go_Junkyard[7] = 341442														; Jalbert Brothers Disposal
	Go_Junkyard[8] = 132698														; DLC FH: MS Azalea
	Go_Junkyard[9] = 95274														; DLC NW: Nuka-World Junkyard
	Go_Junkyard[10] = 327591													; DLC FH: Oceanarium
	Go_Junkyard[11] = 367442													; Robotics Disposal Ground
	Go_Junkyard[12] = 344623													; DLC FH: Rock Point Camp
	Go_Junkyard[13] = 481064													; Rotten Landfill
	Go_Junkyard[14] = 313557													; Scrap Palace
	Go_Junkyard[15] = 712077													; Skylanes Flight 1665
	Go_Junkyard[16] = 2359843													; Skylanes Flight 1981
	Go_Junkyard[17] = 235979													; DLC FH: Southwest Harbor
	Go_Junkyard[18] = 178994													; USS Riptide Wreck
	Go_Junkyard[19] = 418367													; Wicked Shipping Fleet Lockup

	Go_Military = New Int[20]													; Array of Military Bases (hex refIDs converted to decimal)
	Go_Military[0] = 213829														; DLC FH: Acadia
	Go_Military[1] = 178950														; Boston Mayoral Shelter
	Go_Military[2] = 181849														; Boston Police Rationing Site
	Go_Military[3] = 129959														; Coast Guard Pier
	Go_Military[4] = 178560														; Federal Ration Stockpile
	Go_Military[5] = 1630298													; Federal Supply Cache 84NE
	Go_Military[6] = 764620														; Fort Hagen
	Go_Military[7] = 1761682													; Fort Hagen Satellite Array
	Go_Military[8] = 179188														; Fort Strong
	Go_Military[9] = 420828														; Listening Post Bravo
	Go_Military[10] = 180014													; National Guard Training Yard
	Go_Military[11] = 353903													; DLC NW: Northpoint Reservoir
	Go_Military[12] = 307598													; DLC NW: Nuka-World Power Plant
	Go_Military[13] = 767042													; Recon Bunker Theta
	Go_Military[14] = 180012													; Revere Satellite Array
	Go_Military[15] = 1690999													; Sentinel Site
	Go_Military[16] = 366429													; S. Boston Military Checkpoint
	Go_Military[17] = 701236													; The Castle
	Go_Military[18] = 19733														; DLC FH: The Nucleus
	Go_Military[19] = 481039													; USAF Satellite Station Olivia

	Go_Monument = New Int[30]													; Array of Monuments (hex refIDs converted to decimal)
	Go_Monument[0] = 2400418													; Boston Airport
	Go_Monument[1] = 1558498													; Boston Public Library
	Go_Monument[2] = 60647														; DLC FH: Brooke's Head Lighthouse
	Go_Monument[3] = 2056500													; Bunker Hill
	Go_Monument[4] = 353976														; DLC FH: Children of Atom Shrine
	Go_Monument[5] = 179040														; Custom House Tower
	Go_Monument[6] = 102400														; Diamond City
	Go_Monument[7] = 482878														; Fallen Skybridge
	Go_Monument[8] = 179106														; Faneuil Hall
	Go_Monument[9] = 319727														; DLC NW: Ferris Wheel
	Go_Monument[10] = 1967529													; Garden Terrace
	Go_Monument[11] = 1732997													; Gunners Plaza
	Go_Monument[12] = 369107													; Jamaica Plain
	Go_Monument[13] = 180861													; Kingsport Lighthouse
	Go_Monument[14] = 294870													; Mass Fusion Building
	Go_Monument[15] = 1604595													; Mass State House
	Go_Monument[16] = 888476													; Minuteman Statue Lexington
	Go_Monument[17] = 119589													; Minuteman Statue Sanctuary
	Go_Monument[18] = 694029													; Monsignor Plaza
	Go_Monument[19] = 119827													; Museum of Freedom
	Go_Monument[20] = 1426695													; Museum of Witchcraft
	Go_Monument[21] = 43815														; DLC FH: National Park Visitor's Center
	Go_Monument[22] = 1761683													; North End Graveyard
	Go_Monument[23] = 227773													; DLC NW: Nuka-Town USA
	Go_Monument[24] = 44469														; DLC NW: Nuka-World Transit Center
	Go_Monument[25] = 122031													; Old North Church
	Go_Monument[26] = 354583													; DLC FH: Radiant Crest Shrine
	Go_Monument[27] = 117479													; Swan's Pond
	Go_Monument[28] = 135473													; Trinity Tower
	Go_Monument[29] = 827566													; USS Constitution

	; NOTE: POWER LIFTS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD
	
	Go_Power = New Int[15]														; Array of Power Lifts (hex refIDs converted to decimal)
	Go_Power[0] = 1859070														; Wilderness (-18, -7)
	Go_Power[1] = 1858996														; Mass Pike Interchange
	Go_Power[2] = 1911054														; Wildwood Cemetery
	Go_Power[3] = 1835452														; Tucker Memorial Bridge
	Go_Power[4] = 1835429														; College Square
	Go_Power[5] = 1835431														; Layton Towers
	Go_Power[6] = 1835430														; Financial District
	Go_Power[7] = 2062988														; Union Man's Circle
	Go_Power[8] = 2010360														; Parsons State Asylum
	Go_Power[9] = 2016674														; Sunshine Tidings Co-Op
	Go_Power[10] = 1875342														; Mass Bay Medical Center
	Go_Power[11] = 2392999														; Beacon Hill
	Go_Power[12] = 2393009														; Cabot House
	Go_Power[13] = 300729														; DLC NW: Bradberton North
	Go_Power[14] = 335533														; DLC NW: Bradberton South

	; NOTE: RED ROCKETS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD

	Go_Red = New Int[25]														; Array of Red Rockets (hex refIDs converted to decimal)
	Go_Red[0] = 137728															; Commonwealth (-11, -16)
	Go_Red[1] = 1367517															; Egret Tours Marina
	Go_Red[2] = 997755															; Graygarden
	Go_Red[3] = 2048404															; Electrical Hobbyist's Club
	Go_Red[4] = 1082593															; Lexington Ext 06
	Go_Red[5] = 1882831															; Commonwealth (2, -12)
	Go_Red[6] = 1703608															; Shaw High School
	Go_Red[7] = 651672															; Neponset Park
	Go_Red[8] = 1934605															; Commonwealth (12, 4)
	Go_Red[9] = 1846213															; Commonwealth (-3, -9)
	Go_Red[10] = 1418985														; Glowing Sea
	Go_Red[11] = 1898269														; Commonwealth (-3, 2)
	Go_Red[12] = 1186505														; Lexington Ext 02
	Go_Red[13] = 1817557														; Wilson Atomatoys Factory
	Go_Red[14] = 1997542														; Commonwealth (20, 8)
	Go_Red[15] = 1289039														; Red Rocket Settlement
	Go_Red[16] = 1866305														; Atom Cats Garage
	Go_Red[17] = 1845371														; Commonwealth (2, -10)
	Go_Red[18] = 1933571														; Commonwealth (5, -21)
	Go_Red[19] = 421969															; Nahant Red Rocket
	Go_Red[20] = 19823															; DLC FH: Beaver Creek Red Rocket
	Go_Red[21] = 50458															; DLC FH: Harbor North Red Rocket
	Go_Red[22] = 183954															; DLC FH: Harbor Southwest Red Rocket
	Go_Red[23] = 54163															; DLC NW: Hubologist's Camp
	Go_Red[24] = 277523															; DLC NW: Nuka-World Red Rocket

	Go_Vault = New Int[10]														; Array of Vaults (hex refIDs converted to decimal)
	Go_Vault[0] = 454896														; Sanctuary Hills
	Go_Vault[1] = 1761691														; Vault-Tec Regional HQ
	Go_Vault[2] = 788058														; Vault 75
	Go_Vault[3] = 626404														; Vault 81 New
	Go_Vault[4] = 2035848														; Vault 81 Old
	Go_Vault[5] = 16919															; DLC VT: Vault 88
	Go_Vault[6] = 1247746														; Vault 95
	Go_Vault[7] = 418357														; Vault 111
	Go_Vault[8] = 1789587														; Vault 114
	Go_Vault[9] = 232187														; DLC FH: Vault 118
	
	; ********************************************************************************************************
	; Initialize the destination arrays (CenterOnCell strings)
	; ********************************************************************************************************

	Coc_Bus = New String[10]													; Array of Bus Shelters (CenterOnCell strings)
	Coc_Bus[0] = "CollegeSquareExt03"
	Coc_Bus[1] = "DBTechHighSchoolExt"
	Coc_Bus[2] = "FallonsDepartmentStoreExt"
	Coc_Bus[3] = "FiddlersGreenExt"
	Coc_Bus[4] = "GoodneighborExt02"
	Coc_Bus[5] = "KendallHospitalExt"
	Coc_Bus[6] = "LexingtonExt06"
	Coc_Bus[7] = "ProspectParkExt02"
	Coc_Bus[8] = "RevereBeachStationExt04"
	Coc_Bus[9] = "UniversityPointExt02"

	Coc_Diner = New String[30]													; Array of Diners (CenterOnCell strings)
	Coc_Diner[0] = "FensBankExt"
	Coc_Diner[1] = "CambridgeDiner01"
	Coc_Diner[2] = "NukaWorldNukaTownUSA02"
	Coc_Diner[3] = "DLC03POI60"
	Coc_Diner[4] = "DiamondCityExt"
	Coc_Diner[5] = "DiamondCityExt03"
	Coc_Diner[6] = "DrumlinDiner"
	Coc_Diner[7] = "DNPrimeBridge01"
	Coc_Diner[8] = "GibsonPointPierExt02"
	Coc_Diner[9] = "JamaicaPlainExt03"
	Coc_Diner[10] = "SandyCovesHomeExt"
	Coc_Diner[11] = "FensSquare"
	Coc_Diner[12] = "QuincyRuinsExt04"
	Coc_Diner[13] = "DmndDugoutInn01"
	Coc_Diner[14] = "ForestGroveMarshExt02"
	Coc_Diner[15] = "ForestGroveMarshExt02"
	Coc_Diner[16] = "GeneralAtomicsGalleriaExt02"
	Coc_Diner[17] = "SouthBostonExtN"
	Coc_Diner[18] = "NorthEndGraveyardEXT"
	Coc_Diner[19] = "FinancialPostalSquare"
	Coc_Diner[20] = "GeneralAtomicsGalleriaExt"
	Coc_Diner[21] = "POIMilitaryMC02"
	Coc_Diner[22] = "DiamondCityOrigin"
	Coc_Diner[23] = "QuincyRuinsExt04"
	Coc_Diner[24] = "RevereBeachStationExt03"
	Coc_Diner[25] = "HalluciGenExt"
	Coc_Diner[26] = "SlocumsJoeHQExt"
	Coc_Diner[27] = "GeneralAtomicsGalleriaExt"
	Coc_Diner[28] = "SwitchboardExt"
	Coc_Diner[29] = "CambridgeMonsignorPlaza01"

	Coc_Dive = New String[13]													; Array of Dives (CenterOnCell strings)
	Coc_Dive[0] = "DiamondCityUpperStands"
	Coc_Dive[1] = "ConcordExt"
	Coc_Dive[2] = "NukaWorldWWSaloon"
	Coc_Dive[3] = "DiamondCityUpperStands"
	Coc_Dive[4] = "ForestGroveMarshExt"
	Coc_Dive[5] = "GwinnettBreweryExt"
	Coc_Dive[6] = "NahantChapelExt"
	Coc_Dive[7] = "BeaconHillPub"
	Coc_Dive[8] = "QuincyRuinsExt05"
	Coc_Dive[9] = "ShamrockTaphouseExt"
	Coc_Dive[10] = "DLC03FarHarborLastPlank"
	Coc_Dive[11] = "GoodneighborTheThirdRail"
	Coc_Dive[12] = "Theater27TickerTapeLounge"

	Coc_Drive = New String[12]													; Array of Drive-Ins (CenterOnCell strings)
	Coc_Drive[0] = "BradbertonAmphitheater01"
	Coc_Drive[1] = "CharlesViewAmphitheaterExt"
	Coc_Drive[2] = "CombatZoneExt"
	Coc_Drive[3] = "NukaWorldWildWestExt03"
	Coc_Drive[4] = "EasyCityDownsExt03"
	Coc_Drive[5] = "EdenMeadowsCinemasExt"
	Coc_Drive[6] = "GoodneighborTheMemoryDen"
	Coc_Drive[7] = "PickmanGalleryExt"
	Coc_Drive[8] = "StarlightDriveInExt"
	Coc_Drive[9] = "DLC04GalacticZoneExt03"
	Coc_Drive[10] = "DLC04HubOperatorLair01"
	Coc_Drive[11] = "WarrenTheater01"

	Coc_Factory = New String[12]												; Array of Factories (CenterOnCell strings)
	Coc_Factory[0] = "POIBoS101"
	Coc_Factory[1] = "DiamondCityOrigin"
	Coc_Factory[2] = "FourLeafFishpackingExt"
	Coc_Factory[3] = "GwinnettBreweryExt"
	Coc_Factory[4] = "LongneckLukowskisExt"
	Coc_Factory[5] = "MahkraFishpackingExt"
	Coc_Factory[6] = "ParsonsPOIExt"
	Coc_Factory[7] = "BeaverCreekLanesExt"										; Nearest COC to FH Super Duper Mart?
	Coc_Factory[8] = "SuperDuperMartExt"
	Coc_Factory[9] = "QuincyRuinsExt07"
	Coc_Factory[10] = "VimPopFactoryExt"
	Coc_Factory[11] = "DLC04BottlingPlant01"

	Coc_Farm = New String[12]													; Array of Farms (CenterOnCell strings)
	Coc_Farm[0] = "AbernathyFarmExt"
	Coc_Farm[1] = "BreakheartBanksExt"
	Coc_Farm[2] = "CountyCrossing"
	Coc_Farm[3] = "FinchFarmExt"
	Coc_Farm[4] = "GraygardenHomesteadExt"
	Coc_Farm[5] = "GreentopNurseryExt"
	Coc_Farm[6] = "NordhagenBeach"
	Coc_Farm[7] = "OberlandStation"
	Coc_Farm[8] = "SomervillePlace02"
	Coc_Farm[9] = "TenPinesBluff"
	Coc_Farm[10] = "TheSlogExt02"
	Coc_Farm[11] = "WarwickHomesteadExt"

	Coc_Junkyard = New String[20]												; Array of Junkyards (CenterOnCell strings)
	Coc_Junkyard[0] = "BigJohnsSalvageExt"
	Coc_Junkyard[1] = "EchoLakeLumberExt"
	Coc_Junkyard[2] = "WreckoftheFMSNorthernStarExt"
	Coc_Junkyard[3] = "FringeCoveDocksExt"
	Coc_Junkyard[4] = "HorizonFlight1207Ext"
	Coc_Junkyard[5] = "HubCityAutoWreckersExt"
	Coc_Junkyard[6] = "DLC03POI45"												; Nearest COC to Huntress Island is Waves Crest Orphanage
	Coc_Junkyard[7] = "JalbertBrothersDisposalExt02"
	Coc_Junkyard[8] = "MSAzaleaExt"
	Coc_Junkyard[9] = "DLC04JunkyardExt01"
	Coc_Junkyard[10] = "DLC03POI54"
	Coc_Junkyard[11] = "RoboticsDisposalExt"
	Coc_Junkyard[12] = "RockPointCampExt"
	Coc_Junkyard[13] = "RottenLandfillExt02"
	Coc_Junkyard[14] = "ScrapPalaceExt"
	Coc_Junkyard[15] = "GlowingSeaPOIDB01"
	Coc_Junkyard[16] = "SkylanesFlightExt04"
	Coc_Junkyard[17] = "SouthWestHarborExt"
	Coc_Junkyard[18] = "USSRiptideExt02"
	Coc_Junkyard[19] = "WickedShippingExt"

	Coc_Military = New String[20]												; Array of Military Bases (CenterOnCell strings)
	Coc_Military[0] = "AcadiaObservatoryExt"
	Coc_Military[1] = "BostonMayoralShelterExt"
	Coc_Military[2] = "BostonPoliceRationingSiteExt"
	Coc_Military[3] = "CoastGuardPierExt"
	Coc_Military[4] = "FederalRationStockpileExt"
	Coc_Military[5] = "GlowingSeaPOIJS01"
	Coc_Military[6] = "FortHagenExt02"
	Coc_Military[7] = "FortHagenSatelliteArrayExt"
	Coc_Military[8] = "FortStrongExt"
	Coc_Military[9] = "ListeningPostBravoExt"
	Coc_Military[10] = "NationalGuardTrainingYardExt"
	Coc_Military[11] = "DLC04POIBB05"											; Nearest COC to Northpoint Reservoir is Bradberton West
	Coc_Military[12] = "NukaWorldPowerPlantExt"
	Coc_Military[13] = "ReconBunkerThetaExt02"
	Coc_Military[14] = "RevereSatelliteArrayExt"
	Coc_Military[15] = "GlowingSeaSentinelSiteExt"
	Coc_Military[16] = "SouthBostonCheckpointExt"
	Coc_Military[17] = "TheCastleExt"
	Coc_Military[18] = "NucleusExt"
	Coc_Military[19] = "USAFSatelliteExt"

	Coc_Monument = New String[30]												; Array of Monuments (CenterOnCell strings)
	Coc_Monument[0] = "BostonAirportExt02"
	Coc_Monument[1] = "FensIntersection01"
	Coc_Monument[2] = "BrookesHeadLighthouseExt"
	Coc_Monument[3] = "BunkerHillExt03"
	Coc_Monument[4] = "DLC03POI24"
	Coc_Monument[5] = "CustomHouseTowerExt"
	Coc_Monument[6] = "DiamondCityExt"
	Coc_Monument[7] = "TheaterHub360Ext"
	Coc_Monument[8] = "FaneuilHallExt"
	Coc_Monument[9] = "KiddieKingdomExt02"
	Coc_Monument[10] = "USSConstitutionPostExt"
	Coc_Monument[11] = "GNNExt"
	Coc_Monument[12] = "JamaicaPlainExt"
	Coc_Monument[13] = "KingsportLighthouseExt"
	Coc_Monument[14] = "MassFusionExt"
	Coc_Monument[15] = "VaultTecOfficeExt02"
	Coc_Monument[16] = "LexingtonExt03"
	Coc_Monument[17] = "RedRocketExt"
	Coc_Monument[18] = "CambridgeMonsignorPlazaExt"
	Coc_Monument[19] = "ConcordMuseumExt"
	Coc_Monument[20] = "SalemExt03"
	Coc_Monument[21] = "NationalParkVisitorsCenterExt"
	Coc_Monument[22] = "NorthEndGraveyardEXT"
	Coc_Monument[23] = "NukaWorldNukaTownUSAMainGate"
	Coc_Monument[24] = "DLC04TransitCenterExt"
	Coc_Monument[25] = "OldNorthChurchExt"
	Coc_Monument[26] = "DLC03POI38"
	Coc_Monument[27] = "BostonCommonExt03"
	Coc_Monument[28] = "TrinityTowerExt"
	Coc_Monument[29] = "USSConstitutionExt"

	; NOTE: POWER LIFTS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD

	Coc_Power = New String[15]													; Array of Power Lifts (CenterOnCell strings)
	Coc_Power[0] = "BunkerHillExt03"											; Wilderness (-18, -7)
	Coc_Power[1] = "MassPikeInterchangeExt02"									; Mass Pike Interchange
	Coc_Power[2] = "POIRJ07"													; Wildwood Cemetery
	Coc_Power[3] = "POIJS030"													; Tucker Memorial Bridge
	Coc_Power[4] = "CollegeSquareExt"											; College Square
	Coc_Power[5] = "LaytonTowersExt"											; Layton Towers
	Coc_Power[6] = "Financial22Ext"												; Financial District
	Coc_Power[7] = "POISC10"													; Union Man's Circle
	Coc_Power[8] = "POIRJ16"													; Parsons State Asylum
	Coc_Power[9] = "POIJS021"													; Sunshine Tidings Co-Op
	Coc_Power[10] = "CrossRoadsExt01"											; Mass Bay Medical Center
	Coc_Power[11] = "BeaconHillApartmentsExt02"									; Beacon Hill
	Coc_Power[12] = "CabotHouseExt"												; Cabot House
	Coc_Power[13] = "DLC04POIBB06"												; DLC NW: Bradberton North
	Coc_Power[14] = "DLC04POIBB01"												; DLC NW: Bradberton South

	; NOTE: RED ROCKETS ARE NOT IN ABC ORDER DUE TO BEING GRANDFATHERED IN FROM DISCARDED REFQUEST METHOD
	
	; 20180109: Remove Nahant and AtomatoysFactoryExt duplicates? Destinations contain small building and gas prices sign.
	; (The mod is nearly done, so it would be an excessive amount of work for a non-issue. Will remove if problems occur.)
	
	Coc_Red = New String[25]													; Array of Red Rockets (CenterOnCell strings)
	Coc_Red[0] = "CoastGuardPierExt03"											; Commonwealth (-11, -16)
	Coc_Red[1] = "EgretToursMarinaExt02"										; Egret Tours Marina
	Coc_Red[2] = "POIJoel08"													; Graygarden
	Coc_Red[3] = "LexingtonExt06"												; Electrical Hobbyist's Club
	Coc_Red[4] = "POIMilitaryMC05"												; Lexington Ext 06
	Coc_Red[5] = "BigJohnsSalvageExt"											; Commonwealth (2, -12)
	Coc_Red[6] = "POISC04"														; Shaw High School
	Coc_Red[7] = "NeponsetParkExt03"											; Neponset Park
	Coc_Red[8] = "EasyCityDownsExt"												; Commonwealth (12, 4)
	Coc_Red[9] = "DiamondCityExt03"												; Commonwealth (-3, -9)
	Coc_Red[10] = "GlowingSeaPOIDB05"											; Glowing Sea
	Coc_Red[11] = "KendallHospitalExt"											; Commonwealth (-3, 2)
	Coc_Red[12] = "LexingtonExt02"												; Lexington Ext 02
	Coc_Red[13] = "AtomatoysFactoryExt"											; Wilson Atomatoys Factory
	Coc_Red[14] = "Nahant"														; Commonwealth (20, 8)
	Coc_Red[15] = "RedRocketExt"												; Red Rocket Settlement
	Coc_Red[16] = "AtomCatsGarageExt"											; Atom Cats Garage
	Coc_Red[17] = "BackBayCraterExt"											; Commonwealth (2, -10)
	Coc_Red[18] = "AtomatoysFactoryExt04"										; Commonwealth (5, -21)
	Coc_Red[19] = "Nahant"														; Nahant Red Rocket
	Coc_Red[20] = "DLC03POI33"													; DLC FH: Beaver Creek Red Rocket
	Coc_Red[21] = "DLC03POI51"													; DLC FH: Harbor North Red Rocket
	Coc_Red[22] = "DLC03POI58"													; DLC FH: Harbor Southwest Red Rocket
	Coc_Red[23] = "HubologistCampExt"											; DLC NW: Hubologist's Camp
	Coc_Red[24] = "DLC04NukaWorldWorkshop"										; DLC NW: Nuka-World Red Rocket

	Coc_Vault = New String[10]													; Array of Vaults (CenterOnCell strings)
	Coc_Vault[0] = "SanctuaryExt02"
	Coc_Vault[1] = "VaultTecOfficeExt02"
	Coc_Vault[2] = "Vault75"
	Coc_Vault[3] = "Vault81Ext"
	Coc_Vault[4] = "Vault81Secret"
	Coc_Vault[5] = "DLC06VaultWorkshop"
	Coc_Vault[6] = "Vault95Ext"
	Coc_Vault[7] = "Vault111Ext"
	Coc_Vault[8] = "Vault114"
	Coc_Vault[9] = "DLC03Vault118"

	; ********************************************************************************************************
	; Initialize the arrays that hold visited flags (for hitchhike tracking and granting rewards)
	; ********************************************************************************************************

	Visited_Bus = New Int[10]													; Declare size of arrays that hold visited flags
	Visited_Diner = New Int[30]
	Visited_Dive = New Int[13]
	Visited_Drive = New Int[12]
	Visited_Factory = New Int[12]
	Visited_Farm = New Int[12]
	Visited_Junkyard = New Int[20]
	Visited_Military = New Int[20]
	Visited_Monument = New Int[30]
	Visited_Power = New Int[15]
	Visited_Red = New Int[25]
	Visited_Vault = New Int[10]
	
	Int x = 1
	
	While x < 13
		Int[] ArrInit
		
		If x == BUS_SHELTERS
			ArrInit = Visited_Bus												; Altering array copy changes copy AND the original!
		ElseIf x == DINERS
			ArrInit = Visited_Diner
		ElseIf x == DIVES
			ArrInit = Visited_Dive
		ElseIf x == DRIVE_INS
			ArrInit = Visited_Drive
		ElseIf x == FACTORIES
			ArrInit = Visited_Factory
		ElseIf x == FARMS
			ArrInit = Visited_Farm
		ElseIf x == JUNKYARDS
			ArrInit = Visited_Junkyard
		ElseIf x == MILITARY_BASES
			ArrInit = Visited_Military
		ElseIf x == MONUMENTS
			ArrInit = Visited_Monument
		ElseIf x == POWER_LIFTS
			ArrInit = Visited_Power
		ElseIf x == RED_ROCKETS
			ArrInit = Visited_Red
		Else
			ArrInit = Visited_Vault
		EndIf
		
		Int y = 0
		Int ArrLen = ArrInit.Length
		
		While y < ArrLen
			ArrInit[y] = 0														; Initialize array element
			y += 1																; and repeat for each element in array
		EndWhile
		
		x += 1																	; Repeat for the next array in list
	EndWhile

EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH START HITCHING
; ------------------------------------------------------------------------------------------------------------

Function HH_StartHitching()
	If HH_OptionDevTracking.GetValue() as Int == 1
		Debug.TraceAndBox("Hitchhiker: Started hitching...")
	EndIf

	; IMPORTANT: Player has no controls after spin if still in book/pip menus, so wait until Pip-Boy is closed
	
	UnregisterForMenuOpenCloseEvent("PipboyMenu")								; Cancel any previous button spams
	Utility.WaitMenuMode(0.1)													; Give unregister a moment to work
	RegisterForMenuOpenCloseEvent("PipboyMenu")									; then handle time change in the event
EndFunction

; ------------------------------------------------------------------------------------------------------------
; EVENT: ON MENU OPEN CLOSE EVENT
; ------------------------------------------------------------------------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	UnregisterForMenuOpenCloseEvent("PipboyMenu")								; Cancel player button spams
	
    If (asMenuName== "PipboyMenu")												; When the Pip-Boy
        If (!abOpening)															; closes,
			; Thanks to ehtyeci for Vault Boy list!
			; Thread: https://forums.nexusmods.com/index.php?/topic/6271136-i-there-a-list-of-perks-in-their-swf-forms/
			; VB Viewer: http://powback.com/public/Fallout/?mobile=true

			If HH_OptionTeleportSound.GetValue() as Int == 1					; If player wants teleport sound,
				Int iInstanceID = DRSVertibirdFlightLoadOpen.Play(Player)		; play teleport start sound at player
			EndIf

			If HH_OptionVaultBoy.GetValue() as Int == 1							; If player wants Vault Boy animations, show thumbs up
				Game.ShowPerkVaultBoyOnHUD("Components\\VaultBoys\\Perks\\PerkClip_Default.swf")
				Utility.Wait(3)													; Give Vault Boy time to display
			EndIf
						
			Player.AddPerk(HH_TeleportNoFallDamage)								; IMPORTANT: Temp perk so teleport falls don't kill player!
			
			If HH_OptionSpinGhost.GetValue() as Int == 1						; If player wants no spin damage (default)
				If HH_OptionSpinCamera.GetValue() as Int == 1					; If player wants spincam after teleport,
					Player.SetGhost()											; IMPORTANT: Player immune to all damage!
				EndIf															; *** Set ghost now BEFORE the spin! ***
				
				If HH_OptionDevTracking.GetValue() as Int == 1					; If player wants dev messages...
					If Player.IsGhost()											; If player is a ghost,
						Debug.Notification("Hitchhiker: Player is a ghost!")	; display dev message
					EndIf
				EndIf
			EndIf																; NOTE: Unghosting happens in HH_SpinCamera()
			
			If HH_OptionVaultBoy.GetValue() as Int == 1							; If player wants Vault Boy animations, show VANS ride
				Game.ShowPerkVaultBoyOnHUD("Components\\VaultBoys\\Perks\\PerkClip_207d1.swf")
				Utility.Wait(3)													; Give Vault Boy time to display
			EndIf
			
			If HH_OptionTeleportSound.GetValue() as Int == 1					; If player wants teleport sound,
				Int iInstanceID = OBJHijackerTeleportOut2DA.Play(Player)		; play teleport end sound at player
			EndIf
			
			ObjectReference DestinationMarker = Player.PlaceAtMe(pXMarker)		; Dynamically spawn xmarker at player
			Int Category = HH_Category.GetValue() as Int						; Retrieve Category from global
			Int TargetID = HH_TargetID.GetValue() as Int						; Retrieve TargetID from global

			If HH_IsInFarHarbor(Category, TargetID) == 1
				Go_File = "DLCCoast.esm"
			ElseIf HH_IsInNukaWorld(Category, TargetID) == 1
				Go_File = "DLCNukaWorld.esm"
			ElseIf Category == VAULTS && TargetID == 5
				Go_File = "DLCworkshop03.esm"
			Else
				Go_File = "Fallout4.esm"
			EndIf
			
			String Coc_Target													; Target placeholder for COC
			ObjectReference TargetObject										; Destination target as ObjectReference
			Int Hex2Dec															; Destination hex converted to decimal
			
			If Category == BUS_SHELTERS
				Coc_Target = Coc_Bus[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Bus[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Bus[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Bus[TargetID]
			ElseIf Category == DINERS
				Coc_Target = Coc_Diner[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Diner[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Diner[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Diner[TargetID]
			ElseIf Category == DIVES
				Coc_Target = Coc_Dive[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Dive[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Dive[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Dive[TargetID]
			ElseIf Category == DRIVE_INS
				Coc_Target = Coc_Drive[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Drive[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Drive[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Drive[TargetID]
			ElseIf Category == FACTORIES
				Coc_Target = Coc_Factory[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Factory[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Factory[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Factory[TargetID]
			ElseIf Category == FARMS
				Coc_Target = Coc_Farm[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Farm[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Farm[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Farm[TargetID]
			ElseIf Category == JUNKYARDS
				Coc_Target = Coc_Junkyard[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Junkyard[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Junkyard[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Junkyard[TargetID]
			ElseIf Category == MILITARY_BASES
				Coc_Target = Coc_Military[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Military[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Military[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Military[TargetID]
			ElseIf Category == MONUMENTS
				Coc_Target = Coc_Monument[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Monument[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Monument[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Monument[TargetID]
			ElseIf Category == POWER_LIFTS
				Coc_Target = Coc_Power[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Power[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Power[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Power[TargetID]
			ElseIf Category == RED_ROCKETS
				Coc_Target = Coc_Red[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Red[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Red[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Red[TargetID]
			Else
				Coc_Target = Coc_Vault[TargetID]
				DestinationMarker.MoveTo(Game.GetFormFromFile(Go_Vault[TargetID], Go_File) as ObjectReference)
				TargetObject = Game.GetFormFromFile(Go_Vault[TargetID], Go_File) as ObjectReference
				Hex2Dec = Go_Vault[TargetID]
			EndIf
			
			If HH_OptionDevTracking.GetValue() as Int == 1
				Debug.TraceAndBox("Hitching to "+Coc_Target+"\nCategory: "+Category+"\nTargetID: "+TargetID+"\nHex2Dec: "+Hex2Dec+"\nHH Go_File: "+Go_File)
			EndIf

			; ************************************************************************************************
			; Move the player in a manner that best utilizes player's gaming system and declared preferences!
			; ************************************************************************************************
			
			WorldSpace OriginWS = Player.GetWorldSpace()									; Check player worldspace
			WorldSpace TargetWS																; Check target worldspace
			
			If TargetObject
				TargetWS = TargetObject.GetWorldSpace()
				
				If HH_OptionDevTracking.GetValue() as Int == 1
					Debug.TraceAndBox("Hitchhiker\nTargetObject: "+TargetObject+"\nTargetWS: "+TargetWS)
				EndIf

			EndIf
		
			If ((!TargetWS || TargetWS != OriginWS) && (HH_PlayerHasPC.GetValue() as Int == 1)) || (HH_OptionAlwaysCOC.GetValue() as Int == 1)
			
				Debug.CenterOnCell(Coc_Target)												; CenterOnCell to target destination
				
				If HH_OptionDevTracking.GetValue() as Int == 1
					Debug.TraceAndBox("HITCHHIKER: CENTER ON CELL CALLED.")
				EndIf
				
			Else																			; ELSE DO THE USUAL MOVETO ATTEMPT!!!

				STATIC TargetBase = TargetObject.GetBaseObject() as STATIC					; Check if target base object is an X/COC marker/heading
				
				If TargetBase == pXMarker || TargetBase == pXMarkerHeading || TargetBase == pCOCMarkerHeading
				
					; Do not use XYZ offsets if destination is a marker, because teleport placed player directly on the X
					
				Else																		; else move marker to static ref with XYZ offsets
					Float OffsetX = HH_OptionOffsetX.GetValue()								; Player sets X (default 250)
					Float OffsetY = HH_OptionOffsetY.GetValue()								; Player sets Y (default 250)
					Float OffsetZ
					
					If DestinationMarker.IsInInterior()										; If destination is indoors,
						OffsetZ = 50														; don't land in the rafters
					Else
						OffsetZ = HH_OptionOffsetZ.GetValue()								; Else player sets Z (default 500)
					EndIf
					
					Utility.Wait(0.1)
					DestinationMarker.MoveTo(DestinationMarker, OffsetX, OffsetY, OffsetZ)	; Move marker with XYZ offsets
					DestinationMarker.MoveToNearestNavmeshLocation()						; Then move marker to nearest navmesh
				EndIf
				
				If HH_OptionFastTravel.GetValue() as Int == 1								; If player wants loading screens,
					Game.FastTravel(DestinationMarker)										; move player to marker (with load screens?)
					
					If HH_OptionDevTracking.GetValue() as Int == 1
						Debug.TraceAndBox("HITCHHIKER: FAST TRAVEL CALLED.")
					EndIf
				Else
					Player.MoveTo(DestinationMarker)										; else move player (with black screen)
					
					If HH_OptionDevTracking.GetValue() as Int == 1
						Debug.TraceAndBox("HITCHHIKER: MOVETO CALLED.")
					EndIf
				EndIf				
			EndIf

			Utility.Wait(0.1)

			; "If TargetObject Is Furniture" caused illegal typecast compiler error, so I wrote a custom function
			If TargetObject
				HH_TryToUseFurniture(Player, TargetObject)
			EndIf

			; ********************************************************************************************************
			; Optional automatic time change on teleport
			; ********************************************************************************************************
			If HH_OptionSetTime.GetValue() as Int == 1									; If player wants automatic time change (default is NO)
				Int PrefTime = HH_OptionSetTimePreference.GetValue() as Int				; get preferred time
				HH_ForceTime(PrefTime)													; and set it
			EndIf

			; ********************************************************************************************************
			; Optional automatic weather change on teleport
			; ********************************************************************************************************
			If !Player.IsInInterior()													; If destination is NOT indoors...
				If HH_OptionSetWeather.GetValue() as Int == 1							; If player wants automatic weather change (default is NO)
					Int PrefWeather = HH_OptionSetWeatherPreference.GetValue() as Int	; get preferred weather
					HH_ForceWeather(PrefWeather)										; and set it
				EndIf
			EndIf

			If HH_OptionSpinCamera.GetValue() as Int == 1								; If player wants spincam after teleport,
				HH_SpinCamera()															; call the custom spin camera function
			EndIf
			
			StartTimer(10, 2)															; Remove HH_TeleportNoFallDamage perk in 10 seconds
		EndIf
	EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SPIN CAMERA
; ------------------------------------------------------------------------------------------------------------

Function HH_SpinCamera()
	Int SpinSeconds
	Game.ForceFirstPerson()														; IMPORTANT: Must start/run spin in first person!
	
	; Thx steve40 for distance & setini code!
	Float CamMinDistance = HH_OptionCamMinDistance.GetValue()					; Player chooses min distance (default: 100, vanilla: 0)
	Float CamMaxDistance = HH_OptionCamMaxDistance.GetValue()					; Player chooses max distance (default: 200, vanilla: 150)
	Utility.SetIniFloat("fVanityModeMinDist:Camera", CamMinDistance)			; Set min
	Utility.SetIniFloat("fVanityModeMaxDist:Camera", CamMaxDistance)			; Set max
	
	Utility.Wait(1)																; Wait a moment
	Utility.SetINIBool("bForceAutoVanityMode:Camera", true)						; Spin the idle camera around player
	
	HH_IsSpinning.SetValue(1)													; Flag player / camera as spinning
	
	SpinSeconds = HH_OptionSpinDuration.GetValue() as Int						; Player chooses how long to spin (default: 20 seconds)
	StartTimer(SpinSeconds, 1)													; Wait SpinSeconds then call StopSpinning from OnTimer event
EndFunction

; -----------------------------------------------------------------------------------------------------------
; EVENT: ON TIMER
; -----------------------------------------------------------------------------------------------------------

Event OnTimer(int aiTimerID)													; Cancel timer
	If aiTimerID == 1
		HH_StopSpinning()														; Call StopSpinning function
	ElseIf aiTimerID == 2
		Player.RemovePerk(HH_TeleportNoFallDamage)								; Temp perk removed after teleport is safely completed
		
		If HH_OptionHeal.GetValue() as Int == 1									; If player wants healed after teleport,
			Player.ResetHealthAndLimbs()										; reset health and limbs
		EndIf
		
	Else
		; Placeholder for additional timers
	EndIf
EndEvent

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH STOP SPINNING
; ------------------------------------------------------------------------------------------------------------

Function HH_StopSpinning()
	CancelTimer(1)																; Cancel any lingering StopSpinning timers
	
	If Player.IsGhost()															; If player is a ghost,
		Player.SetGhost(false)													; IMPORTANT: Undo player's temporary invulnerability
		
		If HH_OptionDevTracking.GetValue() as Int == 1							; If player wants dev messages
			If Player.IsGhost() == false										; If player is no longer a ghost,
				Debug.Notification("Hitchhiker: Player is not a ghost.")		; display dev message
			EndIf
		EndIf
	EndIf
	
	If HH_IsSpinning.GetValue() as Int == 1										; If player is spinning,
		Utility.SetINIBool("bForceAutoVanityMode:Camera", false)				; stop spinning
		
		Game.ForceFirstPerson()													; IMPORTANT: Call this or spin will last forever!
		
		HH_IsSpinning.SetValue(0)												; Flag player / camera as no longer spinning
		
	EndIf																		; Done with optional spincam effect
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH SET RANDOM DESTINATION
; ------------------------------------------------------------------------------------------------------------

Function HH_SetRandomDestination(Int Category)
	Int TargetCount
	Int TargetID
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

	If Category == BUS_SHELTERS
		TargetCount = Go_Bus.Length
	ElseIf Category == DINERS
		TargetCount = Go_Diner.Length
	ElseIf Category == DIVES
		TargetCount = Go_Dive.Length
	ElseIf Category == DRIVE_INS
		TargetCount = Go_Drive.Length
	ElseIf Category == FACTORIES
		TargetCount = Go_Factory.Length
	ElseIf Category == FARMS
		TargetCount = Go_Farm.Length
	ElseIf Category == JUNKYARDS
		TargetCount = Go_Junkyard.Length
	ElseIf Category == MILITARY_BASES
		TargetCount = Go_Military.Length
	ElseIf Category == MONUMENTS
		TargetCount = Go_Monument.Length
	ElseIf Category == POWER_LIFTS
		TargetCount = Go_Power.Length
	ElseIf Category == RED_ROCKETS
		TargetCount = Go_Red.Length
	Else
		Category = VAULTS
		TargetCount = Go_Vault.Length
	EndIf	
	
	If HH_OptionDevTracking.GetValue() as Int == 1
		Debug.TraceAndBox("Hitchhiker: Category is " + Category + ".")
		Debug.TraceAndBox("Hitchhiker: TargetCount is " + TargetCount +".")
	EndIf

	; ********************************************************************************************************
	; Do-while functionality. Only loops if rolled destination is unwanted DLC.
	; ********************************************************************************************************
	
	ReRoll = 1
	
	While ReRoll == 1
		ReRoll = 0
		TargetID = Utility.RandomInt(0, (TargetCount - 1))						; Roll random 0 through (count - 1)
		
		If ExcludeDLC == 1 || ExcludeFH == 1
			If HH_IsInFarHarbor(Category, TargetID) == 1
				ReRoll = 1
				If HH_OptionDevTracking.GetValue() as Int == 1
					Debug.TraceAndBox("Hitchhiker: FH ReRoll.")
				EndIf
			EndIf
		EndIf
		
		If !ReRoll
			If ExcludeDLC == 1 || ExcludeNW == 1
				If HH_IsInNukaWorld(Category, TargetID) == 1
					ReRoll = 1
					If HH_OptionDevTracking.GetValue() as Int == 1
						Debug.TraceAndBox("Hitchhiker: NW ReRoll.")
					EndIf
				EndIf
			EndIf
		EndIf
		
		If !ReRoll
			If ExcludeDLC == 1 || ExcludeVT == 1
				If Category == VAULTS && TargetID == 5
					ReRoll = 1
					If HH_OptionDevTracking.GetValue() as Int == 1
						Debug.TraceAndBox("Hitchhiker: VT ReRoll.")
					EndIf
				EndIf
			EndIf
		EndIf
	EndWhile

	HH_Category.SetValue(Category)
	HH_TargetID.SetValue(TargetID)
	
	If HH_OptionDevTracking.GetValue() as Int == 1
		Debug.TraceAndBox("Hitchhiker: Category is " + Category + ".")
		Debug.TraceAndBox("Hitchhiker: TargetID is " + TargetID +".")
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH IS IN FAR HARBOR
; ------------------------------------------------------------------------------------------------------------

Int Function HH_IsInFarHarbor(Int Category, Int TargetID)
	Int Located = 0

	If HH_OptionDevTracking.GetValue() as Int == 1
		Debug.TraceAndBox("Hitchhiker: Checking IsInFarHarbor.")
	EndIf

	If Category == BUS_SHELTERS
		; No FH bus shelters
	ElseIf Category == DINERS
		If TargetID == 3
			Located = 1
		EndIf
	ElseIf Category == DIVES
		If TargetID == 10
			Located = 1
		EndIf
	ElseIf Category == DRIVE_INS
		If TargetID == 5
			Located = 1
		EndIf
	ElseIf Category == FACTORIES
		If TargetID == 7 || TargetID == 10
			Located = 1
		EndIf
	ElseIf Category == FARMS
		; No FH farms
	ElseIf Category == JUNKYARDS
		Int[] MyArray
		MyArray.Add(1)
		MyArray.Add(3)
		MyArray.Add(4)
		MyArray.Add(6)
		MyArray.Add(8)
		MyArray.Add(10)
		MyArray.Add(12)
		MyArray.Add(17)
		If MyArray.Find(TargetID) >= 0
			Located = 1
		EndIf
	ElseIf Category == MILITARY_BASES
		If TargetID == 0 || TargetID == 18
			Located = 1
		EndIf
	ElseIf Category == MONUMENTS
		If TargetID == 2 || TargetID == 21 || TargetID == 26
			Located = 1
		EndIf
	ElseIf Category == POWER_LIFTS
		; No FH power lifts
	ElseIf Category == RED_ROCKETS
		If TargetID == 20 || TargetID == 21 || TargetID == 22
			Located = 1
		EndIf
	ElseIf Category == VAULTS
		If TargetID == 9
			Located = 1
		EndIf
	Else
		Debug.TraceAndBox("HITCHHIKER: NULL IN FH CHECK!")
	EndIf
	
	Return Located
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH IS IN NUKA WORLD
; ------------------------------------------------------------------------------------------------------------

Int Function HH_IsInNukaWorld(Int Category, Int TargetID)
	Int Located = 0
	
	If HH_OptionDevTracking.GetValue() as Int == 1
		Debug.TraceAndBox("Hitchhiker: Checking IsInNukaWorld.")
	EndIf

	If Category == BUS_SHELTERS
		; No NW bus shelters
	ElseIf Category == DINERS
		If TargetID == 2 || TargetID == 13
			Located = 1
		EndIf
	ElseIf Category == DIVES
		If TargetID == 2
			Located = 1
		EndIf
	ElseIf Category == DRIVE_INS
		If TargetID == 0 || TargetID == 3 || TargetID == 9 || TargetID == 10
			Located = 1
		EndIf
	ElseIf Category == FACTORIES
		If TargetID == 11
			Located = 1
		EndIf
	ElseIf Category == FARMS
		; No NW farms
	ElseIf Category == JUNKYARDS
		If TargetID == 9
			Located = 1
		EndIf
	ElseIf Category == MILITARY_BASES
		If TargetID == 11 || TargetID == 12
			Located = 1
		EndIf
	ElseIf Category == MONUMENTS
		If TargetID == 4 || TargetID == 9 || TargetID == 23 || TargetID == 24
			Located = 1
		EndIf
	ElseIf Category == POWER_LIFTS
		If TargetID == 13 || TargetID == 14
			Located = 1
		EndIf
	ElseIf Category == RED_ROCKETS
		If TargetID == 23 || TargetID == 24
			Located = 1
		EndIf
	ElseIf Category == VAULTS
		; No NW vaults
	Else
		Debug.TraceAndBox("HITCHHIKER: NULL IN NW CHECK!")
	EndIf
	
	Return Located
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
	FormList FurnList = HH_IsFurniture											; FormList declared in properties
	FormList NestedList
	Int FurnSize = FurnList.GetSize()
	Int i = 0
	Int Found = 0
	
	While i < FurnSize && !Found												; Stop loop if form found in furniture
		NestedList = FurnList.GetAt(i) as FormList								; Loop grabs next unchecked formlist
		
		If NestedList.HasForm(TargetBaseObject)									; If found,
			Found = 1															; mark as found and break loop
		Else
			i += 1																; else iterate and keep looking
		EndIf
	EndWhile
	
	Return Found																; return found (1) or not found (0) to caller
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH TRY TO USE FURNITURE
; ------------------------------------------------------------------------------------------------------------

Int Function HH_TryToUseFurniture(Actor Person, ObjectReference TargetRef)
	Int DidItWork = 0
	
	If IsFurniture(TargetRef) == 1												; If target can be used (chair, wall lean, etc)
		If TargetRef.IsFurnitureInUse(True) == False							; and target is not in use right now (ignores reserved)
			If Person.SnapIntoInteraction(TargetRef)							; then attempt to use the furniture
				DidItWork = 1
				If HH_OptionSpinCamera.GetValue() as Int == 0
					Game.ForceFirstPerson()										; IMPORTANT: Prevents getting stuck in furniture if no spincam
				EndIf
			EndIf
		EndIf
	EndIf
	
	Return DidItWork
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE TIME
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceTime(Int TargetHour)
	Int CurrentHour = pGameHour.GetValue() as Int								; Get current game hour
	Int MyDuration 																; and determine how long to wait
	
	If TargetHour < 0 || TargetHour > 24
		TargetHour = 9
	EndIf
	
	If CurrentHour < TargetHour													; If target is later in same day,
		MyDuration = TargetHour - CurrentHour									; waiting period is easy to calculate
	Else
		Int Difference = CurrentHour - TargetHour
		MyDuration = 24 - Difference											; else duration is difference subtracted from midnight
	EndIf
	
	If MyDuration > 0 && MyDuration < 24										; If duration will result in a time change,
		; PassTime is erratic for some reason: Game.PassTime(MyDuration)
		; Replacing with something that actually works...
		; Thanks to: https://forums.nexusmods.com/index.php?/topic/776172-setting-game-time-to-a-specific-time/

		pGameHour.Mod(MyDuration)
		
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH FORCE WEATHER
; ------------------------------------------------------------------------------------------------------------

Function HH_ForceWeather(Int MyForecast)
	If !Player.IsInInterior()													; If destination is NOT indoors...
		Weather MyWeather
		
		If MyForecast == 1
			MyWeather = CommonwealthClear										; Clear
		ElseIf MyForecast == 2
			MyWeather = CommonwealthDusty										; Dusty
		ElseIf MyForecast == 3
			MyWeather = CommonwealthFoggy										; Foggy
		ElseIf MyForecast == 4
			MyWeather = CommonwealthMisty										; Misty
		ElseIf MyForecast == 5
			MyWeather = CommonwealthMistyRainy									; Misty Rainy
		ElseIf MyForecast == 6
			MyWeather = CommonwealthOvercast									; Overcast
		ElseIf MyForecast == 7
			MyWeather = CommonwealthGSRadstorm									; Radstorm
		ElseIf MyForecast == 8
			MyWeather = CommonwealthRain										; Rain
		Else
			MyWeather = DefaultWeather											; Default Weather (outdoors)
		EndIf
		
		MyWeather.ForceActive()													; Force weather change now
	EndIf
EndFunction

; ------------------------------------------------------------------------------------------------------------
; CUSTOM FUNCTION: HH MARK TALES ON MAP
; ------------------------------------------------------------------------------------------------------------

Function HH_MarkTalesOnMap()
	Int[] ArrTales = New Int[14]												; Hex2Dec array of map marker refs (index 12 is a patrol marker)

	ArrTales[0] = 178961														; #1 My Brain and I (Boston Mayoral Shelter)
	ArrTales[1] = 181905														; #2 The Starlet Sniper (Coast Guard Pier)
	ArrTales[2] = 180801														; #3 Attack of the Metal Men (Dunwich Borers)
	ArrTales[3] = 420101														; #4 Invasion of the Zetans (Hubris Comics)
	ArrTales[4] = 1209694														; #6 Attack of the Fishmen (Skylanes Flight 1981)
	ArrTales[5] = 149850														; #7 Deep Sea Terror (Outpost Zimonja)
	ArrTales[6] = 123655														; #8 The Man Who Could Stop Time (Vault 114)
	ArrTales[7] = 1364335														; #9 When Apes Go Bananas (Railroad HQ)
	ArrTales[8] = 712100														; #10 Giant Insects Invade (Sentinel Site)
	ArrTales[9] = 178124														; #12 Have Dog Will Travel (The Institute)
	ArrTales[10] = 712073														; #13 Curse of the Burned (Crater of Atom)
	ArrTales[11] = 679944														; #41 The Mad Russian's Revenge (Pickman Gallery)
	ArrTales[12] = 1577198														; * #43 Rise of the Mutants (Trinity Church)
	ArrTales[13] = 178319														; #121 Rise of the Radiated (East Boston Prep School)

	Int i = 0
	
	While i < 14
		If i == 12																; * Requires special handling: no Trinity Plaza map marker?
		
			; OBJREF DECLARATION IS IN TOP OF FILE TO KEEP TRINITY MARKER PERSISTENT! (LINE 206)
			
			TrinityMarker = Player.PlaceAtMe(HH_TrinityMarker)					; Dynamically spawn map marker at player
			
			TrinityMarker.MoveTo(Game.GetFormFromFile(ArrTales[i], "Fallout4.esm") as ObjectReference)	; Move Trinity marker to patrol marker
			TrinityMarker.AddToMap()																	; Add Trinity marker to map
		Else
			(Game.GetFormFromFile(ArrTales[i], "Fallout4.esm") as ObjectReference).AddToMap()			; Else add map markers to map
		EndIf
		
		i += 1
	EndWhile
	
	Debug.TraceAndBox("Hitchhiker: Congratulations!")
EndFunction
