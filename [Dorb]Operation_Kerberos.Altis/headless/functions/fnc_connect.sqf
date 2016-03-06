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

CHECK((!GVARMAIN(HC_enabled))||{!(_object in AllUnits)}||{!(isPlayer _object)})

GVAR(HeadlessClients) pushBack _object;

CHECK(GVAR(transfering))
GVAR(transfering) = true;
[FUNC(move), [], HEADLESSDELAY] call EFUNC(common,waitAndExecute);
nil;