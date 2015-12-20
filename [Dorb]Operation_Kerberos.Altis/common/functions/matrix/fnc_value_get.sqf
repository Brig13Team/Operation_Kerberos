/*
    Author: Dorbedo

    Description:
        adds an value to a matrix

    Parameter(s):
        
        0 : STRING - name of matrix-variable
        1 : SCARLAR - X-Pos
        2 : SCARLAR - Y-Pos
        (optional)
        3 : NAMESPACE
    Return:
        BOOL
*/
#include "script_component.hpp"
SCRIPT(value_get);

_this params [
	["_variablename","",[""]],
	["_x_pos",0,[0]],
	["_y_pos",0,[0]],
	["_namespace",missionnamespace,[missionnamespace,profilenamespace,uinamespace]]
];

CHECKRET((_variablename isEqualTo ""),0);
private _variable = _namespace getVariable [_variablename,[]];

CHECKRET(((_variable isEqualTo [])||(_x_pos >= count _variable)||(_y_pos >= count(_variable select 0))),0);

private _temp = _variable select _x_pos;
(_temp select _y_pos)
