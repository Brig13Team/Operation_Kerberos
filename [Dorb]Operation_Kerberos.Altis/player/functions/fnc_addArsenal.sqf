/*
    Author: Dorbedo
    
    Description:
        adds Arsenal to a unit
        can be called via unit-init
        
    Parameter(s):
        none
        
    Return
        none
*/
#include "script_component.hpp"
SCRIPT(addArsenal);
CHECK(!(local _this))
["AmmoboxInit",[_this,true,{true}]] call BIS_fnc_arsenal;