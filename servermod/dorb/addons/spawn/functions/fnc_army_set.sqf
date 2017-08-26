/**
 * Author: Dorbedo
 * choose a army
 *
 * Arguments:
 * 0: <STRING> possiblity to choose a specific type
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// to prevent some bugs
if (isNil QGVARMAIN(side)) then {
    GVARMAIN(side) = switch (GVARMAIN(playerside)) do {
        case "east" : {"west"};
        default {"east"};
    };
};

params [["_armytype","",[]]];

// filter for CfgPatches
private _allArmys = configProperties [(ConfigFile >> "CfgKerberos" >> QGVAR(unitlists) >> str GVARMAIN(side)),"( ({!(isClass(configFile >> 'CfgPatches' >> _x))} count getArray(_x >> 'CfgPatches'))==0 )",true];

private _error = false;
// camocheck
if ((!_error)&&{GVAR(camouflage)>0}) then {
    _allArmys = _allArmys select {(getNumber (_x >> "camouflage")) == 0};
    if (_allArmys isEqualTo []) then {
        ERROR("No possible Camoflaged army found - turning off camocheck");
        GVAR(camouflage) = 0;
        _error = true;
    };
};

// check if a whitelist is given
If ((!_error)&&{(!(GVAR(armysWhitelist) isEqualTo []))||(!(GVAR(armysBlacklist) isEqualTo []))}) then {
    _allArmys = _allArmys select {
        ((configName _x) in GVAR(armysWhitelist))&&
        (!((configName _x) in GVAR(armysBlacklist)))
    };
    if (_allArmys isEqualTo []) then {
        ERROR("No army found inside the white/blacklist - deleting white/blacklist");
        GVAR(armysWhitelist) = [];
        GVAR(armysBlacklist) = [];
        _error = true;
    };
};


// check if a type was given
If ((!_error)&&{!(_armyType isEqualTo "")}) then {
    _armyType = toLower _armytype;
    _allArmys = _allArmys select {_armyType in ((getArray (_x >> "armytypes"))apply {toLower _x})};
    if (_allArmys isEqualTo []) then {
        ERROR(FORMAT_1("No possible army with given type found: %1",_armytype));
        _armyType = "";
        _error = true;
    };
};

If (_error) exitWith {
    [_armyType] call FUNC(army_set);
};

_allArmys = _allArmys apply {configName _x};
private _army = selectRandom _allArmys;
GVARMAIN(side_type) = _army;
_army
