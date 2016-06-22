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
LOG("Headless disconnected");
GVAR(HeadlessClients) deleteAt (GVAR(HeadlessClients) find _object);

CHECK(GVAR(istransfering))
GVAR(istransfering) = true;
[FUNC(transfer), [true], HEADLESSDELAY] call CBA_fnc_waitAndExecute;