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

CHECK(!hasInterface)

//////FAHRZEUGSPAWNS
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"	+localize "STR_DORB_SPAWN_VEHICLE_DESC"	+"</t>",		{_this call dorb_fnc_spawn_ui_Open;}, [localize "STR_DORB_SPAWN_VEHICLE",	fahrzeuge	], 5, false, true, "","alive _target and (getposatl player distance getposatl fahrzeuge) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"	+localize "STR_DORB_SPAWN_DRONES_DESC"	+"</t>", 	{_this call dorb_fnc_spawn_ui_Open;}, [localize "STR_DORB_SPAWN_DRONES",	drohnen		], 5, false, true, "","alive _target and (getposatl player distance getposatl drohnen) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"	+localize "STR_DORB_SPAWN_AIR_DESC"		+"</t>", 	{_this call dorb_fnc_spawn_ui_Open;}, [localize "STR_DORB_SPAWN_AIR",		luftfahrzeuge	], 5, false, true, "","alive _target and (getposatl player distance getposatl luftfahrzeuge) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"	+localize "STR_DORB_SPAWN_WATER_DESC"	+"</t>", 	{_this call dorb_fnc_spawn_ui_Open;}, [localize "STR_DORB_SPAWN_WATER",		marine		], 5, false, true, "","alive _target and (getposatl player distance getposatl marine) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"	+localize "STR_DORB_SPAWN_LOGISTIC_DESC"	+"</t>", 	{_this call dorb_fnc_spawn_ui_Open;}, [localize "STR_DORB_SPAWN_LOGISTIC",	logistik		], 5, false, true, "","alive _target and (getposatl player distance getposatl logistik) < 4"];




/*
fahrzeuge addAction ["<t size='1.5' color=""#FF860F"">"+ localize "STR_DORB_SPAWN_VEHICLE_DESC"+"</t>", {_this call dorb_fnc_spawn_ui_Open,}, [localize "STR_DORB_SPAWN_VEHICLE"], 3, true, true, "","alive _target"];

drohnen addAction ["<t size='1.5' color=""#FF860F"">"+ localize "STR_DORB_SPAWN_DRONES_DESC"+"</t>", {_this call dorb_fnc_spawn_ui_Open,}, [localize "STR_DORB_SPAWN_DRONES"], 3, true, true, "","alive _target"];

luftfahrzeuge addAction ["<t size='1.5' color=""#FF860F"">"+ localize "STR_DORB_SPAWN_AIR_DESC"+"</t>", {_this call dorb_fnc_spawn_ui_Open,}, [localize "STR_DORB_SPAWN_AIR"], 3, true, true, "","alive _target"];

marine addAction ["<t size='1.5' color=""#FF860F"">"+ localize "STR_DORB_SPAWN_WATER_DESC"+"</t>", {_this call dorb_fnc_spawn_ui_Open,}, [localize "STR_DORB_SPAWN_WATER"], 3, true, true, "","alive _target"];

logistik addAction ["<t size='1.5' color=""#FF860F"">"+ localize "STR_DORB_SPAWN_LOGISTIC_DESC"+"</t>", {_this call dorb_fnc_spawn_ui_Open,}, [localize "STR_DORB_SPAWN_LOGISTIC"], 3, true, true, "","alive _target"];
*/

//{_x setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];}forEach [fahrzeuge,drohnen,luftfahrzeuge,logistik,marine];
/*
drohnen setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];
luftfahrzeuge setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];
marine setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];
fahrzeuge setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];
logistik setObjectTexture [0, "data\spawn\spawn_tablet_aus.jpg"];
*/