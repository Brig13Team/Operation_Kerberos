/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(canDisable);
#define EMP_RANGE 5000
_this params ["_target"];

ISNILS(GVAR(device_intervall),CBA_missionTime);

If (GVAR(device_intervall)>CBA_missionTime) exitWith {};

{
    _x setHitPointDamage ["hitEngine", 1];
    _x setHitPointDamage ["HitStarter1", 1];
    
    _x setHitPointDamage ["hitEngine2", 1];
    _x setHitPointDamage ["HitStarter2", 1];
    
    _x setHitPointDamage ["hitEngine3", 1];
    _x setHitPointDamage ["HitStarter3", 1];
    
    _x setHitPointDamage ["HitBatteries", 1];
} forEach ((getPos _target) nearEntities [["Air","LandVehicle"],EMP_RANGE]);



[_target] call EFUNC(tfar_addon,disableTFRArea);

GVAR(earthquake_nextIntervall) = 7 * 60 + (floor(random 3)) * 60;
