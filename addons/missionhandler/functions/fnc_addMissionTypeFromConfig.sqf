#include "script_component.hpp"

/*
  Name: dorb_missionhandler_fnc_addMissionTypeFromConfig
  Author: Dorbedo
  reads a missiontype from config and adds it to the missionpool

  Arguments:
    0: configpath <CONFIG>

  Return Value:
    None

 Public: Yes
*/

params [["_config", configNull, [configNull]]];

if ((isNull _config) || {!(isClass _config)}) exitWith {};

private _missionType = getText(_config)

[
    getText(_config >> "Type"), // Missiontype
    


] call FUNC(addMissionType);
