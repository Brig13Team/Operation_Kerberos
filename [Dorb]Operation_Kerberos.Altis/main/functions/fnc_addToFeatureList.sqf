/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds a featrue description
 *
 *  Parameter(s):
 *      0 : CONFIG - feature configpath
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


CHECK(!hasInterface)

_this params ["_cfgArray","_componentName"];
private _unit = player;


If !(_unit diarySubjectExists QGVAR(featureSubject)) then {
    _unit createDiarySubject [QGVAR(featureSubject),localize LSTRING(FEATURES)];
    _unit createDiaryRecord [QGVAR(featureSubject),["Credits",format["Authors: %1<br />Contributors: %2<br /><br />This Mod uses Code from:<br />  - ACE3 (https://github.com/acemod/ACE3)<br />  - CBA_A3 (https://github.com/CBATeam/CBA_A3)<br />  - ACRE2 (https://github.com/IDI-Systems/acre2)",localize LSTRING(AUTHOR),localize LSTRING(SUPPORTER)]]];
};
private _list = "<br />------------------------------------------------------------------------------------------<br />";
{
    _list = _list + ((getText(_x)));
    _list = _list + "<br />------------------------------------------------------------------------------------------<br />";
} forEach _cfgArray;

_unit createDiaryRecord [QGVAR(featureSubject), [format["Component: %1",_componentName],_list]];
