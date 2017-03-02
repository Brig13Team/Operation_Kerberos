/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns all Hash locations (including new ones, lost ones)
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - Array of locations
 *
 */
#include "script_component.hpp"

(nearestLocations [DORB_HASH_SYS_POSITION, ["CBA_NamespaceDummy"], 1] select {(text _x) isEqualTo DORB_HASH_SYS_NAME});
