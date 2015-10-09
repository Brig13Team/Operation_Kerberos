/*
	Author: Dorbedo
	
	Description:
		sets an Array with Variables
	
	Parameter(s):
		ARRAY - Array with Variables ["Varname",value,namespace/object,public];

	Returns:
		none
*/
#include "script_component.hpp"
private["_temp"];
_temp=[];
{
	_x params[["_name","",[""]],["_value",[]],["_namespace",missionnamespace,[missionnamespace,controlNull,objNull,grpnull,taskNull]],["_public",false,[true]]];
	If !(_name isEqualTo "") then {
		_temp pushBack [_name,_value,_namespace,_public];
	};
}forEach _this;

GVAR(setVarSyncArray) append _temp;