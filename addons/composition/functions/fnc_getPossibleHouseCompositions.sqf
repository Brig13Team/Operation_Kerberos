#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getPossibleHouseCompositions
  Author: Dorbedo
  returns the possible house compositions

  Arguments:
    0: is Objective <BOOL> (default: false)

  Return Value:
    possible composition configs <LOCATION>

  Public: No
*/

params [["_isobjective", false, [true]]];

private _check = "true";

if (_isObjective) then {
    _check = "getText(_x >> 'type') != ''";
};

private _allCompositions = [];
If (isClass(configFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [configFile >> "CfgKerberos" >> "CfgComposition" >> "houses", _check, true]);
};

If (isClass(missionConfigFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [missionconfigFile >> "CfgKerberos" >> "CfgComposition" >> "houses", _check, true]);
};

private _return = HASH_CREATE;

private _fnc_findHouse = {
    params ["_cfgToCheck"];
    private _Objects = [_cfgToCheck, "Object"] call FUNC(getCfgDataType);
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
            private _house = _cfg call _fnc_findHouse;
            If !(_house isEqualTo "") then {
                If (HASH_HASKEY(_return,_house)) then {
                    HASH_GET(_return,_house) pushBack _x;
                } else {
                    HASH_SET(_return,_house,[_x]);
                };
            };
        };
    };
} forEach _allCompositions;

_return;
