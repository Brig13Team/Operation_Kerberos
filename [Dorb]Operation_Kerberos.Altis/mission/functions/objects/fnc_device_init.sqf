/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(canDisable);

_this params [["_object",objNull,[objNull]]];
CHECK(isNull _object)
_object setdamage 0;
SETVAR(_object,GVAR(target_dead),false);
_object addEventHandler ["HandleDamage", {_this call EFUNC(common,handledamage_C4);}];