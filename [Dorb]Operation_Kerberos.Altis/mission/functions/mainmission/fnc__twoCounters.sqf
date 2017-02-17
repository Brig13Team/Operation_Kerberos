/*
 *  Author: iJesuz
 *
 *  Description:
 *      mission with two counters in condition
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *      1 : CODE    - obj init code
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

// spawn target
private _objs = _this call FUNC(mainmission___spawnTargets);

// export settings
HASH_SET(_mission, "objects", _objs);
HASH_SET(_mission, "obj_counter_total", count _objs);
HASH_SET(_mission, "obj_counter_1", 0); // _event_1's counter
HASH_SET(_mission, "obj_counter_2", 0); // _event_2's counter
HASH_SET(_mission, "condition", QFUNC(mainmission__twoCounters_condition));
