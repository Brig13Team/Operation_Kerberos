/*
    Author: Dorbedo

    Description:
        cleansUP between Mainmissions

    Parameter(s):
        none

    Returns:
        BOOL
*/
#include "script_component.hpp"


//POI
{
    private _value = HASH_GET(GVAR(POI),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_GETKEYS(GVAR(POI));

// Dangerzones
{
    private _value = HASH_GET(GVAR(dangerzones),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_GETKEYS(GVAR(dangerzones));

// Groups
{
    private _value = HASH_GET(GVAR(groups),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_GETKEYS(GVAR(groups));

// Attackpositions
{
    private _value = HASH_GET(GVAR(attackpos),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_GETKEYS(GVAR(attackpos));
