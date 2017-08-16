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
{
    private _vehicle = configName _x;
    private _position = getArray(_x >> "actionPosition");
    If (_position isEqualTo []) then {
        _position = [0,0,0];
    };
    TRACEV_2(_vehicle,_position);
    private _mainAction = [
        QGVAR(action_main),
        localize LSTRING(ANTENNA_ACTION_MAIN),
        "",
        {true},
        {true},
        {},
        [],
        _position
    ] call ace_interact_menu_fnc_createAction;

    private _connectAction = [
        QGVAR(action_connect),
        localize LSTRING(ANTENNA_ACTION_CONNECT),
        "",
        {true},
        {[_target] call FUNC(antenna_canConnect)},
        {[_target] call FUNC(antenna_addChildActions);},
        [],
        _position
    ] call ace_interact_menu_fnc_createAction;

    private _disconnectAction = [
        QGVAR(action_disconnect),
        localize LSTRING(ANTENNA_ACTION_DISCONNECT),
        "",
        {[_target] call FUNC(antenna_disconnect);},
        {[_target] call FUNC(antenna_canDisconnect)},
        {},
        [],
        _position
    ] call ace_interact_menu_fnc_createAction;

    private _actionPathMain = ["ACE_MainActions"];
    private _actionPath = ["ACE_MainActions",QGVAR(action_main)];

    If ((ace_interact_menu_ActNamespace getVariable [_vehicle,[]])isEqualTo []) then {
        _actionPathMain = [];
        _actionPath = [];
    };

    [_vehicle, 0, _actionPathMain, _mainAction,false] call ace_interact_menu_fnc_addActionToClass;
    [_vehicle, 0, _actionPath, _connectAction,false] call ace_interact_menu_fnc_addActionToClass;
    [_vehicle, 0, _actionPath, _disconnectAction,false] call ace_interact_menu_fnc_addActionToClass;
} forEach configProperties [(missionConfigFile >> "acre_antennaObjects"), "true", false];
