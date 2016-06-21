/*
    Original Author: jonpas
    Author: Dorbedo
    
    Description:
        moving a unit to the headlessclient after initialisation
    Parameter(s):
        0:OBJECT - connected headless
    Return:
        none
*/
#include "script_component.hpp"
_this params ["_object"];

CHECK((!GVARMAIN(HC_enabled))||{!(_object in AllUnits)}||{!(isPlayer _object)})

CHECK(GVAR(transfering))
GVAR(transfering) = true;
[FUNC(transfer), [], HEADLESSDELAY] call EFUNC(common,waitAndExecute);