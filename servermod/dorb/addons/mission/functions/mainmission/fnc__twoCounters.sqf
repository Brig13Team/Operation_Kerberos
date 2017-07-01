/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission with two counters
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - targets
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

// export settings
HASH_SET(_mission, "objects", _targets);
HASH_SET(_mission, "obj_counter_total", count _targets);
HASH_SET(_mission, "obj_counter_1", 0); // _event_1's counter
HASH_SET(_mission, "obj_counter_2", 0); // _event_2's counter
HASH_SET(_mission, "condition", QFUNC(mainmission__twoCounters_condition));
