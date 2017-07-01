/*
 *  Author: Dorbedo
 *
 *  Description:
 *      merges a hash into another,
 *      if the hash has already the same key, the value is replaced
 *
 *  Parameter(s):
 *      0 : LOCATION - the main hash
 *      1 : LOCATION - the hash to be merged into (the hash is not deleted)
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_mainHash","_secondaryHash"];

{
    LHASH_SET(_mainHash,_x,LHASH_GET(_secondaryHash,_x));
} forEach (LHASH_KEYS(_secondaryHash));

nil;
