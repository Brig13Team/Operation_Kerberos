/*
 *  Author: Dorbedo
 *
 *  Description:
 *      postInit CLient
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(!hasInterface)
private _allHouses = [] call FUNC(getHouses);
{
    for "_i" from 22 to 0 step -1 do {
        if (isClass (configFile >> "CfgVehicles" >> _x >> "AnimationSources" >> format["Door_%1_sound_Source",_i])) exitWith {
            [_x,_i] call FUNC(addACEActions);
        };
    };
} forEach _allHouses;
