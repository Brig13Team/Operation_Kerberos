/*
 *  Author: Dorbedo
 *
 *  Description:
 *      export the locations into a hpp
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _hash = [] call FUNC(getLocations);
[_hash] call FUNC(showLocations);
[_hash] call EFUNC(common,exportHashtoHpp);
