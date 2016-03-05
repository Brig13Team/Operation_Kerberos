/*
    Author: Dorbedo
    
    Description:
        returns an array with all players
    Parameter(s):
        0: ARRAY - position
        1: SCALAR/ARRAY - [sizeX,sizeY] or size
        2: BOOLEAN - rectangular? (default: false-elliptical)
        
    Return:
        LOCATION
*/
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]],["_size",50,[0,[]],[2]],["_retangular",false,[false]]];
private "_newLoc";
If (_size isEqualType []) then {
    createLocation ["CBA_NamespaceDummy", _position , _size select 0, _size select 1];
}else{
    createLocation ["CBA_NamespaceDummy", _position , _size, _size];
};
_newLoc setRectangular false;
_newLoc;