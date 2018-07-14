#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getSimilarHouses
  Author: Dorbedo
  return an array with similar housetypes

  Arguments:
    0: the house to be searched <STRING>

  Return Value:
    similiar house classes <ARRAY>

  Public: Yes
*/

params [["_houseclass", "", [""]]];

If (_houseclass isEqualTo "") exitWith {[]};

private _model = getText(configFile >> "CfgVehicles" >> _houseclass >> "model");

private _model = _model splitString "/";
_model = (_model select [0, (count _model - 1)]) joinString "/";

GVAR(housecache) getVariable [_model, [_houseClass]];
