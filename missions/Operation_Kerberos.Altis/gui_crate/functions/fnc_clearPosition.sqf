/**
 * Author: Dorbedo
 * clear the spawnPosition
 *
 * Arguments:
 * 0: <ARRAY> SpawnPosition
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_position",GVAR(curPos),[[]],[3]]];
_position = ASLtoAGL _position;

{
    private _veh = _x;
    if (([typeOf _veh,"vehicleClass",""] call EFUNC(common,getCfgVehicles)) isEqualTo "Autonomous") then {
        {_veh deleteVehicleCrew _x} forEach crew _veh;
    };
    { if(!(alive _x)) then {deleteVehicle _x;}; } forEach (crew _veh);
    if (count crew _x == 0) then {
        [QGVAR(deletedVehicle),[ace_player, typeOf _vehicle]] call CBA_fnc_ServerEvent;
        deleteVehicle _x;
    };
} forEach ((nearestObjects [_position, ["AllVehicles","ReammoBox_F"], CLEAR_RADIUS]) select {_x getVariable [QGVARMAIN(canDelete),true]});

{
    deletevehicle _x;
} forEach ((nearestObjects [_position, ["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder","GroundWeaponHolder_scripted","allDead","Thing","Land_DataTerminal_01_F"], CLEAR_RADIUS]) select {_x getVariable [QGVARMAIN(canDelete),true]});
