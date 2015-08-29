/*
	Author: Dorbedo
	
	Description:
		Returns the logistics config entry of an configclass
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		STRING
*/
#include "script_component.hpp"
SCRIPT(getCargoCfg);
params[["_object",objNull,[objNull]]];
If (isNull _object) exitWith {""};
If (isClass(missionConfigFile >> "logistics" >> "cargos" >> (typeOf _object))) exitWith {(typeOf _object)};

private ["_model","_modelname","_modelnamearray"];
_model = getModelInfo _object;
If (isNil "_model") exitWith {""};
/// remove .p3d
_modelnamearray = toArray(_model select 0);
_modelnamearray resize ((count _modelnamearray)-4);
_modelname = toString _modelnamearray;

If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _modelname)) exitWith {_modelname};


""
