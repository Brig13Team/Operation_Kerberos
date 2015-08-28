/*
	Author: Dorbedo
	
	Description:
		gets the impact point
	
	Parameter(s):
		0 : STRING - Ammotype
	
*/
#include "script_component.hpp"
SCRIPT(hud_getimpact);

#define ITERATIONS 400
#define RESOLUTION 0.01
#define INTERVALL_BOMB 0.5
#define INTERVALL_ROCKET 0.1
#define INTERVALL_BULLET 0.1
params["_ammoName","_pos","_initialVelocity","_velocityVec","_mass"];

_airFriction      = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "airFriction");
_sideAirFriction  = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "sideAirFriction");
_timeToLive       = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "timeToLive");
_thrust    = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrust");
_thrustTTL = getNumber(configFile >> "CfgAmmo" >> _ammoName >> "thrustTime");

_gravity = 9.80665;

_velocity = _velocityVec vectorAdd _initialVelocity;
_accelerationV = (vectorNormalized _velocityVec) vectorMultiply _thrust;

_return = _pos;

_dt = RESOLUTION;
_elapsedTime = 0;

_impactPos = [0,0,0];

for "_i" from 1 to ITERATIONS do {

    _dt = (_i^-0.1)/8 max RESOLUTION;
    _elapsedTime = _elapsedTime + _dt;
    _a = [0,0,0];

    if(_elapsedTime < _thrustTTL) then {
        _a = _accelerationV;
    };

    //http://physics.gmu.edu/~amin/phys251/Topics/NumAnalysis/Odes/projectileMotion.html
    _Vmagnitude = sqrt vectorMagnitude _velocity;
    //0.6 is a magic number to reduce the error caused by the Euler method
    _Vmagnitude = 0.6 * _Vmagnitude*-_airFriction;
    _Fdrag = _velocity vectorMultiply _Vmagnitude;

    //determine the velocity
    _deltaV = _Fdrag vectorMultiply (1/_mass);
    _deltaV = _a vectorAdd _deltaV;
    _deltaV = _deltaV vectorAdd  [0,0,-_gravity];
    _deltaV = _deltaV vectorMultiply _dt;
    _velocity = _velocity vectorAdd _deltaV;

    _deltaPos = _velocity vectorMultiply _dt;
    _pos = _pos vectorAdd _deltaPos;
    _impactPos = _pos;
    if(!surfaceIsWater _impactPos) then {
        _impactPos = ASLToATL _impactPos;
    };
    CHECK((_impactPos select 2 ) < 0);
};

GVAR(hud_smoothing) pushBack _impactPos;
GVAR(hud_smoothing) deleteAt 0;
 _sum = [0,0,0];
{
    _sum = _sum vectorAdd _x;
} forEach GVAR(hud_smoothing);

_return = _sum vectorMultiply (1/(count GVAR(hud_smoothing)));

_return


