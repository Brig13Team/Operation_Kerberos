/**
 * Author: Dorbedo
 * returns the possible house compositions
 *
 * Arguments:
 * 0: <BOOL> isObjective (default: false)
 *
 * Return Value:
 * <LOCATION> possible composition configs
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_isobjective",false,[true]]];

private _target = if (_isObjective) then {
    "missionhouses"
} else {
    "houses"
};

private _allCompositions = [];
If (isClass(configFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [configFile >> "CfgKerberos" >> "CfgComposition" >> _target,"true",true]);
};

If (isClass(missionConfigFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [missionconfigFile >> "CfgKerberos" >> "CfgComposition" >> _target,"true",true]);
};

private _return = HASH_CREATE;


private _fnc_allObjectsAreValid = {
    params ["_cfgToCheck"];
    private _Objects = configProperties [_cfgToCheck,"(isClass _x)&&{getText(_x >> 'dataType') == 'Object'}",true];
    ({!(isClass(configFile >> 'CfgVehicles' >> getText(_x >> 'type')))} count _Objects) == 0
};

private _fnc_findHouse = {
    params ["_cfgToCheck"];
    private _Objects = configProperties [_cfgToCheck,"(isClass _x)&&{getText(_x >> 'dataType') == 'Object'}",true];
    _objects = _objects select {getText(_x >> 'type') isKindOf "HouseBase"};
    If (_objects isEqualTo []) then {
        ""
    } else {
        getText((_objects select 0) >> "type");
    };
};


{
    if (isClass _x) then {
        private _cfg = _x >> "composition" >> "items";
        If (isClass _cfg) then {
            private _objectsAreValid = _cfg call _fnc_allObjectsAreValid;
            private _Groups = configProperties [_cfg,"(isClass _x)&&{getText(_x >> 'dataType') == 'Group'}",true];
            {
                If !((_x >> "Entities") call _fnc_allObjectsAreValid) exitWith {
                    _objectsAreValid = false;
                };
            } forEach _Groups;

            if (_objectsAreValid) then {
                private _house = _cfg call _fnc_findHouse;
                If !(_house isEqualTo "") then {
                    If (HASH_HASKEY(_return,_house)) then {
                        HASH_GET(_return,_house) pushBack _x;
                    } else {
                        HASH_SET(_house,[_x]);
                    };
                };
            };
        };
    };
    nil;
} count _allCompositions;

_return;
