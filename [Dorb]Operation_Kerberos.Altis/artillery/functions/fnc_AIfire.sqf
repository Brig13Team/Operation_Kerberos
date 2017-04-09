/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_artillery","_shotVector","_amount","_weapon","_firemode","_reloadSpeed","_OnFinish"];


private _gunner = gunner _artillery;
_gunner setSkill ["ReloadSpeed",1];
_gunner setSkill ["aimingSpeed",1];
//_gunner disableAI "TARGET";
_gunner disableAI "AUTOTARGET";
_artillery setWeaponReloadingTime [_gunner, _weapon, 0];

private _relPos = ASLtoAGL((getPosASL _artillery) vectorAdd _shotVector);
TRACEV_4(getPosASL _artillery,getPos _artillery,_shotVector,_relPos);
_gunner doWatch _relPos;

private _shotDelay = [5];

for "_i" from 1 to _amount do {
    _shotDelay pushBack ((_shotDelay select ((count _shotDelay)-1)) + _reloadSpeed);
};
TRACEV_2(_shotDelay,_reloadSpeed);
{
    [
        {
            (_this select 0) fire [(_this select 1),(_this select 2),(_this select 3)];
        },
        [_artillery,_weapon,_firemode,_shelltype],
        _x
     ] call CBA_fnc_waitAndExecute;
} forEach _shotDelay;
TRACEV_4(((_shotDelay select ((count _shotDelay)-1)) + _reloadSpeed),_OnFinish,_artillery,_gunner);
[
    {
        ((_this select 1)select 1) doWatch objNull;
        (_this select 1) call (_this select 0);
    },
    [_OnFinish,[_artillery,_gunner]],
    ((_shotDelay select ((count _shotDelay)-1)) + _reloadSpeed)
] call CBA_fnc_waitAndExecute;
