/*
	Author: Dorbedo

	Description:
	Selects random arraypos

	Parameter(s):
		0 :	ARRAY 
	Returns:
	Random array pos
*/
#include "script_component.hpp"
If(count _this < 1) exitwith {[]};
(_this) select floor random count (_this)