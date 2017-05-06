/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the initPost Eventhandler
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


["BWA3_Puma_base", "initPost", {
    [BWA3_fnc_symbol,[_this select 0,1,13]] call CBA_fnc_execNextFrame;
    },true,[],true] call CBA_fnc_addClassEventHandler;
["BWA3_Leopard_base", "initPost", {
    [BWA3_fnc_symbol,[_this select 0,1,13]] call CBA_fnc_execNextFrame;
    },true,[],true] call CBA_fnc_addClassEventHandler;
["BWA3_Eagle_base", "initPost", {
    [BWA3_fnc_symbol,[_this select 0,1,13]] call CBA_fnc_execNextFrame;
    },true,[],true] call CBA_fnc_addClassEventHandler;
