/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Client postInit - antenna actions
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!hasInterface)
CHECK(!isClass(missionConfigFile >> "acre_antennaObjects"))

private _mainAction = [
    QGVAR(Antenna_actionmain),
    localize LSTRING(ANTENNA_ACTION_MAIN),
    "",
    {true},
    {true}
] call ace_interact_menu_fnc_createAction;


private _connectAction = [
    QGVAR(action_connect),
    localize LSTRING(ANTENNA_ACTION_CONNECT),
    "",
    {true},
    {[_target] call FUNC(antenna_canDisconnect)},
    {[_target] call FUNC(antenna_addChildActions);}
] call ace_interact_menu_fnc_createAction;

private _disconnectAction = [
    QGVAR(action_disconnect),
    localize LSTRING(ANTENNA_ACTION_DISCONNECT),
    "",
    {[_target] call FUNC(antenna_disconnect);},
    {[_target] call FUNC(antenna_canDisconnect)}
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _mainAction] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _connectAction] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _disconnectAction] call ace_interact_menu_fnc_addActionToClass;
