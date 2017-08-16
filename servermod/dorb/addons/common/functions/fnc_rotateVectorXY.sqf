/*
    Author: Dorbedo
    
    Description:
        rotate a Vector on XY-Direction
        
    Parameter(s):
        0 : ARRAY - Vector
        1 : SCALAR - direction
    
    Return
        ARRAY - rotated Vector
*/
#include "script_component.hpp"
_this params ["_vector","_dir"];
_vector params ["_x","_y"];
_vector set [0,(cos _dir)*_x - (sin _dir) * _y];
_vector set [1,(sin _dir)*_x + (cos _dir) * _y];
_vector;