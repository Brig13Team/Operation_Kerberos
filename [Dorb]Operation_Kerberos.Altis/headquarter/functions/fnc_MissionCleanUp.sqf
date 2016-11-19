/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Cleans the mission specific values after the end of a main-mission
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

GVAR(active) = false;

//POI
{
    private _value = HASH_GET(GVAR(POI),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(POI));

// Dangerzones
{
    private _value = HASH_GET(GVAR(dangerzones),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(dangerzones));

// Groups
{
    private _value = HASH_GET(GVAR(groups),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(groups));

// Attackpositions
{
    private _value = HASH_GET(GVAR(attackpos),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(attackpos));
