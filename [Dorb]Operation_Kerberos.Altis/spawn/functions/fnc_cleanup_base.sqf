/*
    Author: Dorbedo

    Description:
    cleans the Base

*/
#include "script_component.hpp"

private _objectsToDelete = [];
{
    _objectsToDelete pushBackUnique _x;
} foreach nearestObjects [(getmarkerpos GVARMAIN(RESPAWNMARKER)),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 1500];

{
    _objectsToDelete pushBackUnique _x;
} foreach nearestObjects [(getmarkerpos GVARMAIN(AIRFIELD)),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 1500];

[
    {
        _this params ["_objectsToDelete"];
        {
            _x call EFUNC(common,delete);
        }forEach _objectsToDelete;
    },
    [_objectsToDelete],
    10
] call CBA_fnc_waitAndExecute;
