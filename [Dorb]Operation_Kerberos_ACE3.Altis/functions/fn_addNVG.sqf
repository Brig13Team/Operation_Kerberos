/*
	Author: Dorbedo
	
	Description:
		Adds NVG to Unit
	
*/

_this spawn {
	#include "script_component.hpp"
	PARAMS_1(_unit);
	CHECK("NVGoggles_OPFOR" in (items _unit))
	_unit additem "NVGoggles_OPFOR";
	CHECK(!("NVGoggles_OPFOR" in (items _unit)))
	_unit assignItem "NVGoggles_OPFOR";
};