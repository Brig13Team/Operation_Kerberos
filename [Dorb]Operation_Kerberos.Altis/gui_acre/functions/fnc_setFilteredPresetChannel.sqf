/*
 *  Author: DOrbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_radioType","",[""]],["_presetName","default",[""]],["channel",1,[1]]];

private _acreHash = [_radioType, _presetName, _channel] call acre_api_fnc_getPresetChannelData;

private _acreKeys = ((allVariables _acreHash) select {!isNil{_acreHash getVariable _x}});

// order the known keys
private _missionKeysOrderd = _acreKeys arrayIntersect ["description","label","name","frequencyrx","frequencytx","rxonly","ctcssrx","ctcsstx","squelch","modulation","encryption","synclength","power","phase","channelmode","deviation","trafficrate","tek","active","optioncode","fade","rptr"];
// add the unknown keys
{_missionKeysOrderd pushBackUnique _x} forEach _acreKeys;

private _missionHash = HASH_COPY(_acreHash);
HASH_SET(_missionHash,"keysOrdered",_missionKeysOrderd);
_missionHash;
