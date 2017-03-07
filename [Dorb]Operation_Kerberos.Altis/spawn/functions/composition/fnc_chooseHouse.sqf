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
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params [["_house",objNull,[objNull]],["_missionTargetType","",["",[]]]];
TRACEV_3(_this,_house,_missionTargetType);
If (isNull _house) exitWith {configNull;};
private _housetype = typeOf _house;
private _allConfigs = [];

IF (_missionTargetType isEqualTo "") then {
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "houses"),(format["getText(_x >> 'type') == '%1'",_housetype]),true];
}else{
    If (IS_STRING(_missionTargetType)) then {
        _missionTargetType = [_missionTargetType];
    }else{
        _missionTargetType =+ _missionTargetType;
    };
    private _condition = format["(getNumber(_x >> '%1')>0)",_missionTargetType deleteAt 0];
    {
        _condition = format["%1 || (getNumber(_x >> '%2')>0)",_condition,_x];
    } forEach _type;
    _condition = format["((getText(_x >> 'type') == '%1')&&{%2})",_housetype,_condition];
    TRACEV_3(_missionTargetType,_housetype,_condition);
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "houses"),_condition,true];
};
If (_allConfigs isEqualTo []) exitWith {configNull;};

selectRandom _allConfigs;
