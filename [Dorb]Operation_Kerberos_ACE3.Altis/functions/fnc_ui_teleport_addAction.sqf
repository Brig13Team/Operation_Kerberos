/*
	Author: Dorbedo
	
	Description:
		Adds Action to Teleporter
	
*/
#include "script_component.hpp"

CHECK(!hasInterface)


player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter) < 6"];
player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter2) < 6"];
player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter3) < 6"];