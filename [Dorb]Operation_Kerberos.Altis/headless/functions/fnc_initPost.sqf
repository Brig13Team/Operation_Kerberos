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

CHECK(GVAR(istransfering))
CHECK((!GVAR(HC_enabled))||{!(_object in AllUnits)}||{!(isPlayer _object)})

GVAR(istransfering) = true;
[FUNC(transfer), [], HEADLESSDELAY] call CBA_fnc_waitAndExecute;
