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


private ["_model","_namearray","_modelname","_modelnamearray","_dot"];
_model = getText(configfile >> "cfgVehicles" >> (_objectType) >> "model");
If (_model isEqualTo "") exitWith {""};
_namearray = _model splitString "\";
If (_namearray isEqualTo []) exitWith {""};

_modelname = _namearray select ((count _namearray) -1);
/// remove ".p3d" if present
_modelnamearray = toArray(_modelname);
If (46 in _modelnamearray) then {
	_modelnamearray resize ((count _modelnamearray)-4);
	_modelname = toString _modelnamearray;
};

If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _modelname)) exitWith {_modelname};


""
