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
    [QGVAR(teamfire), {
        params [["_target", objNull, [objNull]], ["_shooter", objNull, [objNull]], ["_damage", -1, [0]]];
        If ((isNull _target)||{isNull _shooter}) exitWith {};
        private _msg = If (_shooter in allUnitsUAV) then {
            private _drone = _shooter;
            _shooter = ((UAVControl (vehicle (leader _group))) select 0);
            format['[MissionFile] (COMPONENT) TEAMKILL(%1):%2', diag_frameNo, endl]
            + format['              %1 of team %2 at %3%4', name _target, group _target, getPos _target, endl]
            + format['              shot by %1 of team %2 with drone at %3%4', name _shooter, group _shooter, getPos _drone, endl]
            + format['              Damage=%1 |Weapon=%2 |Vehicle=%3', _damage, currentWeapon _shooter, typeOf (vehicle _drone)];
        } else {
            format['[MissionFile] (COMPONENT) TEAMKILL(%1):%2', diag_frameNo, endl]
            + format['              %1 of team %2 at %3%4', name _target, group _target, getPos _target, endl]
            + format['              shot by %1 of team %2 at %3%4', name _shooter, group _shooter, getPos _shooter, endl]
            + format['              Damage=%1 |Weapon=%2 |Vehicle=%3',  _damage,  currentWeapon _shooter,  typeOf (vehicle _shooter)];
        };
        diag_log _msg;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(deadmenswitch), {
        params [["_text", "", [""]], ["_shooter", objNull, [objNull]]];
        diag_log format["[MissionFile] (COMPONENT) DeadManSwitch(%1) - exploding, placed by %2", _text, name _shooter];
    }] call CBA_fnc_addEventHandler;

    ["ace_unconscious", {
        params ["_unit", "_isUnconscious"];
        if ((!_isUnconscious)||{!(isPlayer _unit)}||{!local _unit}) exitWith {};
        If !((player getVariable ["ACE_explosives_deadmanInvExplosive", ""])isEqualTo "") then {
            [QGVAR(deadmenswitch), ["inInventory", _unit]] call CBA_fnc_globalEvent;
        };
        If !(([player, "DeadManSwitch"] call ACE_Explosives_fnc_getPlacedExplosives)isEqualTo []) then {
            [QGVAR(deadmenswitch), ["placed", _unit]] call CBA_fnc_globalEvent;
        };
    }] call CBA_fnc_addEventHandler;

} else {

    [QGVAR(deadmenswitch), {
        if ((call BIS_fnc_admin)>1) then {
            params [["_text", "", [""]], ["_shooter", objNull, [objNull]]];
            systemchat format["DeadManSwitch (%1) - exploding, placed by %2", _text, name _shooter];
        };
    }] call CBA_fnc_addEventHandler;
    [QGVAR(teamfire), {
        if ((call BIS_fnc_admin)>1) then {
            params [["_target", objNull, [objNull]], ["_shooter", objNull, [objNull]], ["_damage", -1, [0]]];
            systemchat format["Teambeschuss: %1 / %2 shot by %3 / %4   Damage=%5", _target, name _target, _shooter, name _shooter, _damage];
        };
    }] call CBA_fnc_addEventHandler;

};
