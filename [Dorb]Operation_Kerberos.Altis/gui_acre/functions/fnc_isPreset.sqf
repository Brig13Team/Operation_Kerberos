/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if a hash is a preset
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_radioHash"];

If (HASH_HASKEY(_radioHash,"isPreset")) exitWith {
    HASH_GET(_radioHash,"isPreset");
};

private _presetName = HASH_GET_DEF(_radioHash,"presetName","");
private _radioType = HASH_GET(_radioHash,"radioType");
private _acrePreset = [_radioType] call acre_api_fnc_getPreset;


If ((_presetName isEqualTo "")||{!(_presetName isEqualTo _acrePreset)}) exitWith {
    HASH_SET(_radioHash,"isPreset",false);
    false;
};


private _channel = HASH_GET(_radioHash,"channel");

private _acrePresetHash = [_radioType,_channel] call FUNC(setFilteredPresetChannel);
private _keysToCheck = HASH_GET(_acrePresetHash,"keysOrdered");


private _temp = {
    private _val1 = HASH_GET(_radioHash,_x);
    private _val2 = HASH_GET(_acrePresetHash,_x);
    !(_val1 isEqualTo _val2);
} count _keysToCheck;
TRACEV_2(_radioType,_temp);
If (_temp > 0) then {
    HASH_SET(_radioHash,"isPreset",false);
    false;
}else{
    HASH_SET(_radioHash,"isPreset",true);
    true;
};
