/*
    Author: Dorbedo

    Description:
    cleans the Base

*/
#include "script_component.hpp"
SCRIPT(cleanup_small);

{
    _x TILGE;
} foreach nearestObjects [(getmarkerpos GVARMAIN(RESPAWNMARKER)),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 1500];

{
    _x TILGE;
} foreach nearestObjects [(getmarkerpos GVARMAIN(AIRFIELD)),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 1500];
