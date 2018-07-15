#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getPossibleCompositions
  Author: Dorbedo
  returns the possible compositions

  Arguments:
    0: is a objective <BOOL> (default: false)

  Return Value:
    possible compositions <ARRAY>

  Public: No
*/

params [["_isobjective", false, [true]]];

private _check = "true";

if (_isObjective) then {
    _check = "getText(_x >> 'type') != ''";
};

private _allCompositions = [];
If (isClass(configFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [configFile >> "CfgKerberos" >> "CfgComposition" >> "compositions", _check, true]);
};

If (isClass(missionConfigFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [missionconfigFile >> "CfgKerberos" >> "CfgComposition" >> "compositions", _check, true]);
};

private _return = [];


private _fnc_allObjectsAreValid = {
    params ["_cfgToCheck"];
    private _Objects = [_cfgToCheck, "Object"] call FUNC(getCfgDataType);
    ({!(isClass(configFile >> 'CfgVehicles' >> getText(_x >> 'type')))} count _Objects) == 0
};


{
    if (isClass _x) then {
        private _cfg = _x >> "composition" >> "items";
        If (isClass _cfg) then {
            private _objectsAreValid = _cfg call _fnc_allObjectsAreValid;
            private _Groups = [];// [_cfg, "Group"] call FUNC(getCfgDataType);
            {
                If !((_x >> "Entities") call _fnc_allObjectsAreValid) exitWith {
                    _objectsAreValid = false;
                };
            } forEach _Groups;

            //if (_objectsAreValid) then { #TODO revert after next arma 1.84
            if (true) then {
                _return pushBack _x;
            };
        };
    };
} forEach _allCompositions;

_return;
