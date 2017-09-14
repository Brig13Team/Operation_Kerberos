/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the ace-action to the class
 *
 *  Parameter(s):
 *      0 : STRING - Classname
 *      1 : SCALAR - Doornumber
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_house","",[""]],["_number",0,[0]]];

If (_number < 1) exitWith {};

for "_i" from 1 to _number do {

    private _action = [
        format[QGVAR(door_%1),_i],
        localize LSTRING(PLACE_CHARGE),
        "\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa",
        LINKFUNC(onAction),
        LINKFUNC(canPlaceCharge),
        {},
        [(format["door_%1",_i])],
        (getText(configFile >> "CfgVehicles" >> _house >> "AnimationSources" >> format["door_%1_sound_source",_i]  >> "soundPosition"))
    ] call ace_interact_menu_fnc_createAction;

    [_house,0,[],_action] call ace_interact_menu_fnc_addActionToClass;
};
