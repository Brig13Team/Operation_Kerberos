/*
	Author: Dorbedo

	Description:
	
	
*/
#include "makros.hpp"

CHECK(!hasInterface)

player addAction ["<t size='1.5' shadow='2' color='#FF860F'>" +localize "STR_DORB_CRATE_HEADER" +"</t>", {[]call dorb_fnc_crate_OpenMenu;}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl cratespawner) < 4"];