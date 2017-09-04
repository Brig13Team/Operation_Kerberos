/**
 * Author: Dorbedo
 * returns the possible compositions
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * <ARRAY> possible composition configs
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _allCompositions = [];
If (isClass(configFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [configFile >> "CfgKerberos" >> "CfgComposition" >> "compositions","true",true]);
};

If (isClass(missionConfigFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [missionconfigFile >> "CfgKerberos" >> "CfgComposition" >> "compositions","true",true]);
};

private _return = [];


private _fnc_allObjectsAreValid = {
    params ["_cfgToCheck"];
    private _Objects = configProperties [_cfgToCheck,"(isClass _x)&&{getText(_x >> 'dataType') == 'Object'}",true];
    ({!(isClass(configFile >> 'CfgVehicles' >> getText(_x >> 'type')))} count _Objects) == 0
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
                _return pushBack _x;
            };
        };
    };
    nil;
} count _allCompositions;

_return;
