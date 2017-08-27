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

#include "script_component.hpp"

private _allCompositions = configProperties [missionConfigFile >> QGVAR(config),"true",true];
private _return = [];

{
    private _cfg = x >> "composition" >> "items" >> "Item0" >> "Entities";
    If (isClass _cfg) then {
        private _items = configProperties [_cfg,"true",true];
        If (({
                !(isClass(configFile >> "CfgVehicles" >> "compositions" >> (getText (_x >> "type"))))&&
                {isClass(configFile >> "CfgVehicles" >> "compositions" >> (getText (_x >> "type")))}
            } count _items)==0) then {
            _return pushBack _x;
        };
    };
} count _allCompositions;

_return;
