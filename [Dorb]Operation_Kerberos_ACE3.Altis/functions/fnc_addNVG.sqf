/*
	Author: Dorbedo
	
	Description:
		Adds NVG to Unit
	
*/

_this spawn {
	#include "script_component.hpp"
	PARAMS_1(_unit);
	CHECK(!local _unit)
	CHECK(isPlayer _unit)
	If (side _unit == east) exitWith {
		CHECK("NVGoggles_OPFOR" in (items _unit))
		_unit additem "NVGoggles_OPFOR";
		CHECK(!("NVGoggles_OPFOR" in (items _unit)))
		_unit assignItem "NVGoggles_OPFOR";
	};
	If (side _unit == resistance) exitWith {
		CHECK("NVGoggles_INDEP" in (items _unit))
		_unit additem "NVGoggles_INDEP";
		CHECK(!("NVGoggles_INDEP" in (items _unit)))
		_unit assignItem "NVGoggles_INDEP";	
	};
	If (side _unit == west) exitWith {
		CHECK("NVGoggles" in (items _unit))
		_unit additem "NVGoggles";
		CHECK(!("NVGoggles" in (items _unit)))
		_unit assignItem "NVGoggles";
	};
};