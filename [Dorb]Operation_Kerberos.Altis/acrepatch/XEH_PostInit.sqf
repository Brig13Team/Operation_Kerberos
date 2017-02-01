/*
 * Author: Dorbedo
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"
private _interference = ["acre_sys_core_interference",true,false,"client"] call CBA_Settings_fnc_set;
// Full duplex
private _fullDuplex = ["acre_sys_core_fullDuplex",true,false,"client"] call CBA_Settings_fnc_set;
// Antena direction
private _ignoreAntennaDirection = ["acre_sys_core_ignoreAntennaDirection",true,false,"client"] call CBA_Settings_fnc_set;
// Terrain loss
private _terrainLoss = ["acre_sys_core_terrainLoss",0.5,false,"client"] call CBA_Settings_fnc_set;
// Reveal to AI
private _revealToAI = ["acre_sys_core_revealToAI",true,false,"client"] call CBA_Settings_fnc_set;
LOG_5(_interference,_fullDuplex,_ignoreAntennaDirection,_terrainLoss,_revealToAI);

#include "ChannelNames.sqf"

["acre_getRadioId",{
    _this params ["_player","_radio"];
    private _message = "Requesting new Radio";
    LOG_3(_message,_player,_radio);
}] call CBA_fnc_addEventHandler;

["acre_sys_radio_returnRadioId",{
    _this params["_player", "_class", "_returnIdNumber", "_replacementId"];
    private _message = "Assigning new Radio";
    private _isLocal = local _player;
    If (_isLocal) then {
        _position = getPosATL _player;
        LOG_7(_message,_player,_isLocal,_class,_returnIdNumber,_replacementId,_position);
    }else{
        LOG_6(_message,_player,_isLocal,_class,_returnIdNumber,_replacementId);
    };
    If (!(isNil {acre_sys_server_objectIdRelationTable getVariable _class})) then {
        _message = "Assinging existent Radio";
        _oldPlayer = acre_sys_server_objectIdRelationTable getVariable _class;
        _allRadios =  (acre_sys_server_objectIdRelationTable call acre_lib_fnc_fastHashKeys);
        LOG_5(_message,_player,_oldPlayer,_class,_allRadios);
    };
    LOG_2(acre_sys_server_radioIDMap,acre_sys_server_masterIdList);
}] call CBA_fnc_addEventHandler;

["acre_acknowledgeId",{
    _this params ["_class","_player"];
    private _message = "player got new unique Radio";
    LOG_3(_message,_player,_class);
}] call CBA_fnc_addEventHandler;

/*
// Interference
["acre_sys_core_interference",true,true,"mission"] call CBA_Settings_fnc_set;
// Full duplex
["acre_sys_core_fullDuplex",true,true,"mission"] call CBA_Settings_fnc_set;
// Antena direction
["acre_sys_core_ignoreAntennaDirection",true,true,"mission"] call CBA_Settings_fnc_set;
// Terrain loss
["acre_sys_core_terrainLoss",0.5,true,"mission"] call CBA_Settings_fnc_set;
// Reveal to AI
["acre_sys_core_revealToAI",true,true,"mission"] call CBA_Settings_fnc_set;
*/
#include "MissionSettings_basic.sqf"
