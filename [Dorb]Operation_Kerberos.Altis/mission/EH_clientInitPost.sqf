/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initPost of objects
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


["CAManBase", "initpost", {
    [_this select 0, true,[0,1,0],90] call ace_dragging_fnc_setDraggable;
},true,[],true] call CBA_fnc_addClassEventHandler;
