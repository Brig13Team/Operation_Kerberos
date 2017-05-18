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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _position = ASLtoAGL GVAR(curPos);
{
    private _veh = _x;
    if (((getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "vehicleClass"))isEqualTo "Autonomous")) then {
        {_veh deleteVehicleCrew _x} forEach crew _veh;
        deleteVehicle _veh;
    };
    { if(!(alive _x)) then { deleteVehicle _x; }; } forEach (crew _veh);
    if (count crew _x == 0) then {deletevehicle _x};
} forEach ((nearestObjects [_position, ["AllVehicles"], CHECK_RADIUS]) select {_x getVariable [QGVARMAIN(canDelete),true]});

{deletevehicle _x;} forEach ((nearestObjects [_position, ["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder","GroundWeaponHolder_scripted","allDead","Thing","Land_DataTerminal_01_F"], CHECK_RADIUS]) select {_x getVariable [QGVARMAIN(canDelete),true]});
