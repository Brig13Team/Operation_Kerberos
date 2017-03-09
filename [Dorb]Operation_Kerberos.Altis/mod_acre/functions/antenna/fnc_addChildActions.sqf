/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the radios as child actions to the interact menu
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

_this params ["_target", "_player", "_args"];

private _radios = call acre_api_fnc_getCurrentRadioList;

{
    
} forEach _radios



//
