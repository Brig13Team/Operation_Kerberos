/*
 *  Author: Dorbedo
 *
 *  Description:
 *      called via PFH
 *
 *  Parameter(s):
 *      0 : ARRAY - PFH arguments
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

(_this select 0) params ["_house","_door","_democharges","_explosiontimeStamp"];

If ((_house animationPhase (_door + "_rot"))>0.1) exitWith {
    [_this select 1] call CBA_fnc_removePerFrameHandler;
    _house setVariable [format[QGVAR(%1),_door],nil,true];
    {deleteVehicle _x} forEach _democharges;
};

If (CBA_missiontime > _explosiontimeStamp) then {
    [_this select 1] call CBA_fnc_removePerFrameHandler;
    _house setVariable [format[QGVAR(%1),_door],nil,true];
    private _expPos = getPos (_democharges select 0);
    "MissileCore" createVehicle _expPos;
    playSound3D ["a3\sounds_f\weapons\explosion\expl_shell_1.wss",_house,false,_expPos];
    {deleteVehicle _x} forEach _democharges;
    _house animate [(_door + "_rot"),1,10];
};
