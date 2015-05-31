/*
	Author: Dorbedo

	Description:
	
	
*/
#include "script_component.hpp"

CHECK(!hasInterface)

player addAction ["<t size='1.5' shadow='2' color='#FF860F'>" +localize "STR_DORB_CRATE_HEADER" +"</t>", {[]call FM(crate_OpenMenu);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl cratespawner) < 4"];