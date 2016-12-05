/*
    Author: Dorbedo

    Description:
        postinit server
*/
#include "script_component.hpp"

CHECK(!isServer)

GVAR(postInit) = false;
#ifdef DORB_PILOT_WHITELIST_ENABLED
    GVAR(reserved_pilot_slot) = true;
    /*
    [QGVAR(pilot_whitelist), "onPlayerConnected", {
        private _userconfig = [] call FUNC(userconfig);
        If (_uid in _userconfig) then {
            _owner publicVariableClient QGVAR(reserved_pilot_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
    */
    IS_WHITELISTED(_uid)
    [QGVAR(pilot_whitelist), "onPlayerConnected", {
        ["insertOrUpdatePlayerInfo",_uid,_name] call DB_SEND;
        private _return = ["isPlayerWhitelisted",_uid] call DB_GETSINGLE;
        If (IS_ARRAY(_return) && {_return select 0}) then {
            _owner publicVariableClient QGVAR(reserved_pilot_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
#endif

/// Teleport
GVARMAIN(key) = format ["Missionkey:%1",random(100000)];
publicVariable QGVARMAIN(missionkeyServer);

/*
 * Curator
 *
*/
[
    QGVAR(curator),
    {
        _this params ["_targetPlayer","_doAssign"];
        If (_doAssign) then {
            If ((count allCurators)==0) exitWith {};
            private _unassignedCurator = {If (isNull(getAssignedCuratorUnit _x)) exitWith {_x};objNull;}forEach allCurators;
            If (isNull _unassignedCurator) then {
                _targetPlayer assignCurator (allCurators select 0);
            }else{
                _targetPlayer assignCurator _unassignedCurator;
            };
            LOG_2(_targetPlayer,_unassignedCurator);
        }else{
            unassignCurator (getAssignedCuratorLogic _targetPlayer);
        };
    }
] call CBA_fnc_addEventHandler;

GVAR(postInit) = true;
