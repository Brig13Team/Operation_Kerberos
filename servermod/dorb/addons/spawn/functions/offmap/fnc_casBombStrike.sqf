/**
 * Author: Dorbedo
 * executes the strike
 *
 * Arguments:
 * 0: <TYPENAME> argument name
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_vehicle", "_target", "_weapons", "_callback", "_callbackparams", "_attackPosIntervall", ["_shootingintervall", 0.15, [0]]];
TRACEV_1(_this);
If !(alive _vehicle) exitWith {
    deleteVehicle _vehicle;
    [false, _callbackparams] call _callback;
};
/*
[
    {
        deleteVehicle (_this select 1);
        [_this select 0] call FUNC(offmap_rtb);
        (_this select 3) call (_this select 2);
    },
    [_vehicle, _target, _callback, _callbackparams],
    20
] call CBA_fnc_waitAndExecute;
*/


private _targetPos = _target call CBA_fnc_getPos;
private _attackarray = [];
private _dir = getDir _vehicle;


private _switch = - (ceil ((count _weapons)/2));

{
    private _newPos = _targetPos getPos [_attackPosIntervall * (_switch + _forEachIndex), _dir];
    _newPos set [2,0];
    _attackarray pushBack [_x,_newPos];
} forEach _weapons;

TRACEV_2(_weapons,_attackarray);


[
    {
        (_this select 0) params ["_vehicle", "_attackarray"];
        If ((!(alive _vehicle))||{(count _attackarray)<1}) exitWith {
            (_this select 1) call CBA_fnc_removePerFrameHandler;
        };
        (_attackarray deleteAt 0) params ["_weapon","_attackpos"];
        private _lasertarget = createVehicle ["LaserTargetC", _attackpos, [], 0, "none"];

        _vehicle fireAtTarget [_lasertarget, _weapon];
        [{deleteVehicle _this}, _lasertarget, 10] call CBA_fnc_waitAndExecute;
        [FUNC(offmap_rtb),[_vehicle],4] call CBA_fnc_waitAndExecute;
    },
    _shootingintervall,
    [_vehicle, _attackarray]
] call CBA_fnc_addPerFrameHandler;

