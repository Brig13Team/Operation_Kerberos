/**
 * Author: Dorbedo
 * creates a cas attack
 *
 * Arguments:
 * 0: <ARRAY/OBJECT> the target can be an unit or a position
 * 1: <CODE> callback
 * 2: <ANY> callbackparams
 *
 * Return Value:
 * nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", ["_callback", {}, [{}]], ["_callbackParams", []]];

private _targetPos = [_target] call CBA_fnc_getPos;

private _spawnPos = [
    _target
//    ,3000,1000,4000
] call FUNC(offmap_getsavespawnposair);

_spawnPos set [2,300];
private _dir = _spawnPos getDir _targetPos;
private _attackVehType = selectRandom(["adrones"] call EFUNC(spawn,getUnit));

([_spawnPos, GVARMAIN(side), _attackVehType, _dir, true, true, "FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup", "_attackVeh"];
_attackGroup setVariable [QEGVAR(headquarter,state),"mission"];
TRACEV_5(_spawnPos,_attackVehType,_attackVeh,crew _attackVeh,_attackGroup);
private _targetLogic =  ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", _targetPos, [], 0, "NONE"];
(group _targetLogic) deleteGroupWhenEmpty true;

If !(IS_ARRAY(_target)) then {
    _targetLogic attachTo _target;
};

[_attackgroup] call CBA_fnc_clearWaypoints;
private _wp = _attackgroup addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_attackVeh flyInHeight 300;
_attackVeh doTarget _targetLogic;

private _weapons = [];
{
    private _curWeapon = _x;
    If ((([_curWeapon] call BIS_fnc_itemtype) param [1,""]) == "MissileLauncher") exitWith {
        _weapons = [_curWeapon,_curWeapon];
    };
} forEach (weapons _attackVeh);

[
    {
        (alive (_this select 0))&&
        {((_this select 0) distance (_this select 1))<800}
    },
    LINKFUNC(offmap_casBombStrike),
    [_attackVeh,_targetLogic,_weapons,_callback,_callbackParams,0],
    60*6,
    {
        deleteVehicle (_this select 1);
        [_this select 0] call FUNC(offmap_rtb);
        [false, (_this select 4)] call (_this select 3);
    }
] call CBA_fnc_waitUntilAndExecute;

[_attackVeh,_attackGroup,_spawnpos]
