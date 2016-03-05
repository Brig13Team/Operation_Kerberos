/*
    Author: Dorbedo
    
    Description:
        initialiuzes AI HQ
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

GVAR(aktive) = false;

GVAR(attackpos) TILGE;

SETMVAR(GVAR(Infanterie),[]);
SETMVAR(GVAR(Attack_Helicopter),[]);
SETMVAR(GVAR(Transport_Helicopter),[]);
SETMVAR(GVAR(CAS_Plane),[]);
SETMVAR(GVAR(Air_other),[]);
SETMVAR(GVAR(Tank),[]);
SETMVAR(GVAR(Drone),[]);
SETMVAR(GVAR(Car),[]);
SETMVAR(GVAR(marine),[]);
SETMVAR(GVAR(Other),[]);


SETMVAR(GVAR(centerpos),[]);

SETMVAR(GVAR(support_requests),[]);
SETMVAR(GVAR(buffer),[]);

[QGVAR(dangerzones)] call EFUNC(common,matrix_clear);
