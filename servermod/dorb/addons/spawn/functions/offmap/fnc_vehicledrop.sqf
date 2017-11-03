/**
 * Author: Dorbedo
 * drops a vehicle a the target position
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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", "_vehicletype", ["_callback", {}, [{}]], ["_callbackParams", []]];

private _spawnPos = [_target,3000,1000,4000] call FUNC(offmap_getsavespawnposair);
_spawnPos set [2,800];

If ((getTerrainHeightASL _spawnPos)<0) then {
    _spawnPos set [2, abs (getTerrainHeightASL _spawnPos) + 300];
} else {
    _spawnPos set [2,300];
};

private _dir = _spawnPos getDir _target;
([_spawnPos, GVARMAIN(side), "O_Heli_Transport_04_F", _dir] call EFUNC(spawn,vehicle)) params ["_transportGroup", "_transportVehicle"];

If !(GVARMAIN(side) == east) then {
    [_transportVehicle, "black", false, false] call bis_fnc_initVehicle;
};
_transportGroup setVariable [QEGVAR(headquarter,state),"mission"];
_transportGroup addWaypoint [_target,200];
_transportVehicle doMove _target;
_transportVehicle setpos _spawnpos;
_transportVehicle flyInHeight 300;
_transportVehicle setSpeedMode "FULL";
_transportVehicle setBehaviour "SAFE";
_transportVehicle setCombatMode "GREEN";


([_spawnPos vectorAdd [0, 0, -50], GVARMAIN(side), _vehicletype, _dir] call EFUNC(spawn,vehicle)) params ["_targetGroup", "_targetVehicle"];

{
    _x allowFleeing 0;
    nil;
} count (units _targetGroup);

_targetGroup setVariable [QEGVAR(headquarter,state),"mission"];
_targetVehicle setVariable [QGVAR(oldmass), getMass _targetVehicle];

If ((getMass _targetVehicle)>6000) then {
    _targetVehicle setMass 6000
};
_transportVehicle setSlingLoad _targetVehicle;
_transportVehicle doMove _target;

[
    {
        (_this select 0) params ["_transportGroup", "_targetGroup", "_target", "_transportVehicle", "_targetVehicle", "_timeout", "_callback", "_callbackparams"];

        If ((!(canmove _transportVehicle))||{CBA_missiontime > _timeout}) exitWith {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            {deleteVehicle _x} forEach (crew _transportVehicle);
            {deleteVehicle _x} forEach (crew _targetVehicle);
            deleteGroup _transportGroup;
            deleteGroup _targetGroup;
            deleteVehicle _transportVehicle;
            deleteVehicle _targetVehicle;
        };
        If ((_transportVehicle distance2D _target) > 700) exitWith {};

        [_this select 1] call CBA_fnc_removePerFrameHandler;

        _transportVehicle setSlingLoad objNull;
        [_transportVehicle] call FUNC(offmap_rtb);

        _targetGroup setVariable [QEGVAR(headquarter,state), "combat"];
        _targetVehicle setMass [_targetVehicle getVariable QGVAR(oldmass),0];

        [_targetVehicle] call FUNC(offmap_parachute);
        _callbackparams call _callback;
    },
    10,
    [_transportGroup, _targetGroup, _target, _transportVehicle, _targetVehicle, CBA_missiontime + 18*60, _callback, _callbackparams]
] call CBA_fnc_addPerFrameHandler;

(([_targetGroup] call EFUNC(headquarter,getstrengthAIGroup)) param [0,0])
