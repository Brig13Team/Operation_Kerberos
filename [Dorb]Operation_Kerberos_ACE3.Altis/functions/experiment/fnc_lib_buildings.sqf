/*
	Author: Dorbedo
	
	Description:
		Creates a Libary with all Buildings
	
	Parameter(s):
		none
		
*/
#include "script_component.hpp"


/*
Vorraussetzung: Object muss gespawnt sein

- Größe via boundingBoxReal und boundingCenter
- Direction immer 0 (Nord)
- Positionen für einzelne Soldaten im Gebäude (Abhängig von Bounding-Center)
- Positionen für statische Waffen (Freies Dach, sowie Sicht)
- Türen (Zentrum der Tür sowie richtung) für Tripwires



Zielarray

[configname	,	boundingCenter , boundingBoxReal , soldierpos, doors]


soldierpos:
	- [x,y,z]
	- dir1 ()
	- dir2 ()
		- dir: -1 disabled
	- level
		0: indoor
		1: indoor, static possible (no AT, no AA)
		2: open
		3: open, static possible

formation für output:
struct buildings *buildingname*;
*buildingname*.centerpos = {x,y,z};
*buildingname*.boundingBox = {{x,y,z},{x,y,z}};
*buildingname*.soldierpos = {{x,y,z,dir1,dir2,level},...};
*buildingname*.doorpos = {{x,y,z,dir},...};



*/

/// Filter


_cfgvehicles = configFile >> "cfgvehicles";


for "_i" from 0 to (count _cfgvehicles)-1  do {
	_vehicle	= _cfgvehicles select _i;
	if (isClass _vehicle) then {	
		_class 		= configName(_vehicle);
		_genMac 	= getText(configFile >> "cfgvehicles" >> _class >> "_generalMacro");
		_vClass 	= getText(configFile >> "cfgvehicles" >> _class >> "vehicleClass");
		_DName 		= getText(configFile >> "cfgvehicles" >> _class >> "displayName");
		_roles 		= getText(configFile >> "cfgvehicles" >> _class >> "availableForSupportTypes");
		_weapons 	= getText(configFile >> "cfgvehicles" >> _class >> "weapons");
		_magazines 	= getText(configFile >> "cfgvehicles" >> _class >> "magazines");
		_type 		= getText(configFile >> "cfgvehicles" >> _class >> "textSingular");
		_faction 	= getText(configFile >> "cfgvehicles" >> _class >> "faction");
		_side	 	= getnumber(configFile >> "cfgvehicles" >> _class >> "side");
		_pic 		= getText(configFile >> "cfgvehicles" >> _class >> "picture");
		_icon 		= getText(configFile >> "cfgvehicles" >> _class >> "Icon");
		_Desc 		= getText(configFile >> "cfgvehicles" >> _class >> "Library" >> "libTextDesc");
		_autor 		= getText(configFile >> "cfgvehicles" >> _class >> "author");
	
	
	
	
	
	};
};












///// Output
Private["_br","_output","_i"];
_br = toString [0x0D, 0x0A]; 
_output = "";

{
	_output = _output + _br
	+ format["struct buildings %1",_x select 0] + _br
	+ format["%1.centerpos = {%2,%3,%4};",_x select 0,(_x select 1) select 0,(_x select 1) select 1,(_x select 1) select 2] + _br
	+ format["%1.boundingBox = {{%2,%3,%4},{%5,%6,%7}};",_x select 0,((_x select 2)select 0)select 0,((_x select 2)select 0)select 1,((_x select 2)select 0)select 2,((_x select 2)select 1)select 0,((_x select 2)select 1)select 1,((_x select 2)select 1)select 2] + _br;
	For "_i" from 0 to (count(_x select 3)) do {
		_output = _output + format["%1.soldierpos = {%2,%3,%4,%5,%6,%7};",(((_x select 3)select _i)select 0),(((_x select 3)select _i)select 1),(((_x select 3)select _i)select 2),(((_x select 3)select _i)select 3),(((_x select 3)select _i)select 4),(((_x select 3)select _i)select 5)] + _br;
	};
	For "_i" from 0 to (count(_x select 4)) do {
		_output = _output + format["%1.doorpos = {%2,%3,%4,%5};",(((_x select 4)select _i)select 0),(((_x select 4)select _i)select 1),(((_x select 4)select _i)select 2),(((_x select 4)select _i)select 3)] + _br;
	};
}forEach _buildingsarray;

copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";