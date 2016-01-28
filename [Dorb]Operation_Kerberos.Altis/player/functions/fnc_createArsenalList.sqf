/*
    Author: Dorbedo
    
    Description:
        creates the arsenallist
        
    Parameter(s):
        none
        
    Return
        none
*/
#include "script_component.hpp"
SCRIPT(createArsenalList);
CHECK(!(local _this))

If !(isClass(missionConfigFile>>QGVAR(arsenal))) exitWith {};
private _arsenalArray = [[],[],[],[]];

private _blacklist = getArray(missionConfigFile>>QGVAR(arsenal)>>"blacklist">>"items");
private _blacklist_magazines = getArray(missionConfigFile>>QGVAR(arsenal)>>"blacklist">>"magazines");


private _configArray = (
                ("isclass _x" configclasses (configfile >> "cfgweapons")) +
                ("isclass _x && (getText(_x >> 'vehicleClass')=='Backpacks')" configclasses (configfile >> "cfgvehicles")) +
                ("isclass _x" configclasses (configfile >> "cfgglasses"))
            );
private _arsenalArray = [[],[],[],[]];

{
    private _class = _x;
    private _className = configname _x;
    private _scope = if (isnumber (_class >> "scopeArsenal")) then {getnumber (_class >> "scopeArsenal")} else {getnumber (_class >> "scope")};
    private _isBase = if (isarray (_x >> "muzzles")) then {(_className call bis_fnc_baseWeapon == _className)} else {true};
    if (_scope == 2 && {gettext (_class >> "model") != ""} && _isBase && {gettext (_class >> "displayName") != ""}&&{!(_class in _blacklist)}) then {
        private ["_weaponType","_weaponTypeCategory","_weaponTypeID","_weaponTypeSpecific","_items","_magazines"];
        private _weaponType = (_className call bis_fnc_itemType);
        private _weaponTypeCategory = _weaponType select 0;
        if (_weaponTypeCategory != "VehicleWeapon") then {
			_hinzufuegen = false;

			If (isClass (configFile >> "CfgGlasses" >> _className)) then {_hinzufuegen = true;};
			
			If (_hinzufuegen) then {
				_weaponTypeSpecific = _weaponType select 1;
				_weaponTypeID = switch (true) do {
					case (_weaponTypeSpecific in ["Throw"]) : {2};
					case (_weaponTypeSpecific in ["Backpack"]) : {0};
					case (_weaponTypeCategory in ["Weapon"]) : {3};
					case (_weaponTypeCategory in ["Item","Equipment"]) : {1};
					case (_weaponTypeCategory in ["Mine"]) : {3};
				};
				TRACEV_2(_className,_weaponTypeID);
				private _items = (_arsenalArray select _weaponTypeID);
				_items set [count _items, _className];
				/// passende Magazin + vergleich ob schon gelistet
				_items = (_arsenalArray select 2);
				private _magazines = getarray(_class >> "magazines");
				{
					If ((!(_x in _blacklist_magazines))&&{!(_x in _items)}) then {
						_items set [count _items,_x];
					};
				}foreach _magazines;
			};
        };
    };
} foreach _configArray;

private _back = _arsenalArray select 0;
private _item = _arsenalArray select 1;
private _magazine = _arsenalArray select 2;
private _weapons = _arsenalArray select 3;
TRACEV_4(_back,_item,_magazine,_weapons);


[_arsenalObject,_arsenalArray select 0,false,true] call BIS_fnc_addVirtualBackpackCargo;
[_arsenalObject,_arsenalArray select 1,false,true] call BIS_fnc_addVirtualItemCargo;
[_arsenalObject,_arsenalArray select 2,false,true] call BIS_fnc_addVirtualMagazineCargo;
[_arsenalObject,_arsenalArray select 3,false,true] call BIS_fnc_addVirtualWeaponCargo;


