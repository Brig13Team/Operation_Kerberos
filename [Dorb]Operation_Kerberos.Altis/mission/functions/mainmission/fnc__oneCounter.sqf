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
HASH_SET(_mission, "obj_counter", 0);
HASH_SET(_mission, "condition", QFUNC(mainmission___oneCounter_condition));
