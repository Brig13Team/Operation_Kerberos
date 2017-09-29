/*
 *  Author: Dorbedo
 *
 *  Description:
 *      clears the current box and empties the pad
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"


[GVAR(currentSpawn),8] call FUNC(clearPos);
GVAR(current) = [[],[],[],[],[],[]];
GVAR(current_boxid) = 0;
[] call FUNC(onLoad);
