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
SCRIPT(clear);

_this params [["_variablename","",[""]],["_value",0,[0]],["_namespace",missionnamespace,[missionnamespace,profilenamespace,uinamespace]]];

CHECKRET(((_variablename isEqualTo "")),false);
private _variable = _namespace getVariable [_variablename,[]];

CHECKRET((_variable isEqualTo []),false);
private _x_size = count (_variable);
CHECKRET((_x_size == 0),false);
private _y_size = count (_variable select 0);
CHECKRET((_y_size == 0),false);

_variable = [_x_size,_y_size,_value] call FUNC(matrix_create);

missionnamespace setVariable [_variablename,_variable];
true
