/*
 *  Author: Dorbedo
 *
 *  Description:
 *      player can connect his radio to an Antenna
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

_this params [["_target",objNull,[objNull]]];

If !(isNull(_target getVariable [QGVAR(externalAntenna),objNull])) exitWith {false;};

private _currentRadios = call acre_api_fnc_getCurrentRadioList;
_currentRadios = _currentRadios apply {[_x] call acre_sys_radio_fnc_getRadioBaseClassname;};
_currentRadios = _currentRadios - ["ACRE_PRC343"];

If (_currentRadios isEqualTo []) exitWith {false;};

private _condition = getText(missionConfigFile >> "acre_antennaObjects" >> typeOf _target >> "condition");
If (_condition isEqualTo "") exitWith {true};
call compile _condition;
