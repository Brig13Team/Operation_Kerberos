/*
    Author: Dorbedo
    
    Description:
        Converts a Rotation Matrix to Angle
        
    Parameter(s):
        0 : SCALAR - roll
        1 : SCALAR - nick
        2 : SCALAR - gier
    
    Return
        ARRAY - RotationMatrix
*/
#include "script_component.hpp"
_this params [["_Rollwinkel",0,[0]],["_Nickwinkel",0,[0]],["_Gierwinkel",0,[0]]];
[
    [
        (cos _Gierwinkel) * (cos _Nickwinkel),
        (sin _Gierwinkel) * (cos _Nickwinkel),
        (-1 * (sin _Nickwinkel))
    ],
    [
        (cos _Gierwinkel) * (sin _Nickwinkel) * (sin _Rollwinkel) - (sin _Gierwinkel) * (cos _Rollwinkel),
        (sin _Gierwinkel) * (sin _Nickwinkel) * (sin _Rollwinkel) + (cos _Gierwinkel) * (cos _Rollwinkel),
        (cos _Nickwinkel) * (sin _Rollwinkel)
    ],
    [
        (cos _Gierwinkel) * (sin _Nickwinkel) * (cos _Rollwinkel) + (sin _Gierwinkel) * (sin _Rollwinkel),
        (sin _Gierwinkel) * (sin _Nickwinkel) * (cos _Rollwinkel) - (cos _Gierwinkel) * (sin _Rollwinkel),
        (cos _Nickwinkel) * (cos _Rollwinkel)
    ]
];