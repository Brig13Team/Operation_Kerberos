/*
	Author: Dorbedo
	
	Description:
		Adds Action to Teleporter
	
*/
#include "makros.hpp"

CHECK(!hasInterface)


player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter) < 6"];
player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter2) < 6"];
player addAction ["<t size='1.5' shadow='2' color='#F9FE44'>" +localize "STR_DORB_TELEPORT" +"</t>", {createDialog "dorb_teleporter";}, [], 5, false, true, "","alive _target and (getposatl player distance getposatl teleporter3) < 6"];



/*
{
	_x addAction ["<t size='1.5' shadow='2' color='#800000'>"+localize "STR_DORB_TELEPORT"+"</t> <img size='3' color='#ff0000' shadow='2' image='data\icon\icon_teleport.paa'/>",{createDialog "dorb_teleporter";},[]];
}forEach [teleporter,teleporter2,teleporter3];*/