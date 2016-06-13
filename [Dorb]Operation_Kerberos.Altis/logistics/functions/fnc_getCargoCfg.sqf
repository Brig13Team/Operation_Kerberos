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

_this params[["_object",objNull,[objNull,""]]];

If (IS_OBJECT(_object)) then {
If (isNull _object) exitWith {""};
If (isClass(missionConfigFile >> "logistics" >> "cargos" >> (typeOf _object))) exitWith {(typeOf _object)};

private _model = getModelInfo _object;
If (isNil "_model") exitWith {""};
/// remove .p3d
private _modelnamearray = toArray(_model select 0);
_modelnamearray resize ((count _modelnamearray)-4);
private _modelname = toString _modelnamearray;
If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _modelname)) exitWith {_modelname};
    "";
}else{
    If (_object isEqualTo "") exitWith {""};
    If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _object)) exitWith {_object};
    If (!isClass(configFile >> "CfgVehicles" >> _object)) exitWith {""};
    private _model = getText(configFile >> "CfgVehicles" >> _object >> "model");
    If (_model isEqualTo "") exitWith {""};
    _model = _model splitString "\.";
    private _modelname = "FEHLER";
    If ((_model select ((count _model)-1)) == "p3d") then {
        _modelname = _model select ((count _model)-2);
    }else{
        _modelname = _model select ((count _model)-1);
    };
    If (isClass(missionConfigFile >> "logistics" >> "cargos" >> _modelname)) exitWith {_modelname};
    "";
};