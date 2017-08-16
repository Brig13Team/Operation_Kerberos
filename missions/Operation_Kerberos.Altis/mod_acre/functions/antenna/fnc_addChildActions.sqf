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
TRACEV_3(_target,_player,_args);
private _radios = call acre_api_fnc_getCurrentRadioList;
private _actions = [];
{
    private _displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayname");
    TRACEV_2(_x,_displayName);
    private _action = [
        _x,
        _displayName,
        "",
        {_this call FUNC(antenna_connect);},
        {true},
        {},
        [_target,_x]
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action,[],_target];
} forEach (_radios select {!(([_x] call acre_sys_radio_fnc_getRadioBaseClassname) isEqualTo "ACRE_PRC343")});
TRACEV_2(_radios,_actions);
_actions;
