/*
 *  Author: Dorbedo
 *
 *  Description:
 *      clear the spawnlocation
 *
 *  Parameter(s):
 *      0 : ARRAY - Position to clear
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]]];
If ((count _position) == 2) then {_position pushBack 0};

{
    private _veh = _x;
    if (((getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "vehicleClass"))isEqualTo "Autonomous")) then {
        {_veh deleteVehicleCrew _x} forEach crew _veh;
        deleteVehicle _veh;
    };
    { if(!(alive _x)) then { deleteVehicle _x; }; } forEach (crew _veh);
    if (count crew _x == 0) then {deletevehicle _x};
} forEach (nearestObjects [_position, ["AllVehicles"], CHECK_RADIUS]);

{deletevehicle _x;} forEach (nearestObjects [_position, ["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder","allDead","Thing"], CHECK_RADIUS]);
