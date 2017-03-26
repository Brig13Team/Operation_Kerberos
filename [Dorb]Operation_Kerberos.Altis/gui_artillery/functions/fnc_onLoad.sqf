/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
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

_this params ["_display"];


// create LB with current Artillery environemt-data
private _currentData = ctrlCreate ["RscListNBox",110101];
_listbox lnbAddColumn 0.6;
_listbox lnbSetColumnsPos [-0.01,0.6];
[_currentData] call FUNC(setArtilleryPropData);
_currentData ctrlSetPosition [
    x,
    y,
    w,
    h
];
_currentData ctrlCommit 0;

// create LB with current Ammunition data
private _currentData = ctrlCreate ["RscListNBox",110101];
_listbox lnbAddColumn 0.6;
_listbox lnbSetColumnsPos [-0.01,0.6];
[_currentData] call FUNC(setArtilleryAmmoData);
_currentData ctrlSetPosition [
    x,
    y,
    w,
    h
];
_currentData ctrlCommit 0;

// create input fields
// Use current position or input a position
private _ctrltext = ctrlCreate ["RscText",110110];
private _ctrltext = ctrlCreate ["RscCheckBox",110111];
// X-pos
private _ctrltext = ctrlCreate ["RscText",110110];
private _ctrltext = ctrlCreate ["RscEdit",110111];
// Y-pos
private _ctrltext = ctrlCreate ["RscText",110112];
private _ctrltext = ctrlCreate ["RscEdit",110113];
// altitude
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];


// weapon data
// shot angle
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];
// mils
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];
// ammunition
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscCombo",110115];
// charge
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscCombo",110115];
// fuse
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscCombo",110115];
// amount
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];

// Time to shoot
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];
// time
private _ctrltext = ctrlCreate ["RscText",110114];
private _ctrltext = ctrlCreate ["RscEdit",110115];
