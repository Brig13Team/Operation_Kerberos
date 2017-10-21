/**
 * Author: Dorbedo
 * adds an App to the Main menu and adds the ace-actions
 *
 * Arguments:
 * 0: <STRING> display Name
 * 1: <STRING> categorie
 * 2: <STRING> Picture Path
 * 3: <CODE> code called on choosing the app
 * 4: <CODE> condition to allow the activation
 * 5: <ARRAY> Parameter
 * 6: <BOOL> prevent the creation of a ace-action (default: false)
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(hasInterface) exitWith {};

params [
    ["_displayName", "", [""]],
    ["_categorie", "NONE", [""]],
    ["_picture", "", [""]],
    ["_function", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_parameter", []],
    ["_color", "randomMetro", ["",[]],[3,4]],
    ["_preventAction", false, [true]]
];
TRACEV_3(_displayName,_categorie,_picture);
If (isLocalized _displayName) then {
    _displayName = localize _displayName;
};

If (isLocalized _categorie) then {
    _categorie = localize _categorie;
};

// add to the metro-view
private _temp = GVAR(Applications) getVariable [_categorie, []];
_temp pushBack [_displayName, _picture, _function, _condition, _parameter,[_color] call EFUNC(gui,getColor)];
GVAR(Applications) setVariable [_categorie, _temp];

// register the ace-action
If (_preventAction) exitWith {};
private _ACE_Action = [
    format [QGVAR(Action_%1_%2), _categorie, count _temp],
    _displayName,
    _picture,
    _function,
    _condition,
    {},
    _parameter
] call ACE_interact_menu_fnc_createAction;
[ace_player, 1, ["ACE_SelfActions", QGVAR(selfactiongroup)], _ACE_Action] call ACE_interact_menu_fnc_addActionToObject;
