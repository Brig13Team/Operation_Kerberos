/*
    Author: Dorbedo
    
    Description:
        Returns the rotation angles of an rotation matrix
        
    Parameter(s):
        0 : ARRAY    - rotation matrix
    
    Return
        [alpha,betha,gamma]
*/
#include "script_component.hpp"
_this params [["_object",objNull,[objNull]],["_rotMat",[],[[]],[3]]];

private _angles = ([_rotMat] call FUNC(convertRotMatToAngle));
CHECK(_angles isEqualTo []);
//_angles params ["_Rollwinkel","_Nickwinkel","_Gierwinkel"];
_angles params ["_Gierwinkel","_Nickwinkel","_Rollwinkel"];

If (floor(abs _Rollwinkel / 90) == (abs _Rollwinkel / 90)) then {_Rollwinkel = _Rollwinkel + 0.01;};
If (floor(abs _Nickwinkel / 90) == (abs _Nickwinkel / 90)) then {_Nickwinkel = _Nickwinkel + 0.01;};
If (floor(abs _Gierwinkel / 90) == (abs _Gierwinkel / 90)) then {_Gierwinkel = _Gierwinkel + 0.01;};

while {abs _Nickwinkel > 180} do {_Nickwinkel = ([-1,1] select (_Nickwinkel > 0))*(abs _Nickwinkel - 180)};
if (abs _Nickwinkel > 90) then {
    _object setdir (getdir _object)-180;
    _Gierwinkel = 360 - (getdir _object);
    _Rollwinkel = _Rollwinkel + 180;
    _Nickwinkel = (180 - abs _Nickwinkel) * ([-1,1] select (_Nickwinkel > 0));
};

private _VectorDir = [0,cos _Nickwinkel,sin _Nickwinkel];
_VectorDir = [_VectorDir,_Gierwinkel] call FUNC(rotateVectorXY);

while {abs _Rollwinkel > 360} do {_Rollwinkel = ([1,-1] select (_Rollwinkel < 0))*(abs _Rollwinkel - 360)};

if(abs _Rollwinkel > 180) then {
    _Rollwinkel = (360-_Rollwinkel)*([1,-1] select (_Rollwinkel > 0));
};

private _VectorUp = [sin _Rollwinkel,0,cos _Rollwinkel];
_VectorUp = [_VectorUp,_Gierwinkel] call FUNC(rotateVectorXY);

_object setVectorDirAndUp [_VectorDir,_VectorUp];