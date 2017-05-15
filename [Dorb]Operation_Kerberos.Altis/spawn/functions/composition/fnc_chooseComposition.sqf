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
//#define DEBUG_MODE_OFF
#include "script_component.hpp"
TRACEV_1(_this);
_this params [["_type","",["",[]]],["_position",[],[[]],[2,3]]];

private _allConfigs = [];

IF (_type isEqualTo "") then {
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "positions"),"(getNumber(_x >> 'isObjective') == 0)",true];
}else{
    If (IS_STRING(_type)) then {
        _type = [_type];
    }else{
        _type =+ _type;
    };
    private _condition = format["(getNumber(_x >> '%1')==1)",_type deleteAt 0];
    {
        _condition = format["%1 || (getNumber(_x >> '%2')==1)",_condition,_x];
    } forEach _type;
    _condition = format["(%1)",_condition];
    _allConfigs = configProperties [(missionConfigFile >> "CfgCompositions" >> "positions"),_condition,true];
};
If (_allConfigs isEqualTo []) exitWith {configNull;};

selectRandom _allConfigs;
