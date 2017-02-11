/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Mission "Capture"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *      1 : STRING  - event name
 *      2 : CODE    - event parameter
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_event_name", "_event_parameter"];

private _type     = HASH_GET(_mission, "type");
private _position = HASH_GET(_mission, "location") select 1;

// get settings
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "location" >> "distance");

// spawn and init target
private _obj = [_position, _type, _radius] call EFUNC(spawn,createMissionTarget);
[_obj] call FUNC(obj_init_device);

// export settings
HASH_SET(_mission, "object", _obj);
HASH_SET(_mission, "condition", QFUNC(mainmission___device_condition));
