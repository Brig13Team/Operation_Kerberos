/*
    Author: Dorbedo
    
    Description:
        called via XEH_INIT
    
*/
#include "script_component.hpp"
_this params [["_object",objNull,[objNull]]];
CHECK(isNull _object)
_object setdamage 0;
SETVAR(_object,GVAR(target_dead),false);
SETVAR(_object,GVAR(dev_disabled),false);
_object addEventHandler ["HandleDamage", {_this call EFUNC(common,handledamage_C4);}];