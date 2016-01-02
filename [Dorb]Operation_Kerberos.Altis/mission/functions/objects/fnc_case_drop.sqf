/*
    Author: Dorbedo
    
    Description:
        init function
    
*/
#include "script_component.hpp"
SCRIPT(carry);

CHECK(!hasinterface)

#define ATTACH_POINT [0,0,-0.1]
#define ANIM_TIME 1.1


params["_carrier"];

_suitcase = _carrier getVariable [QGVAR(objects_suitcase),objNull];

detach _suitcase;
_suitcase setPos (position _carrier);
_carrier forceWalk false;

_suitcase setVariable [QGVAR(objects_pos),getPos _suitcase,true];
_suitcase setVariable [QGVAR(objects_carrier),objNull,true];


