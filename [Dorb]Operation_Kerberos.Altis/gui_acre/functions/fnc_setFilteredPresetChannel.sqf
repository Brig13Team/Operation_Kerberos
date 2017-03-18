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

_this params [["_radioType","",[""]],["_channel",1,[1]],["_presetName","",[""]]];

If (_presetName isEqualTo "") then {
    _presetName = [_radioType] call acre_api_fnc_getPreset;
};

private _acreHash = [_radioType, _presetName, _channel] call acre_api_fnc_getPresetChannelData;

private _acreKeys = ((allVariables _acreHash) select {!isNil{_acreHash getVariable _x}});

// order the known keys
private _missionKeysOrderd = _acreKeys arrayIntersect ["description","label","name","frequencyrx","frequencytx","rxonly","ctcssrx","ctcsstx","squelch","modulation","encryption","synclength","power","phase","channelmode","deviation","trafficrate","tek","active","optioncode","fade","rptr"];
// add the unknown keys
{_missionKeysOrderd pushBackUnique _x} forEach _acreKeys;

private _missionHash = LHASH_COPY(_acreHash);

HASH_SET(_missionHash,"keysOrdered",_missionKeysOrderd);
HASH_SET(_missionHash,"radioType",_radioType);
HASH_SET(_missionHash,"presetName",_presetName);
HASH_SET(_missionHash,"channel",_channel);
If (_radioType in ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"]) then {
    private _key = [_radioType,"description"] call acre_api_fnc_mapChannelFieldName;
    private _channelName = HASH_GET(_missionHash,_key);
    HASH_SET(_missionHash,"channelName",_channelName);
};
If (_radioType isEqualTo "ACRE_PRC343") then {
    private _channelName = format["B%1-C%2",floor(_channel/16)+1,_channel-floor(_channel/16)*16+1];
    HASH_SET(_missionHash,"channelName",_channelName);
};

_missionHash;
