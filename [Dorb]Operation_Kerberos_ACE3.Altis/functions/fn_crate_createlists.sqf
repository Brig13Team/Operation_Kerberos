/*
	Author: Dorbedo
	
	Description:
		Creates the configlists of the Items for cratespawner
	
*/
#include "script_component.hpp"

_daten = GETMVAR(DORB_CRATE_ITEMS,[]);

If (!(_daten isEqualTo [])) exitwith {false};

#define ID_RIFLES 		0	// Sturmgewehre
#define ID_MG				1	// Maschinengewehre
#define ID_SNIPER			2	// Scharfschützengewehre
#define ID_SHOTGUN		3	// Restliche Waffen

#define ID_WERFER 		4	// Werfer (AT, AA)
#define ID_PISTOLE 		5	// Sekundärbewaffnung 

#define ID_ANBAUTEILE 		6	// Optiken, Laser, Lampen, Schalldämpfer

#define ID_GRANATEN 		7	// Granaten, Leuchtstäbe, Rauch
#define ID_SPRENGSTOFF 	8	// Minen, Sprengladungen

#define ID_RUCKSACK 		9	// Rucksack (Ohne Funken)
#define ID_WESTE 			10	// Westen
#define ID_UNIFORM 		11	// Uniformen
#define ID_KOPF 			12	// Helme, Mützen, Brillen

#define ID_FUNKGERAETE		13	// Standartfunken + TFR
#define ID_NAVIGATION 		14	// Karte, Kompass, GPS, Ferngläser, Uhren, NSVs

#define ID_MEDICAL		15	// Medicgedöns
#define ID_ITEMS			16	// Inventaritems
#define ID_SONSTIGES		17	// Der Rest - soll leer werden

//// _daten = [		[	[Items]	,	[Munition, nur bei Waffen]	]	,	ID_MG	,	...		,	[	[Funken],	[]	]	,	...		];

private["_daten"];

_types = [];
_types set [ID_RIFLES,["AssaultRifle","Rifle","SubmachineGun"]];
_types set [ID_MG,["MachineGun"]];
_types set [ID_SNIPER,["SniperRifle"]];
_types set [ID_SHOTGUN,["Shotgun"]];
_types set [ID_WERFER,["Launcher","MissileLauncher","RocketLauncher"]];
_types set [ID_PISTOLE,["Handgun"]];
_types set [ID_ANBAUTEILE,["AccessoryMuzzle","AccessoryPointer","AccessorySights"]];
_types set [ID_GRANATEN,["Throw"]];
_types set [ID_SPRENGSTOFF,["Put"]];
_types set [ID_RUCKSACK,["Backpack"]];
_types set [ID_WESTE,["Vest"]];
_types set [ID_UNIFORM,["Uniform"]];
_types set [ID_KOPF,["Headgear","Glasses","NVGoggles"]];
_types set [ID_FUNKGERAETE,["Radio"]];
_types set [ID_NAVIGATION,["Watch","Binocular","Compass","GPS","UAVTerminal","Map","Binocular","LaserDesignator"]];
_types set [ID_MEDICAL,["Medikit","FirstAidKit"]];
_types set [ID_ITEMS,["MineDetector","Toolkit"]];
_types set [ID_SONSTIGES,[]];

_isAceMedical = 
	{
		_namearr = [gettext(_class >> "picture"),"\"] call BIS_fnc_splitString;
		If ("medical" in _namearr) then {true} else {false};
	};

_daten=[];
for "_i" from 0 to 17 do {
	_daten pushback [[],[]];
};

DATEN=_daten;
["DORB_CRATE"] call bis_fnc_startloadingscreen;

_configArray = (
				("isclass _x" configclasses (configfile >> "cfgweapons")) +
				("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
				("isclass _x" configclasses (configfile >> "cfgglasses"))
			);

_progressStep = 1 / count _configArray;

{
	_class = _x;
	_className = configname _x;
	_scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
	_isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true}; //-- Check if base weapon (true for all entity types)
	if (_scope == 2 && {gettext (_class >> "model") != ""} && _isBase && {gettext (_class >> "displayName") != ""}) then {
		private ["_weaponType","_weaponTypeCategory"];
		
		_weaponType = (_className call bis_fnc_itemType);
		_weaponTypeCategory = _weaponType select 0;
		
		if (_weaponTypeCategory != "VehicleWeapon") then {
			_weaponTypeSpecific = _weaponType select 1;
			_weaponTypeID = switch (true) do {
				case (_weaponTypeSpecific in (_types select ID_RIFLES))  : {ID_RIFLES};
				case (_weaponTypeSpecific in (_types select ID_MG))  : {ID_MG};
				case (_weaponTypeSpecific in (_types select ID_SNIPER))  : {ID_SNIPER};
				case (_weaponTypeSpecific in (_types select ID_WERFER))  : {ID_WERFER};
				case (_weaponTypeSpecific in (_types select ID_PISTOLE))  : {ID_PISTOLE};
				case (_weaponTypeSpecific in (_types select ID_SHOTGUN))  : {ID_SHOTGUN};
				case ((configname _class) in (_types select ID_MEDICAL))  : {ID_MEDICAL};
				case (_weaponTypeSpecific in (_types select ID_ANBAUTEILE))  : {ID_ANBAUTEILE};
				case (_weaponTypeSpecific in (_types select ID_FUNKGERAETE))  : {ID_FUNKGERAETE};
				case ((getnumber(_class >> "tf_hasLRradio"))==1)  : {ID_FUNKGERAETE};
				case (_weaponTypeSpecific in (_types select ID_RUCKSACK))  : {ID_RUCKSACK};
				case (_weaponTypeSpecific in (_types select ID_WESTE))  : {ID_WESTE};
				case (_weaponTypeSpecific in (_types select ID_UNIFORM))  : {ID_UNIFORM};
				case (_weaponTypeSpecific in (_types select ID_KOPF))  : {ID_KOPF};
				case (_weaponTypeSpecific in (_types select ID_NAVIGATION))  : {ID_NAVIGATION};
				case (call(_isAceMedical)) :  {ID_MEDICAL};
				case (_weaponTypeSpecific in (_types select ID_ITEMS))  : {ID_ITEMS};
				default {ID_SONSTIGES};
			};
			_items = (_daten select _weaponTypeID) select 0;
			_items set [count _items, _class];
			/// passende Magazin + vergleich ob schon gelistet
			_items = (_daten select _weaponTypeID) select 1;
			_magazines = getarray(_class >> "magazines");
			{
				If (!((configfile >> "cfgmagazines" >> _x) in _items)) then {_items set [count _items,(configfile >> "cfgmagazines" >> _x)];};
			}foreach _magazines;
		};
		
		
		
		/*
		
		if (_weaponTypeCategory == "Weapon") then {
			_weaponTypeSpecific = _weaponType select 1;
			_weaponTypeID = switch (true) do {
				case (_weaponTypeSpecific in (_types select ID_RIFLES))  : {ID_RIFLES};
				case (_weaponTypeSpecific in (_types select ID_MG))  : {ID_MG};
				case (_weaponTypeSpecific in (_types select ID_SNIPER))  : {ID_SNIPER};
				case (_weaponTypeSpecific in (_types select ID_WERFER))  : {ID_WERFER};
				case (_weaponTypeSpecific in (_types select ID_PISTOLE))  : {ID_PISTOLE};
				case (_weaponTypeSpecific in (_types select ID_SHOTGUN))  : {ID_SHOTGUN};
				case ((configname _class) in (_types select ID_MEDICAL))  : {ID_MEDICAL};
				default {ID_SONSTIGES};
			};
			_items = (_daten select _weaponTypeID) select 0;
			_items set [count _items, _class];
			/// passende Magazin + vergleich ob schon gelistet
			_items = (_daten select _weaponTypeID) select 1;
			_magazines = getarray(_class >> "magazines");
			{
				If (!((configfile >> "cfgmagazines" >> _x) in _items)) then {_items set [count _items,(configfile >> "cfgmagazines" >> _x)];};
			}foreach _magazines;
		};
		
		
		
		if ((_weaponTypeCategory != "VehicleWeapon")&&(_weaponTypeCategory != "Weapon")) then {
				
			_weaponTypeSpecific = _weaponType select 1;
			_weaponTypeID = switch (true) do {
				case (_weaponTypeSpecific in (_types select ID_ANBAUTEILE))  : {ID_ANBAUTEILE};
				
				case (_weaponTypeSpecific in (_types select ID_FUNKGERAETE))  : {ID_FUNKGERAETE};
				case ((getnumber(_class >> "tf_hasLRradio"))==1)  : {ID_FUNKGERAETE};
				
				case (_weaponTypeSpecific in (_types select ID_RUCKSACK))  : {ID_RUCKSACK};
				case (_weaponTypeSpecific in (_types select ID_WESTE))  : {ID_WESTE};
				case (_weaponTypeSpecific in (_types select ID_UNIFORM))  : {ID_UNIFORM};
				case (_weaponTypeSpecific in (_types select ID_KOPF))  : {ID_KOPF};
				
				case (_weaponTypeSpecific in (_types select ID_NAVIGATION))  : {ID_NAVIGATION};
				case (_weaponTypeSpecific in (_types select ID_MEDICAL))  : {ID_MEDICAL};
				case (call(_isAceMedical)) :  {ID_MEDICAL};
				case (_weaponTypeSpecific in (_types select ID_ITEMS))  : {ID_ITEMS};
				default {ID_SONSTIGES};
			};
			//d_log(FORMAT_1("ID=%1",_weaponTypeID))
			_items = (_daten select _weaponTypeID) select 0;
			_items set [count _items, _class];


		};
		*/
	};
	progressloadingscreen (_foreachindex * _progressStep);
} foreach _configArray;


{
	_weapon = (_types select _x)select 0;
	_items = (_daten select _x) select 0;
	_magazines = [];
	{
		{
		private ["_mag"];
		_mag = _x;
		if ({_x == _mag} count _magazines == 0) then {
			private ["_cfgMag"];
			_magazines set [count _magazines,_mag];
			_cfgMag = configfile >> "cfgmagazines" >> _mag;
				if (getnumber (_cfgMag >> "scope") == 2 || getnumber (_cfgMag >> "scopeArsenal") == 2) then {
					
					_items set [count _items, _cfgMag];
				};
			};
		} foreach getarray (_x >> "magazines");
	} foreach ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
} foreach [ID_GRANATEN,ID_SPRENGSTOFF];





SETMVAR(DORB_CRATE_ITEMS,_daten);
["DORB_CRATE"] call bis_fnc_endLoadingScreen;
/*
d_log(FORMAT_1("Rifles=%1",((DORB_CRATE_ITEMS select ID_RIFLES)select 0)))
d_log(FORMAT_1("Rifles Mag=%1",((DORB_CRATE_ITEMS select ID_RIFLES)select 1)))
d_log(FORMAT_1("MG=%1",((DORB_CRATE_ITEMS select ID_MG)select 0)))
d_log(FORMAT_1("MG Mag=%1",((DORB_CRATE_ITEMS select ID_MG)select 1)))
d_log(FORMAT_1("Sniper=%1",((DORB_CRATE_ITEMS select ID_SNIPER)select 0)))
d_log(FORMAT_1("Sniper Mag=%1",((DORB_CRATE_ITEMS select ID_SNIPER)select 1)))
d_log(FORMAT_1("Werfer=%1",((DORB_CRATE_ITEMS select ID_WERFER)select 0)))
d_log(FORMAT_1("Werfer Mag=%1",((DORB_CRATE_ITEMS select ID_WERFER)select 1)))
d_log(FORMAT_1("Pistole =%1",((DORB_CRATE_ITEMS select ID_PISTOLE)select 0)))
d_log(FORMAT_1("Pistole Mag=%1",((DORB_CRATE_ITEMS select ID_PISTOLE)select 1)))
d_log(FORMAT_1("Shotgun=%1",((DORB_CRATE_ITEMS select ID_SHOTGUN)select 0)))
d_log(FORMAT_1("Shotgun Mag=%1",((DORB_CRATE_ITEMS select ID_SHOTGUN)select 1)))

d_log(FORMAT_1("Anbauteile=%1",((DORB_CRATE_ITEMS select ID_ANBAUTEILE)select 0)))
d_log(FORMAT_1("Granaten=%1",((DORB_CRATE_ITEMS select ID_GRANATEN)select 0)))
d_log(FORMAT_1("Sprengstoff=%1",((DORB_CRATE_ITEMS select ID_SPRENGSTOFF)select 0)))
d_log(FORMAT_1("Rucksack=%1",((DORB_CRATE_ITEMS select ID_RUCKSACK)select 0)))
d_log(FORMAT_1("Weste=%1",((DORB_CRATE_ITEMS select ID_WESTE)select 0)))
d_log(FORMAT_1("Uniform=%1",((DORB_CRATE_ITEMS select ID_UNIFORM)select 0)))
d_log(FORMAT_1("Kopf=%1",((DORB_CRATE_ITEMS select ID_KOPF)select 0)))
d_log(FORMAT_1("Funkgeräte=%1",((DORB_CRATE_ITEMS select ID_FUNKGERAETE)select 0)))
d_log(FORMAT_1("Navigation=%1",((DORB_CRATE_ITEMS select ID_NAVIGATION)select 0)))
d_log(FORMAT_1("Medical=%1",((DORB_CRATE_ITEMS select ID_MEDICAL)select 0)))
d_log(FORMAT_1("Item=%1",((DORB_CRATE_ITEMS select ID_ITEMS)select 0)))
d_log(FORMAT_1("Sonstiges=%1",((DORB_CRATE_ITEMS select ID_SONSTIGES)select 0)))
*/


true