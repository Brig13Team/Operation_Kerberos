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

_this params [["_house",objNull,[objNull]],["_missionTargetType","",[""]]];

If (isNull _house) exitWith {configNull;};
private _housetype = typeOf _house;
private _allConfigs = [];

If !(_missionTargetType isEqualTo [""]) then {
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "houses"),(format["((getText(_x >> 'type') == '%1')&&(getNumber(_x >> 'hasmissiontarget')>0))",_housetype]),true];
}else{
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "houses"),(format["getText(_x >> 'type') == '%1'",_housetype]),true];
};
//TRACEV_4(_house,_housetype,_isMissiontarget,_allConfigs);
If (_allConfigs isEqualTo []) exitWith {configNull;};

selectRandom _allConfigs;
