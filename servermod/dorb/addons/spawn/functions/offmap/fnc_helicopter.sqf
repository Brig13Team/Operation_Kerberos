/**
 * Author: Dorbedo
 * attack-chopper call-in
 *
 * Arguments:
 * 0: <ARRAY> the target
 * 1: <CODE> callback
 * 2: <ANY> callbackparams
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", ["_callback", {}, [{}]], ["_callbackParams", []]];


private _targetPos = [_target] call CBA_fnc_getPos;

private _spawnPos = [
    _target
//    ,3000,1000,4000
] call FUNC(offmap_getsavespawnposair);

If ((getTerrainHeightASL _spawnPos)<0) then {
    _spawnPos set [2, abs (getTerrainHeightASL _spawnPos) + 100];
} else {
    _spawnPos set [2,100];
};
private _dir = _spawnPos getDir _targetPos;
private _attackVehType = ["helicopter"] call EFUNC(spawn,getUnit);

([_spawnPos, GVARMAIN(side), _attackVehType, _dir, true, true, "FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup", "_attackVeh"];
_attackGroup setVariable [QEGVAR(headquarter,state),"mission"];
(driver _attackVeh) setSkill 0.9;

_targetPos set [2,100];
private _wp = _attackGroup addWaypoint [_targetPos, 200];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";

[
    {
        [_this select 0] call FUNC(offmap_rtb);
        [false, (_this select 2)] call (_this select 1);
    },
    [_attackVeh,_callback,_callbackParams],
    60*15
] call CBA_fnc_waitAndExecute;

[_attackVeh,_attackGroup,_spawnpos]
