/*
    Author: Dorbedo

    Description:
        sets an Array with Variables

    Parameter(s):
        ARRAY - Array with Variables ["Varname",value,namespace/object,public];
        ARRAY - Array with Array with Variables [["Varname",value,namespace/object,public],["Varname",value,namespace/object,public],...];
    Returns:
        none
*/
#include "script_component.hpp"

If (IS_STRING(_this select 0)) exitWith {
    _this params[["_name","",[""]],["_value",[]],["_namespace",missionnamespace,[missionnamespace,controlNull,objNull,grpnull,taskNull]],["_public",false,[true]]];
    If !(_name isEqualTo "") then {
        _temp pushBack [_name,_value,_namespace,_public];
        GVAR(setVarSyncArray) append _temp;
    };
    nil;
};
private _temp=[];
{
    _x params[["_name","",[""]],["_value",[]],["_namespace",missionnamespace,[missionnamespace,controlNull,objNull,grpnull,taskNull]],["_public",false,[true]]];
    If !(_name isEqualTo "") then {
        _temp pushBack [_name,_value,_namespace,_public];
    };
}forEach _this;
if !(_temp isEqualTo []) then {
    GVAR(setVarSyncArray) append _temp;
};
nil;