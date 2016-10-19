/*
 *  Author: Dorbedo
 *  OriginalAuthor: PabstMirror (ACE3)
 *
 *  Description:
 *      sets up the logging of teamkills
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If !(hasInterface) then {
    [QGVAR(teamkill), {
        _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]]];
        diag_log format["TEAMKILL(%1): %2 | %3  killed by  %4 | %5",diag_frameNo,name _target,group _target,name _shooter,group _shooter];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(teamfire), {
        _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]],["_damage",-1,[0]]];
        diag_log format["TEAMFIRE(%1): %2 | %3  shot by  %4 | %5  Damage=%6",diag_frameNo,name _target,group _target,name _shooter,group _shooter,_damage];
    }] call CBA_fnc_addEventHandler;
}else{
    [QGVAR(teamkill), {
        If (IS_ADMIN_LOGGED) then {
            _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]]];
            diag_log format["TEAMKILL(%1): %2 | %3  killed by  %4 | %5",diag_frameNo,name _target,group _target,name _shooter,group _shooter];
            systemChat format["TEAMKILL(%1): %2 | %3  killed by  %4 | %5",diag_frameNo,name _target,group _target,name _shooter,group _shooter];
        };
    }] call CBA_fnc_addEventHandler;

    [QGVAR(teamfire), {
        If (IS_ADMIN_LOGGED) then {
            _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]],["_damage",-1,[0]]];
            diag_log format["TEAMFIRE(%1): %2 | %3  shot by  %4 | %5  Damage=%6",diag_frameNo,name _target,group _target,name _shooter,group _shooter,_damage];
            systemChat format["TEAMFIRE(%1): %2 | %3  shot by  %4 | %5  Damage=%6",diag_frameNo,name _target,group _target,name _shooter,group _shooter,_damage];
        };
    }] call CBA_fnc_addEventHandler;
};


["CAManBase", "hit", {_this call FUNC(onHit);}] call CBA_fnc_addClassEventHandler;
["CAManBase", "killed", {_this call FUNC(onKilled);}] call CBA_fnc_addClassEventHandler;
