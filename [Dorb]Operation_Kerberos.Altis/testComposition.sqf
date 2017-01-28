/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_town",false,[true]]];

If (isNil QGVAR(test_composition)) then {
    GVAR(test_composition) = [];
}else{
    [GVAR(test_composition),1600] call EFUNC(spawn,cleanUp_full);
};


private _type = "clear";
If (_town) then {_type = "hostage"};


([_type] call EFUNC(mission,taskmanager_choose_location)) params ["_locName","_locPos"];
TRACEV_2(_locName,_locPos);
GVAR(test_composition) = _locPos;
If (_town) then {
    [_locPos] call EFUNC(spawn,createMissionHouse);
}else{
    [_locPos,"",1] call EFUNC(spawn,createMissionComposition);
};
