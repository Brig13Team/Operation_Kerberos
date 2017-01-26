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
EGVAR(mission,next_mission)  = [] call EFUNC(mission,taskmanager_choose_mission);
EGVAR(mission,next_location) = [EGVAR(mission,next_mission)] call EFUNC(mission,taskmanager_choose_location);
TRACEV_2(EGVAR(mission,next_mission),EGVAR(mission,next_location));


[] spawn EFUNC(mission,taskmanager_spawn);
