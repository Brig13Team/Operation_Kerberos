/*
 * Author: Dorbedo
 *
 */

#include "script_component.hpp"

CHECK(!ACTIVEMOD_ACRE);

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

[
    QGVAR(syncGear),
    {
        _this params ["_unit"];
        ([_unit] call EFUNC(player,getLoadout)) params ["_loadout","_weaponsarray"];
        If ((local _unit)&&(hasInterface)) then {
            ERROR_WITH_TITLE("Asnycron Gear","Your Gear got asnycron. Trying to syncronize your gear.");
        };
        removeAllWeapons _unit;
        removeAllItemsWithMagazines _unit;
        removeAllAssignedItems _unit;
        removeHeadgear _unit;
        removeGoggles _unit;
        removeAllContainers _unit;
        [

            {_this call EFUNC(player,setLoadout);},
            [_unit,_loadout,_weaponsarray],
            5
        ] call CBA_fnc_waitAndExecute;
    }
] call CBA_fnc_addEventHandler;

[
    {
        If (ACRE_SERVER_GEAR_DESYNCED) then {
            If (ACRE_SERVER_DESYNCED_PLAYERS isEqualTo []) then {
                ACRE_SERVER_GEAR_DESYNCED = false;
                publicVariable "ACRE_SERVER_GEAR_DESYNCED";
            }else{
                private _target = ACRE_SERVER_DESYNCED_PLAYERS deleteAt 0;
                If !(isNull _target) then {
                    [
                        QGVAR(syncGear),
                        [_target],
                        _target
                    ] call CBA_fnc_targetEvent;
                };
            };
        };
    },
    60
] call CBA_fnc_addPerFrameHandler;
