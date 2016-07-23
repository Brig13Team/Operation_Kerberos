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

If !(isClass(missionConfigFile>>QGVAR(arsenal))) exitWith {};
private _arsenalArray = [[],[],[],[]];
private _blacklist = getArray(missionConfigFile>>QGVAR(arsenal)>>str (GVARMAIN(playerSide))>>"blacklist">>"items");
private _blacklist_magazines = getArray(missionConfigFile>>QGVAR(arsenal)>>str (GVARMAIN(playerSide))>>"blacklist">>"magazines");
private _sideStringBIS = If (GVARMAIN(playerSide) == west) then {"_B_"}else{"_O_"};
private _dlcs = getArray(missionConfigFile>>QGVAR(arsenal)>>str (GVARMAIN(playerSide))>>"dlcs");
private _BISStringblack = getArray(missionConfigFile>>QGVAR(arsenal)>>str (GVARMAIN(playerSide))>>"BISBlack");
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
        if ((_weaponTypeCategory != "VehicleWeapon")) then {
            private _hinzufuegen = true;
            If (_className in _blacklist) then {_hinzufuegen = false;};
            
            If (_hinzufuegen) then {
                _weaponTypeSpecific = _weaponType select 1;
                _weaponTypeID = switch (true) do {
                    case (_weaponTypeSpecific in ["Throw"]) : {2};
                    case (_weaponTypeSpecific in ["Backpack"]) : {0};
                    case (_weaponTypeCategory in ["Weapon"]) : {3};
                    case ((_weaponTypeCategory in [])) : {1};
                    case (_weaponTypeCategory in ["Item","Equipment"]) : {1};
                    case (_weaponTypeCategory in ["Mine"]) : {3};
                    default {-1};
                };
                If (_weaponTypeSpecific in ["Headgear","Vest","Uniform"]) then {
                    If ((getText(_class>>"dlc") isEqualTo "")||{getText(_class>>"dlc") in ["Mark"]}) then {
                        private _namestring = [getText(_class>>"model"),"\"] call CBA_fnc_split;
                        private _namecount = {_x in _BISStringblack} count _namestring;
                        If ( _namecount > 0) then {_weaponTypeID = -1;};
                    }else{
                       private _temp = getText(_class>>"dlc");
                        if !((getText(_class>>"dlc"))in _dlcs) then {_weaponTypeID = -1;};
                    };
                };
                If (_weaponTypeSpecific in ["Backpack"]) then {
                    private _sidenumber = ["west","east"] find (format ["%1",GVARMAIN(playerSide)]);
                    If (getNumber(_class >> "side")== _sidenumber) then {_weaponTypeID = -1;};
                };
                
                If !(_weaponTypeID < 0) then {
                    private _items = (_arsenalArray select _weaponTypeID);
                    _items set [count _items, _className];
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
    };
} foreach _configArray;

{
    private _items = (_arsenalArray select 2);
    private _magazines = [];
    private _weapon = _x;
    {
        {
        private _mag = _x;
        if (!(_mag in _magazines)) then {
            _magazines set [count _magazines,_mag];
            private _scope = if (isnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")) then {
                getnumber (configfile >> "cfgmagazines" >> _mag >> "scopeArsenal")
            } else {
                getnumber (configfile >> "cfgmagazines" >> _mag >> "scope")
            };
            if (_scope > 1) then {
                    _items set [count _items, _mag];
                };
            };
        } foreach getarray (_x >> "magazines");
    } foreach ("isclass _x" configclasses (configfile >> "cfgweapons" >> _weapon));
} foreach ["Put","Throw"];


GVAR(arsenalList) = _arsenalArray;