/*
    Author: Dorbedo, iJesuz
    
    Description:
        Checks if Unit can unload
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        BOOL
*/
#include "script_component.hpp"

#define INTERVALL 5

if (player getVariable [QGVAR(isloading),false]) exitWith { false };
_this params ["_target"];

private _logistic_stack = _target getVariable [QGVAR(stack),[]];
if (_logistic_stack isEqualTo []) exitWith { false };
private _load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");

private _cargo = _logistic_stack select ((count _logistic_stack) - 1); _cargo = _cargo select ((count _cargo) - 1);
private _width  = _cargo select 1 select 0;
private _length = _cargo select 1 select 1;
private _height = _cargo select 1 select 2;

private _load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point");
private _phi = getDir _target;

_load_point = _load_point vectorDiff [0,_length/2,0];
_load_point = _target modelToWorld _load_point;
_load_point set [2,0];

private _theta = _width atan2 _length;
private _radius = 0.5 * sqrt(_width^2 + _length^2);
private _pos = _load_point vectorAdd POLAR_3D(_phi + _theta, _radius) vectorAdd [0,0,0.05]; // Ecke oben rechts (etwas erhöht)

private _intersects = false;
for [{_i = 0}, {_i <= _length}, {_i = _i + _length/INTERVALL}] do {
    for [{_k = 0}, {_k <= _width}, {_k = _k + _width/INTERVALL}] do {
        _theta = _i atan2 _k;
        private _temp = _pos vectorDiff NPOLAR_3D(_theta - _phi,sqrt(_k^2 + _i^2)); // pos relativ zur Ecke oben rechts

        _intersects = _intersects || (!(lineIntersectsSurfaces [AGLToASL _temp, AGLToASL (_temp vectorAdd [0,0,_height-0.05])] isEqualTo []));
    };
};

!_intersects