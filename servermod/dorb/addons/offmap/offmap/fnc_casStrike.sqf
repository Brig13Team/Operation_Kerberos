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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_vehicle", "_target", "_weapons", "_callback", "_callbackparams", "_attackPosIntervall"];

If !(alive _vehicle) exitWith {
    deleteVehicle _vehicle;
    [false, _callbackparams] call _callback;
};

private _targetPos = _target call CBA_fnc_getPos;
private _attackarray = [];
private _dir = getDir _vehicle;


private _switch = - (ceil ((count _weapons)/2));

{
    private _newPos = _targetPos getPos [_attackPosIntervall * (_switch + _forEachIndex), _dir];
    _newPos set [2,0];
    _attackarray pushBack [_x, AGLToASL _newPos];
} forEach _weapons;

#define SHOOTINGINTERVALL 0.15
#define VEHICLESPEED (300/3.6)

private _planepos = (getPosASL _vehicle);
private _vectorDir = [_planepos,_targetPos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir, VEHICLESPEED] call bis_fnc_vectorMultiply;
private _distance = _planepos distance2D _targetPos;
private _alt = (_planepos select 2) - (_targetPos select 2);
[_vehicle,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorup _vehicle;

TRACEV_5(_weapons,_planepos,_velocity,_vectorDir,_vectorUp);

_vehicle setVelocityTransformation [
    _planepos, //(_vehicle getPos [(VEHICLESPEED * SHOOTINGINTERVALL), getDir _vehicle]) vectorAdd [0,0,(_planepos select 2)],
    (_planepos vectoradd (_velocity vectorMultiply SHOOTINGINTERVALL)),
    _velocity, _velocity,
    _vectorDir, _vectorDir,
    _vectorUp, _vectorUp,
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
            (_planepos vectoradd (_velocity vectorMultiply SHOOTINGINTERVALL)),
            _velocity, _velocity,
            _vectorDir, _vectorDir,
            _vectorDir, _vectorUp,
            SHOOTINGINTERVALL
        ];
        _vehicle fireAtTarget [_lasertarget, _weapon];
        [{deleteVehicle _this}, _lasertarget, 10] call CBA_fnc_waitAndExecute;
        [FUNC(offmap_rtb),[_vehicle],4] call CBA_fnc_waitAndExecute;
    },
    SHOOTINGINTERVALL,
    [_vehicle, _attackarray]
] call CBA_fnc_addPerFrameHandler;

