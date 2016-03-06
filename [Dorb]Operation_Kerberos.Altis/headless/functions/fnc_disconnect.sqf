/*
    Original Author: jonpas
    Author: Dorbedo
    
    Description:
        removal of the  disconnected headless client
    Parameter(s):
        0:OBJECT - connected headless
    Return:
        none
*/
#include "script_component.hpp"
_this params ["_object"];
CHECK(!(_object in GVAR(HeadlessClients)))

GVAR(HeadlessClients) deleteAt (GVAR(HeadlessClients) find _object);

CHECK(GVAR(transfering))
GVAR(transfering) = true;
[FUNC(move), [], HEADLESSDELAY] call EFUNC(common,waitAndExecute);