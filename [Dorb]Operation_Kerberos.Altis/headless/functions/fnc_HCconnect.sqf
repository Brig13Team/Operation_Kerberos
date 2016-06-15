/*
    Original Author: jonpas
    Author: Dorbedo
    
    Description:
        registration of the new connected headless client
    Parameter(s):
        0:OBJECT - connected headless
    Return:
        none
*/
#include "script_component.hpp"
_this params ["_object"];

GVAR(HeadlessClients) pushBack _object;

CHECK(GVAR(istransfering))
GVAR(istransfering) = true;
[FUNC(transfer), [], HEADLESSDELAY] call CBA_fnc_waitAndExecute;
nil;