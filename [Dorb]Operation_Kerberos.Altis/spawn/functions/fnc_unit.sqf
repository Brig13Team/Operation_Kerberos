/*
	Author: Dorbedo

	Description:
	spawns an single unit

	Parameter(s):
		0 : ARRAY 	- Position AGL (3D)
		1 : GROUP 	- Group
		2 : STRING 	- Unittyp
		(optional)
		3 : STRING	- special properties
		4 : SCALAR	- Direction

	Returns:
	Object
*/
#include "script_component.hpp"
SCRIPT(Unit);
params[["_position",[],[[]],[2,3]],["_group",grpNull,[grpNull]],["_type","",[""]],["_special","NONE",[""]],["_direction",(random 360),[0]]];
TRACEV_4(_position,_group,_type,_direction);
private "_unit";
If((_position isEqualTo [])||(isNull _group)||(_type isEqualTo "")) exitWith {objNull};
_unit = _group createUnit [_type,_position, [], 0, _special];
_unit setDir _direction;
_unit

