/*
 *  Author: iJesuz
 *
 *  Description:
 *      mission with two counters in condition
 *      (can be used for sidemission too)
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *      1 : CODE    - obj init code
 *      2 : NUMBER  - (optional) time to end (default: -1)
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
HASH_SET(_mission, "obj_counter", 0);
HASH_SET(_mission, "condition", QFUNC(mainmission__oneCounter_condition));

// optional settings
HASH_SET(_mission, "trigger_failed", false);
HASH_SET(_mission, "time_to_end", _this param [2, -1]);
