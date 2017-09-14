/*
 *  Author: Dorbedo
 *
 *  Description:
 *      places the doorcharge
 *
 *  Parameter(s):
 *      0 : OBJECT - house
 *      1 : OBJECT - caller
 *      2 : STRING - Animation
 *
 *  Returns:
 *     none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_house","_caller","_door"];
_door = _door select 0;

private _triggerPos = _house selectionPosition (_door + "_trigger");
private _axisPos = _house selectionPosition (_door + "_axis");
private _dir = (_triggerpos getDir _axisPos) + getDir _house;;
private _chargePos = _house modelToWorld _triggerPos;

// TODO: place only one charge on the right side of the door

private _charge = "DemoCharge_Remote_Ammo" createVehicle [0,0,0];
private _charge2 = "DemoCharge_Remote_Ammo" createVehicle [0,0,0];
_charge setDir _dir;
_charge2 setDir _dir;
[_charge, 90,90] call BIS_fnc_setPitchBank;
[_charge2, 90,-90] call BIS_fnc_setPitchBank;

_charge setPos _chargePos;
_charge2 setPos _chargePos;

_house setVariable [format[QGVAR(%1),_door],true,true];

[
    LINKFUNC(handle),
    0,
    [
        _house,
        _door,
        [_charge,_charge2],
        (CBA_missiontime + CHARGE_TIMER)
    ]
] call CBA_fnc_addPerFrameHandler;
