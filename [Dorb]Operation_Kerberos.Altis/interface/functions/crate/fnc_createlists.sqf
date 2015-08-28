/*
    Author: Dorbedo

    Description:
        Creates the configlists of the Items for cratespawner

*/
#include "script_component.hpp"
SCRIPT(crate_createlists);
private ["_daten","_types","_isAceMedical","_configArray","_cfgPatches","_progressStep","_step1"];
_daten = GETMVAR(GVAR(crate_items),[]);

If (!(_daten isEqualTo [])) exitwith {false};

#define ID_RIFLES       0   // Sturmgewehre
#define ID_MG               1   // Maschinengewehre
#define ID_SNIPER           2   // Scharfschützengewehre
#define ID_SHOTGUN      3   // Restliche Waffen

#define ID_WERFER       4   // Werfer (AT, AA)
#define ID_PISTOLE      5   // Sekundärbewaffnung

#define ID_ANBAUTEILE       6   // Optiken, Laser, Lampen, Schalldämpfer

#define ID_GRANATEN         7   // Granaten, Leuchtstäbe, Rauch
#define ID_SPRENGSTOFF  8   // Minen, Sprengladungen

#define ID_RUCKSACK         9   // Rucksack (Ohne Funken)
#define ID_WESTE            10  // Westen
#define ID_UNIFORM      11  // Uniformen
#define ID_KOPF             12  // Helme, Mützen, Brillen

#define ID_FUNKGERAETE      13  // Standartfunken + TFR
#define ID_NAVIGATION       14  // Karte, Kompass, GPS, Ferngläser, Uhren, NSVs

#define ID_MEDICAL      15  // Medicgedöns
#define ID_ITEMS            16  // Inventaritems
#define ID_SONSTIGES        17  // Der Rest - soll leer werden

//// _daten = [     [   [Items] ,   [Munition, nur bei Waffen]  ]   ,   ID_MG   ,   ...     ,   [   [Funken],   []  ]   ,   ...     ];

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

_isAceMedical = {
        Private["_namearr"];
        _namearr = (gettext(_class >> "picture")) splitString "\";
        If ("medical" in _namearr) then {true} else {false};
    };

_daten=[];
for "_i" from 0 to 17 do {
    _daten pushback [[],[]];
};

["DORB_CRATE"] call bis_fnc_startloadingscreen;

_configArray = (
                ("isclass _x" configclasses (configfile >> "cfgweapons")) +
                ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
                ("isclass _x" configclasses (configfile >> "cfgglasses"))
            );
_cfgPatches = "(
                (!((getArray (_x >> 'magazines'))isEqualTo [])) ||
                (!((getArray (_x >> 'units'))isEqualTo [])) ||
                (!((getArray (_x >> 'weapons'))isEqualTo []))
            )" configClasses (configFile >> "CfgPatches");

_progressStep = 1 / (count _configArray + count _cfgPatches);
_step1 = (count _configArray);

{
    private["_class","_className","_scope","_isBase"];
    _class = _x;
    _className = configname _x;
    _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    _isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true}; //-- Check if base weapon (true for all entity types)
    if (_scope == 2 && {gettext (_class >> "model") != ""} && _isBase && {gettext (_class >> "displayName") != ""}) then {
        private ["_weaponType","_weaponTypeCategory","_weaponTypeID","_weaponTypeSpecific","_items","_magazines"];
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
    };
    progressloadingscreen (_foreachindex * _progressStep);
} foreach _configArray;

{
    private["_weapon","_items","_magazines"];
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

private "_patches";
_patches=[];
{
    private["_configname","_namearr"];
    _configname = configname _x;
    _namearr = _configname splitString "_";
    If (!((_namearr select 0) in ["A3","A3Data","a3"])) then {_patches pushback _x;};
    progressloadingscreen ((_foreachindex + _step1) * _progressStep);
}foreach _cfgPatches;

SETMVAR(GVAR(crate_patches),_patches);
SETMVAR(GVAR(crate_items),_daten);
["DORB_CRATE"] call bis_fnc_endLoadingScreen;
true