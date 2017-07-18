/*
 * Author: Dorbedo
 *
 */

#include "script_component.hpp"

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
    If (_class in (allVariables acre_sys_server_objectIdRelationTable)) then {
        _message = "Assinging existent Radio";
        _oldPlayer = acre_sys_server_objectIdRelationTable getVariable _class;
        LOG_4(_message,_player,_oldPlayer,_class);
    };
}] call CBA_fnc_addEventHandler;

["acre_acknowledgeId",{
    _this params ["_class","_player"];
    private _message = "player got new unique Radio";
    LOG_3(_message,_player,_class);
}] call CBA_fnc_addEventHandler;
