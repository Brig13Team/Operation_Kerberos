/*
 *  Author: Dorbedo
 *
 *  Description:
 *      chooses a composition from configfile
 *
 *  Parameter(s):
 *      0 : STRING/ARRAY - possible type/types of compositions
 *
 *  Returns:
 *      CONFIG - the targetConfig
 *
 */
#include "script_component.hpp"

_this params [["_type" isEqualTo "","",[""]]];

private _allConfigs = [];

IF (_type isEqualTo "") then {
    _allConfigs = "(getNumber(_x >> 'isObective') == 0)" configClasses (missionConfigFile >> "CfgCompositions" >> "houses"));
}else{
    If (IS_STRING(_type)) then {_type = [_type];};
    private _condition = format["(getNumber(_x >> '%1')>0)",_type deleteAt 0];
    {
        _condition = format["%1 && (getNumber(_x >> '%2')>0)",_condition,_type deleteAt 0];
    } forEach _type;
    _condition = format["(%1)",_condition];
    _allConfigs = _condition configClasses (missionConfigFile >> "CfgCompositions" >> "houses"));
};
If (_allConfigs isEqualTo []) exitWith {configNull;};

selectRandom _allConfigs;
