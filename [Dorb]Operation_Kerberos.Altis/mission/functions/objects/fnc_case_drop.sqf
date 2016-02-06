/*
    Author: Dorbedo
    
    Description:
        init function
    
*/
#include "script_component.hpp"
CHECK(!hasinterface)

_this params["_carrier"];

private _suitcase = _carrier getVariable [QGVAR(objects_suitcase),objNull];

_suitcase setVariable [QGVAR(objects_pos),getPos _suitcase,true];
_suitcase setVariable [QGVAR(objects_carrier),objNull,true];

detach _suitcase;
_suitcase setPos (position _carrier);
_carrier forceWalk false;