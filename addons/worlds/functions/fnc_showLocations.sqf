/*
 *  Author: Dorbedo
 *
 *  Description:
 *      marks the locations
 *
 *  Parameter(s):
 *      0 : LOCATION - the hash with the locations
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_hash"];
[] call EFUNC(common,debug_marker_clean);
{
    private _locationname = _x;
    private _position = getArray(configFile >> "CfgWorlds" >> worldName >> "Names" >> _locationName >> "position");
    private _text = getText(configFile >> "CfgWorlds" >> worldName >> "Names" >> _locationName >> "name");
    private _temp = HASH_GET(_hash,_locationName);
    private _type = HASH_GET(_temp,"classification");
    switch (_type) do {
        case "city" : {
            [_position,_text,"ColorCIV","mil_flag"] call EFUNC(common,debug_marker_create);
        };
        case "water" : {
            [_position,_text,"ColorBlue","mil_flag"] call EFUNC(common,debug_marker_create);
        };
        case "military" : {
            [_position,_text,"ColorOrange","mil_flag"] call EFUNC(common,debug_marker_create);
        };
        case "industry" : {
            [_position,_text,"ColorYellow","mil_flag"] call EFUNC(common,debug_marker_create);
        };
        case "other" : {
            [_position,_text,"ColorRed","mil_flag"] call EFUNC(common,debug_marker_create);
        };
    };
} forEach HASH_KEYS(_hash);
