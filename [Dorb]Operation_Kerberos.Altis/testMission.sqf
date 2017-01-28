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

_this params [["_type","",[""]]];

[] call EFUNC(spawn,army_set);

/*
EGVAR(mission,next_mission)  = [] call EFUNC(mission,taskmanager_choose_mission);
EGVAR(mission,next_location) = [EGVAR(mission,next_mission)] call EFUNC(mission,taskmanager_choose_location);
EGVAR(mission,task_counter)  = 0;
EGVAR(mission,conditions)    = [];
*/
/*
If (isNil QEGVAR(mission,conditions)) then {
    [] call EFUNC(mission,taskmanager_init);
};
*/
if (_type isEqualTo "") then {
    EGVAR(mission,next_mission)  = [] call EFUNC(mission,taskmanager_choose_mission);
}else{
    EGVAR(mission,next_mission)  = _type;
};
EGVAR(mission,next_location) = [EGVAR(mission,next_mission)] call EFUNC(mission,taskmanager_choose_location);
TRACEV_2(EGVAR(mission,next_mission),EGVAR(mission,next_location));

If (isNil QGVAR(test_mission)) then {
    GVAR(test_mission) = EGVAR(mission,next_location) select 1;
}else{
    [GVAR(test_mission),1600] call EFUNC(spawn,cleanUp_full);
};
[] call EFUNC(mission,taskmanager_cancelALL);
TRACE("SPAWNING MISSION");
[] spawn EFUNC(mission,taskmanager_spawn);
