/*
	Author: Dorbedo

	Description:
		adds Action to spawner
	
	
*/
#include "script_component.hpp"
SCRIPT(ui_crate_addAction);
CHECK(!hasInterface)
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>" +localize "STR_DORB_CRATE_HEADER" +"</t>", {[]call FM(ui_crate_OpenMenu);}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl cratespawner) < 4"];