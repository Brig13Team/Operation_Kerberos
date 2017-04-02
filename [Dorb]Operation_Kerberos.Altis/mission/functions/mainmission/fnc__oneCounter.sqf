/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission with one counter
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - targets
 *      2 : NUMBER      - (optional) time to end (default: -1)
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets", ["_timeToEnd", -1, [0]]];

// export settings
HASH_SET(_mission, "objects", _targets);
HASH_SET(_mission, "obj_counter_total", count _targets);
HASH_SET(_mission, "obj_counter", 0);
HASH_SET(_mission, "condition", QFUNC(mainmission__oneCounter_condition));

// optional settings
HASH_SET(_mission, "trigger_failed", false);
HASH_SET(_mission, "time_to_end", _timeToEnd);
