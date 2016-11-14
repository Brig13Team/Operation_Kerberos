/*
 *  Author: Dorbedo
 *
 *  Description:
 *      chooses a housemacro from configfile
 *
 *  Parameter(s):
 *      0 : OBJECT - targethouse
 *
 *  Returns:
 *      CONFIG - the targetConfig
 *
 */
#include "script_component.hpp"

_this params [["_house",objNull,[objNull]]];

private _housetype = typeOf _house;

private _allConfigs = ((format["getText(_x >> 'type') == '%1'",_housetype]) configClasses (missionConfigFile >> "CfgCompositions" >> "houses"));

If (_allConfigs isEqualTo []) exitWith {configNull;};

selectRandom _allConfigs;
