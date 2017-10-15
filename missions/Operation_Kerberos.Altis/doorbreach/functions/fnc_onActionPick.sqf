/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onActionCalled
 *
 *  Parameter(s):
 *      0 : OBJECT - house
 *      1 : OBJECT - caller
 *      2 : STRING - Animation
 *
 *  Returns:
 *     none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params ["_house","_caller","_door"];

_door = _door select 0;
_house setVariable [format[QGVAR(%1),_door],true,true];

[
    PICK_TIMER,
    _this,
    {
        (_this select 0) params ["_house","_caller","_door"];
        _door = _door select 0;
        _house setVariable [format[QGVAR(%1),_door],nil,true];
        _house animate [(_door + "_rot"),1,1];
    },
    {
        (_this select 0) params ["_house","_caller","_door"];
        _door = _door select 0;
        _house setVariable [format[QGVAR(%1),_door],nil,true];
    },
    localize LSTRING(PICKING_LOCK)
] call ACE_common_fnc_progressBar;
