/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "makros.hpp"
//Automatically adds various actions to specified vehicles

vehicleaddaction_AmmoBoxes_Array = [];
vehicleaddaction_Supported_AmmoBoxes = ["Box_NATO_AmmoVeh_F"];

while {true} do 
{
		
	{
		if !(_x in vehicles) then
		{
			vehicleaddaction_AmmoBoxes_Array = vehicleaddaction_AmmoBoxes_Array - [_x];
		};
	} forEach (vehicleaddaction_AmmoBoxes_Array);
	
	{
		
		if (((typeOf _x) in (vehicleaddaction_Supported_AmmoBoxes)) and !(_x in vehicleaddaction_AmmoBoxes_Array)) then
		{
			vehicleaddaction_AmmoBoxes_Array = vehicleaddaction_AmmoBoxes_Array + [_x];
			_x addaction ["<t size='1.5' shadow='2' color='#ffffff'>"+localize "STR_DORB_ARSENAL_OPEN_DESC"+"</t>", { ["Open",true] call BIS_fnc_arsenal; }, [], 1, false, true, "","alive _target"];
			
		};
		
	} forEach (vehicles);
	
	sleep 30;
	
}