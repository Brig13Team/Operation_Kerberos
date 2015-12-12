/*
    Author: Dorbedo
    
    Description:
        supression fired EH
    
    Parameter(s):
    

    Return
        none
*/
#include "script_component.hpp"
SCRIPT(EH_fired);
_this params ["_unit","_weapon","_muzzle","_mode","_ammo","_projectile","_magazine"];
CHECK(((_unit distance player)>2000)||((side effectiveCommander (vehicle _unit)) == playerside))
CHECK((_weapon in ["_throw","_put"])||(isNil "_projectile"))
private "_hit";
_hit = getNumber(configfile>>"CfgAmmo">>_ammo>>"hit");
CHECK(_hit == 0)
[{_this call FUNC(suppression_handle_fired)}, 0, [_projectile, _hit] ] call CBA_fnc_addPerFrameHandler;    