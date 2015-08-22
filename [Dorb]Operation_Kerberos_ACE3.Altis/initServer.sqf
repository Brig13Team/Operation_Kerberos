/*
	Author: Dorbedo
	
	Description:
		initServer
*/
#include "script_component.hpp"

waituntil{!isNil "DORB_RESPAWNMARKER"};

DORB_HEADLESS_EVENTHANDLER = [{ [] call dorb_fnc_headless } , 30, [] ] call CBA_fnc_addPerFrameHandler;

[] spawn FM(core);
[] spawn FM(ui_spawn_createlist);

#ifdef DORB_PILOT_WHITELIST_ENABLED
	DORB_RESERVED_PILOT=[];
	DORB_RESERVED_PILOT_SLOT = true;
	[] call FM(userconfig);
	["DORB_PILOT_WHITELIST", "onPlayerConnected", {
		If (_uid in DORB_RESERVED_PILOT) then {
			[] call FM(userconfig);
			_owner publicVariableClient "DORB_RESERVED_PILOT_SLOT";
		};
	}] call BIS_fnc_addStackedEventHandler;
#endif


#ifdef DORB_ZEUS_WHITELIST_ENABLED
	DORB_RESERVED_ZEUS=[];
	DORB_RESERVED_ZEUS_SLOT = true;
	[] call FM(userconfig);
	["DORB_ZEUS_WHITELIST", "onPlayerConnected", {
		If (_uid in DORB_RESERVED_ZEUS) then {
			[] call FM(userconfig);
			_owner publicVariableClient "DORB_RESERVED_ZEUS_SLOT";
		};
	}] call BIS_fnc_addStackedEventHandler;
#endif


_Krankenhaus = "Land_Medevac_HQ_V1_F" createVehicle (getMarkerPos "krankenhaus");
_Krankenhaus setDir (MarkerDir "Krankenhaus");
_Krankenhaus enableSimulation false;
SETPVAR(_Krankenhaus,ace_medical_isMedicalFacility, true);
