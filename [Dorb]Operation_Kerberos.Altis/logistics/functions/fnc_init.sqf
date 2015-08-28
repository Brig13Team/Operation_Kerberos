/*
	Author: Dorbedo
	
	Description:
		
		initialization for logistics
		
	
	Parameter(s):
		none
		
	Returns:
		nothing
*/
#include "script_component.hpp"
SCRIPT(init);
CHECK(!hasInterface);
CHECK(!isClass(missionconfigFile >> "logistics"))
private["_cfgLog","_loadAction","_unloadAction","_checkAction","_paraAction","_vehicle","_loadfunction"];


_cfgLog = missionconfigFile >> "logistics" >> "vehicles";
_loadAction = [QGVAR(action_load), localize "STR_DORB_LOG_ACTION_LOAD", "", {[_target] spawn FUNC(doload);}, {[_target] call FUNC(canload);}] call ace_interact_menu_fnc_createAction;
_unloadAction = [QGVAR(action_unload), localize "STR_DORB_LOG_ACTION_UNLOAD", "", {[_target] spawn FUNC(dounload);}, {  [_target] call FUNC(canUnload);  }] call ace_interact_menu_fnc_createAction;
_infoAction = [QGVAR(action_info), localize "STR_DORB_LOG_ACTION_DISP_CARGO","",{[_target] spawn FUNC(disp_cargo);},{true}] call ace_interact_menu_fnc_createAction;
_paraAction = [QGVAR(action_paradrop), localize "STR_DORB_LOG_ACTION_PARADROP", "", {[_target,true] spawn FUNC(dounload);}, {[_target] call FUNC(candrop);}] call ace_interact_menu_fnc_createAction;

for "_i" from 0 to ((count _cfgLog)-1) do {
	_vehicle = configname(_cfgLog select _i);
	If (isClass(configFile >> "cfgvehicles" >> _vehicle)) then {
		_canLoad = ( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "max_length") ) > 0;
		_canPara = ((( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "max_length") ) > 0)&&(_vehicle isKindOf "Air"));
		If (_canLoad) then {
			[_vehicle, 0, ["ACE_MainActions"], _loadAction] call ace_interact_menu_fnc_addActionToClass;
			[_vehicle, 0, ["ACE_MainActions"], _unloadAction] call ace_interact_menu_fnc_addActionToClass;
			[_vehicle, 0, ["ACE_MainActions"], _infoAction] call ace_interact_menu_fnc_addActionToClass;
			[_vehicle, 1, ["ACE_SelfActions"], _infoAction] call ace_interact_menu_fnc_addActionToClass;
			If (_canPara) then {
				[_vehicle, 1, ["ACE_SelfActions"], _paraAction] call ace_interact_menu_fnc_addActionToClass;
			};
			
		};
	};
};