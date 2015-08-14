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
SCRIPT(log_init);
CHECK(!hasInterface);
CHECK(!isClass(missionconfigFile >> "logistics"))
private["_cfgLog","_loadAction","_unloadAction","_checkAction","_paraAction","_vehicle"];

_cfgLog = missionconfigFile >> "logistics" >> "vehicles";
_loadAction = ["DORB_LOG_ACTION_LOAD", localize "STR_DORB_LOG_ACTION_LOAD", "", {[_target] call FM(log_load);}, {(((getnumber(missionconfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "max_length"))>0)&&{[_target] call FM(log_can_load)})}] call ace_interact_menu_fnc_createAction;
_unloadAction = ["DORB_LOG_ACTION_LOAD", localize "STR_DORB_LOG_ACTION_LOAD", "", {[_target] call FM(log_unload);}, {  (!(GETVAR(_target,LOGISTIC_CARGO_STACK,[]) isEqualTo [] ))  }] call ace_interact_menu_fnc_createAction;
_checkAction = ["DORB_LOG_ACTION_CHECK", localize "STR_DORB_LOG_ACTION_CHECK", "", {[_target] call FM(log_check);}, {true}] call ace_interact_menu_fnc_createAction;
_paraAction = ["DORB_LOG_ACTION_PARADROP", localize "STR_DORB_LOG_ACTION_PARADROP", "", {[_target] call FM(log_drop);}, { ((!(GETVAR(_target,LOGISTIC_CARGO_STACK,[]) isEqualTo [] ))&&{[_target] call FM(log_can_drop);}) }] call ace_interact_menu_fnc_createAction;

for "_i" from 0 to ((count _cfgLog)-1) do {
	_vehicle = configname(_cfgLog select _i);
	If (isClass(configFile >> "cfgvehicles" >> _vehicle)) then {
		_canLoad = ( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "canload") ) > 0;
		_canPara = ( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "canPara") ) > 0;
		If (_canLoad) then {
			[_vehicle, 0, ["ACE_MainActions"], _loadAction] call ace_interact_menu_fnc_addActionToClass;
			[_vehicle, 0, ["ACE_MainActions"], _unloadAction] call ace_interact_menu_fnc_addActionToClass;
			[_vehicle, 0, ["ACE_MainActions"], _checkAction] call ace_interact_menu_fnc_addActionToClass;
			If (_canPara) then {
				[_vehicle, 0, ["ACE_MainActions"], _paraAction] call ace_interact_menu_fnc_addActionToClass;
			};
		};
	};
};