/*
	Author: Dorbedo

	Description:
		clears a matrix

	Parameter(s):
		
		0 : STRING - name of matrix-variable
		(optional)
		1 : SCALAR - value
		2 : NAMESPACE
	Return:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(value_add);

_this params [["_variablename","",[""]],["_value",0,[0]],["_namespace",missionnamespace,[missionnamespace,profilenamespace,uinamespace]]];
private ["_variable"];

If ((_variablename isEqualTo "")) exitWith {false};
_variable = _namespace getVariable [_variablename,[]];

If ((_variable isEqualTo [])) exitWith {false};
private ["_x_size","_y_size"];
_x_size = count (_variable);
If (_x_size == 0) exitWith {false};
_y_size = count (_variable select 0);
If (_y_size == 0) exitWith {false};

_variable = [_x_size,_y_size,_value] call FUNC(matrix_create);

missionnamespace setVariable [_variablename,_variable];
true
