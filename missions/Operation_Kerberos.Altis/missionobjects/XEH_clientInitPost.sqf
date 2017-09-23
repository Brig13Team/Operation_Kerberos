/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initPost of objects
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!hasInterface)

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

[QEGVAR(mission,MakeDataTerminalDraggable),{
    _this params ["_unit"];
    [_unit, true,[0,1,0],90] call ace_dragging_fnc_setDraggable;
}] call CBA_fnc_addEventHandler;

{
    [_x, true,[0,1,0],90] call ace_dragging_fnc_setDraggable;
} forEach (allMissionObjects "Land_DataTerminal_01_F");

/*
["Land_DataTerminal_01_F", "initpost", {
    TRACEV_1(_this);
    [_this select 0, true,[0,1,0],90] call ace_dragging_fnc_setDraggable;
},true,[],true] call CBA_fnc_addClassEventHandler;
*/
