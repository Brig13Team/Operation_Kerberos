/*
    Author: Dorbedo

    Description:
        called via XEH_INIT

*/
#include "script_component.hpp"
_this params [["_object",objNull,[objNull]]];
CHECK(isNull _object)
_object setdamage 0;
_object setVariable [QGVAR(isActive),true,true];
_object addEventHandler ["HandleDamage", LINKFUNC(onHandleDamageC4)];
