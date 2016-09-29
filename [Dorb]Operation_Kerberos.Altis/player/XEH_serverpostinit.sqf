/*
    Author: Dorbedo

    Description:
        postinit server
*/
#include "script_component.hpp"

GVAR(postInit) = false;
#ifdef DORB_PILOT_WHITELIST_ENABLED
    GVAR(reserved_pilot_slot) = true;
    [QGVAR(pilot_whitelist), "onPlayerConnected", {
        private _userconfig = [] call FUNC(userconfig);
        If (_uid in _userconfig) then {
            _owner publicVariableClient QGVAR(reserved_pilot_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
#endif

/// Teleport
GVARMAIN(key) = format ["Missionkey:%1",random(100000)];
publicVariable QGVARMAIN(missionkeyServer);


/*
 * Teamkill Logging
 *
*/
[
    QGVAR(teamfire),{
        _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]],["_damage",-1,[0]]];
        private _frame = diag_frameNo;
        diag_log format["TEAMFIRE(%4): %1 of team %2 at %3",name _target,group _target,getPos _target,_frame];
        diag_log format["TEAMFIRE(%4): shot by %1 of team %2 at %3",name _shooter,group _shooter,getPos _shooter,_frame];
        diag_log format["TEAMFIRE(%4): Damage=%1 |Weapon=%2 |Vehicle=%3",_damage,currentWeapon _shooter,typeOf (vehicle _shooter),_frame];
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(deadmenswitch),{
        _this params [["_text","",[""]],["_shooter",objNull,[objNull]]];
        diag_log format["DeadManSwitch (%1) - exploding, placed by %2",_text,name _shooter];
    }
] call CBA_fnc_addEventHandler;


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
