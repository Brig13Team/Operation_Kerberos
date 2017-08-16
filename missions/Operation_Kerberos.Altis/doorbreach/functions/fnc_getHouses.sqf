/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets all Houses with Doors
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - Array with all houses with Doors
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _allHouses = configProperties [(configFile >> "CfgVehicles"), "(isClass _x)&&{((configName _x) isKindOf 'HouseBase')&&{getNumber(_x >> 'scope') > 1}}"];

private _housesWithDoors = [];
// configfile >> "CfgVehicles" >> "Land_i_House_Small_01_V1_F" >> "AnimationSources"
{
    If (isClass (_x >> "AnimationSources" >> "door_1_sound_source")) then {
        _housesWithDoors pushBackUnique (configName _x);
    };
} forEach _allHouses;
_housesWithDoors;
