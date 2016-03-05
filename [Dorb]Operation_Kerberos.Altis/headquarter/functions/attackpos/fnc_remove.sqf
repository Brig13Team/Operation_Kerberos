/*
    Author: Dorbedo
    
    Description:
        deletes an attackpos;
    
    Parameter(s):
        0:LOCATION - Attackposition

    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params [["_location",locationNull,[locationNull]]];

private _index = GVAR(attackpos) find _location;

If (_index < 0) then {
    false;
}else{
    GVAR(attackpos) deleteAt _index;
    true;
};