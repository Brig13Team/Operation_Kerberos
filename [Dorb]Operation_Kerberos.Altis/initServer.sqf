/*
	Author: Dorbedo

	Description:
		initServer
*/
#include "script_component.hpp"
SCRIPT(initServer);

/// RHS Fix for dedicated
private _rhs_activeTirePressure = profilenamespace getvariable 'rhs_activeTirePressure';
if (isNil "_rhs_activeTirePressure") then {
	profilenamespace setvariable ['rhs_activeTirePressure',0];
};

waituntil{!isNil "DORB_RESPAWNMARKER"};

/// 6h == 12h Ingame
setTimeMultiplier 2;

//EGVAR(common,PFEH_headless) = [{ [] call EFUNC(common,headless) } , 30, [] ] call CBA_fnc_addPerFrameHandler;

[] spawn EFUNC(mission,core);
[] spawn EFUNC(interface,spawn_createlist);

#ifdef DORB_PILOT_WHITELIST_ENABLED
	GVAR(reserved_pilot)=[];
	GVAR(reserved_pilot_slot) = true;
	[] call FUNC(userconfig);
	[QGVAR(pilot_whitelist), "onPlayerConnected", {
		[] call FUNC(userconfig);
		If (_uid in GVAR(reserved_pilot)) then {
			_owner publicVariableClient QGVAR(reserved_pilot_slot) ;
		};
	}] call BIS_fnc_addStackedEventHandler;
#endif


#ifdef DORB_ZEUS_WHITELIST_ENABLED
	GVAR(reserved_zeus)=[];
	GVAR(reserved_zeus_slot) = true;
	[] call FUNC(userconfig);
	[QGVAR(zeus_whitelist), "onPlayerConnected", {
		[] call FUNC(userconfig);
		If (_uid in GVAR(reserved_zeus)) then {
			_owner publicVariableClient QGVAR(reserved_zeus_slot) ;
		};
	}] call BIS_fnc_addStackedEventHandler;
#endif
