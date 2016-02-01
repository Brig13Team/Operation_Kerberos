/*
    Author: Dorbedo
    
    Description:
        returns Roll Pitch Yaw of an Object
    Parameter(s):
        0 : OBJECT - the object
    
    Return
        ARRAY - Roll Pitch Yaw
*/
#include "script_component.hpp"
_this params [["_object",objNull,[objNull]]];

private _objectVDir = VectorDir _object;
private _objectVUp = VectorUp _object;
private _objectDir = getDir _object;

private _Rollwinkel = 0;
private _Gierwinkel = 0;
private _Nickwinkel = 0;

private _objectVSide = _objectVDir VectorcrossProduct _objectVUp;

private _VectorDir = [_objectVDir,_objectDir] call FUNC(rotateVectorXY);
private _VectorUp = [_objectVUp,_objectDir] call FUNC(rotateVectorXY);

private _VectorDirY = _VectorDir select 1;
private _VectorUpZ = _VectorUp select 2;

if (_VectorDirY == 0) then {_VectorDirY = 0.01;};
if (_VectorUpZ == 0) then {_VectorUpZ = 0.01;};

_Nickwinkel = atan ((_VectorDir select 2) / _VectorDirY);
_Rollwinkel = atan ((_VectorUp select 0) / _VectorUpZ);
_Gierwinkel = 360 - _objectDir;

if((_VectorUp select 2) < 0) then {
    _Rollwinkel = _Rollwinkel - ([1,-1] select (_Rollwinkel < 0)) * 180;
};

[_Rollwinkel,_Nickwinkel,_Gierwinkel];