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
CHECK(!isServer)

If (isClass(missionConfigFile>>GVARMAIN(arsenal))) then {
    waitUntil{!isNil QGVAR(arsenalList)};
}else{
    ["AmmoboxInit",[_this,true,{true}]] call BIS_fnc_arsenal;
};