/*
	Author: Dorbedo
	
	Description:
		resets the HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(init);

GVAR(hq_aktive) = false;

uisleep 30;

SETMVAR(GVAR(HQ_Other),[]);
SETMVAR(GVAR(HQ_marine),[]);
SETMVAR(GVAR(HQ_Car),[]);
SETMVAR(GVAR(HQ_Drone),[]);
SETMVAR(GVAR(HQ_Tank),[]);
SETMVAR(GVAR(HQ_Infanterie),[]);
SETMVAR(GVAR(HQ_Attack_Helicopter),[]);
SETMVAR(GVAR(HQ_Transport_Helicopter),[]);
SETMVAR(GVAR(HQ_CAS_Plane),[]);
SETMVAR(GVAR(HQ_Air_other),[]);

SETMVAR(GVAR(HQ_Area_killed),[]);
SETMVAR(GVAR(HQ_centerpos),[]);
SETMVAR(GVAR(HQ_Area_positions),[]);
SETMVAR(GVAR(HQ_Area_weight),[]);

SETMVAR(GVAR(hq_buffer),[]);

[QGVAR(hq_dangerzones)] call EFUNC(common,matrix_clear);

GVAR(hq_aktive) = true;