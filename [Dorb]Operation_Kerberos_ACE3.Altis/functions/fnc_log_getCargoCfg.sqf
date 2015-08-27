/*
	Author: Dorbedo
	
	Description:
		Returns the logistics config entry of an configclass
		
	Parameter(s):
		0 : STRING - Target
		
	Returns:
		STRING
*/
#include "script_component.hpp"
SCRIPT(log_getCargoCfg);
PARAMS_1(_objectType);
If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _objectType)) exitWith {_objectType};


private ["_model","_modelname","_modelnamearray"];
_model = getModelInfo _objectType;
If (isNil "_model") exitWith {""};
/// remove .p3d
_modelnamearray = toArray(_model select 0);
_modelnamearray resize ((count _modelnamearray)-4);
_modelname = toString _modelnamearray;

If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _modelname)) exitWith {_modelname};


""
