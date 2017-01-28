/*
    Author: Dorbedo
    
    Description:
        adds TFR to a vehicle
*/
#include "script_component.hpp"
CHECKRET((!(isClass(configFile >> "CfgPatches" >> "task_force_radio"))),true);
_this params[["_vehicle",objNull,[objNull]]];
CHECKRET(((isNull _vehicle)),true);

_vehicle setVariable ['tf_hasRadio',true,true];

true