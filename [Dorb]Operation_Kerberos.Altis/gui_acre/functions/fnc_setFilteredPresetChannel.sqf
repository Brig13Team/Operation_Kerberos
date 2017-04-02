/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Copys a preset from acre into a local hash and adds some specific data
 *
 *  Parameter(s):
 *      0 : STRING - Radio-ID
 *      1 : SCALAR - Channel-ID
 *      2 : STRING - Name of the Preset
 *
 *  Returns:
 *      HASH - the copied hash
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_radioType","",[""]],["_channel",0,[1]],["_presetName","",[""]]];

If (_presetName isEqualTo "") then {
    _presetName = [_radioType] call acre_api_fnc_getPreset;
};

private _acreHash = [_radioType, _presetName, _channel] call acre_api_fnc_getPresetChannelData;
TRACEV_4(_acreHash,_radioType,_presetName,_channel);
private _acreKeys = ((allVariables _acreHash) select {!isNil{_acreHash getVariable _x}});

// order the known keys
private _missionKeysOrderd = _acreKeys arrayIntersect ["description","label","name","frequencyrx","frequencytx","rxonly","ctcssrx","ctcsstx","squelch","modulation","encryption","synclength","power","phase","channelmode","deviation","trafficrate","tek","active","optioncode","fade","rptr"];
// add the unknown keys
{_missionKeysOrderd pushBackUnique _x} forEach _acreKeys;
TRACEV_1(_acreHash);
private _missionHash = LHASH_COPY(_acreHash);
//private _serialized = HASH_SERIALIZE(_missionHash);
//TRACEV_3(allVariables _acreHash,allVariables _missionHash,_serialized);
HASH_SET(_missionHash,"keysOrdered",_missionKeysOrderd);
HASH_SET(_missionHash,"radioType",_radioType);
HASH_SET(_missionHash,"presetName",_presetName);
HASH_SET(_missionHash,"channel",_channel);
If ((toUpper _radioType) in ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"]) then {
    private _key = [(toUpper _radioType),"description"] call acre_api_fnc_mapChannelFieldName;
    TRACEV_2(_key,allVariables _missionHash);
    private _channelName = HASH_GET(_acreHash,_key);
    TRACEV_1(_channelName);
    HASH_SET(_missionHash,"channelName",_channelName);
};
If ((toUpper _radioType) isEqualTo "ACRE_PRC343") then {
    private _channelName = format["B%1-C%2",floor(_channel/16)+1,_channel-floor(_channel/16)*16+1];
    HASH_SET(_missionHash,"channelName",_channelName);
};
TRACEV_2(_channelName,_radioType);
_missionHash;
