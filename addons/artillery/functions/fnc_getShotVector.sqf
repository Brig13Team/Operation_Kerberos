/**
 * Author: Dorbedo
 * returns the shotvector of a artillery
 *
 * Arguments:
 * 0: <OBJECT> the artillery
 * 1: <OBJECT> the target
 * 2: <SCALAR> muzzlespeed
 * 3: <BOOL> shoot in an high angle
 *
 * Return Value:
 * <ARRAY> the shotvector
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_artillery","_target","_muzzleSpeed",["_HighAngle",true,[false]]];

If (IS_OBJECT(_artillery)) then {_artillery = getPosASL _artillery};
If (IS_OBJECT(_target)) then {_target = getPosASL _target};

private _distance = _target distance _artillery;
private _altitude = (_artillery select 2) - (_target select 2);

private _gravity = 9.81;
If (_muzzleSpeed^4-_gravity*(_gravity*_distance^2+2*_altitude*_muzzleSpeed^2) < 0) exitWith {[]};
private "_angle";
TRACEV_7(_artillery,_target,_muzzleSpeed,_HighAngle,_gravity,_distance,_altitude);
If (_HighAngle) then {
    _angle = atan((_muzzleSpeed^2+sqrt(_muzzleSpeed^4-_gravity*(_gravity*_distance^2+2*_altitude*_muzzleSpeed^2)))/(_gravity*_distance));
}else{
    _angle = atan((_muzzleSpeed^2-sqrt(_muzzleSpeed^4+_gravity*(_gravity*_distance^2+2*_altitude*_muzzleSpeed^2)))/(_gravity*_distance));
};

private _target = [0,0,0] getPos [_distance, _artillery getDir _target];
TRACEV_1(_angle);
If !((tan _angle) isEqualTo 0) then {
    _target set [2,_distance / (tan _angle)];
};
_target;
