/**
 * Author: Dorbedo
 * set the skill for ai-units
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if ((!local _unit) || {isPlayer _unit} || {!(_unit in allUnits)} || {!GVAR(active)}) exitWith {};

_unit setSkill ["general", GVAR(general)];
_unit setSkill ["commanding", GVAR(general)];
_unit setSkill ["courage", GVAR(general)];
_unit setSkill ["aimingAccuracy", GVAR(accuracy)];
_unit setSkill ["aimingShake", GVAR(handling)];
_unit setSkill ["aimingSpeed", GVAR(handling)];
_unit setSkill ["reloadSpeed", GVAR(handling)];
_unit setSkill ["spotDistance", GVAR(spotting)];
_unit setSkill ["spotTime", GVAR(spotting)];
