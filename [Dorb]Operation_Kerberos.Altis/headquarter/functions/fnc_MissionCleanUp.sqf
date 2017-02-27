/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Cleans the mission specific values after the end of a main-mission
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
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
        HASH_SET(GVAR(dangerzones),_x,nil);
    };
} forEach HASH_KEYS(GVAR(dangerzones));
HASH_SET(GVAR(dangerzones),"centerpos",nil);
HASH_SET(GVAR(dangerzones),"x",nil);
HASH_SET(GVAR(dangerzones),"y",nil);

// Groups
{
    private _value = HASH_GET(GVAR(groups),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(groups));
HASH_SET(GVAR(groups),"defenceGroups",[]);
HASH_SET(GVAR(groups),"attackGroups",[]);
HASH_SET(GVAR(groups),"patrolGroups",[]);

// Attackpositions
{
    private _value = HASH_GET(GVAR(attackpos),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(attackpos));
