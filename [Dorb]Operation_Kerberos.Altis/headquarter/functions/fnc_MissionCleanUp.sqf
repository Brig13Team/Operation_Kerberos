/**
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

_this params ["_mission"];

if !(HASH_GET(_mission, "type") isEqualTo "rtb") exitWith { -1 };

GVAR(active) = false;

//POI
{
    private _value = HASH_GET(GVAR(POI),_x);
    If (IS_LHASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(POI));

// Dangerzones
{
    private _value = HASH_GET(GVAR(dangerzones),_x);
    If (IS_LHASH(_value)) then {
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
    If (IS_LHASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(groups));

{
    [_x] call EFUNC(common,delete);
} count (missionNamespace getVariable [QGVAR(AIGroups),[]]);
GVAR(AIGroups) = [];

// Attackpositions
/*
{
    private _value = HASH_GET(GVAR(attackpos),_x);
    If (IS_HASH(_value)) then {
        HASH_DELETE(_value);
    };
} forEach HASH_KEYS(GVAR(attackpos));
*/
{
    HASH_DELETE(_x);
} forEach HASH_GET_DEF(GVAR(attackPos),"locations",[]);
HASH_SET(GVAR(attackPos),"locations",[]);

[] call FUNC(drones_onMissionEnd);
