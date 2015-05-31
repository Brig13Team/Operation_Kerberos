/*
	Author: Dorbedo
	
	Description:
		initServer
*/
#include "script_component.hpp"

[] spawn FM(core);
[] spawn FM(spawn_ui_createlist);

_Krankenhaus = "Land_Medevac_HQ_V1_F" createVehicle (getMarkerPos "krankenhaus");
_Krankenhaus setDir (MarkerDir "Krankenhaus");
SETPVAR(_Krankenhaus,ace_medical_isMedicalFacility, true);