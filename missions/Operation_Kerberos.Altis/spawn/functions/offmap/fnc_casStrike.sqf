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

params ["_vehicle", "_target", "_weapons", "_callback", "_callbackparams", "_attackPosIntervall"];

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
    _attackarray pushBack [_x, _targetPos getPos [_attackPosIntervall * (_switch + _forEachIndex), _dir]];
} forEach _weapons;



#define SHOOTINGINTERVALL 0.15
#define VEHICLESPEED (300/3.6)

private _planepos = (getPos _vehicle);
private _vectorDir = [_planepos,_targetPos getPos [_attackPosIntervall * _switch, _dir]] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir, VEHICLESPEED] call bis_fnc_vectorMultiply;
private _vectorUp = vectorup _vehicle;

TRACEV_5(_weapons,_planepos,_velocity,_vectorDir,_vectorUp);

_vehicle setVelocityTransformation [
    _planepos, //(_vehicle getPos [(VEHICLESPEED * SHOOTINGINTERVALL), getDir _vehicle]) vectorAdd [0,0,(_planepos select 2)],
    _planepos vectoradd (_velocity vectorMultiply SHOOTINGINTERVALL),
    _velocity, _velocity,
    vectorDir _vehicle, _vectorDir,
    vectorUp _vehicle, _vectorUp,
    SHOOTINGINTERVALL
];

[
    {
        (_this select 0) params ["_vehicle", "_attackarray"];
        If ((!(alive _vehicle))||{(count _attackarray)<1}) exitWith {
            (_this select 1) call CBA_fnc_removePerFrameHandler;
        };
        (_attackarray deleteAt 0) params ["_weapon","_attackpos"];
        private _lasertarget = createVehicle ["LaserTargetC", _attackpos, [], 0, "none"];
        private _planepos = (getPos _vehicle);
        private _vectorDir = [_planepos,_attackpos] call bis_fnc_vectorFromXtoY;
        private _velocity = [_vectorDir, VEHICLESPEED] call bis_fnc_vectorMultiply;
        private _vectorUp = vectorup _vehicle;

        _vehicle setVelocityTransformation [
            _planepos, //(_vehicle getPos [(VEHICLESPEED * SHOOTINGINTERVALL), getDir _vehicle]) vectorAdd [0,0,(_planepos select 2)],
            _planepos vectoradd (_velocity vectorMultiply SHOOTINGINTERVALL),
            _velocity, _velocity,
            _vectorDir, _vectorDir,
            _vectorDir, _vectorUp,
            SHOOTINGINTERVALL
        ];
        _vehicle fireAtTarget [_lasertarget, _weapon];
        [{deleteVehicle _this}, _lasertarget, 3] call CBA_fnc_waitAndExecute;
        [_vehicle] call FUNC(offmap_rtb);
    },
    SHOOTINGINTERVALL,
    [_vehicle, _attackarray]
] call CBA_fnc_addPerFrameHandler;

