/*
	Author: Dorbedo

	Description:
	spawns an group

	Parameter(s):
		0 : ARRAY 			- Position AGL (3D)
		1 : STRING or CONFIG	- Groupname
		

	Returns:
	Object
*/
#include "script_component.hpp"
SCRIPT(group);
params[["_position",[],[[]],[2,3]],["_type","",["",configfile]]];
TRACEV_2(_position,_type);
CHECK((_position isEqualTo []))
CHECK((IS_STRING(_type))&&{_type isEqualTo ""})
private["_types","_ranks","_positions"];
_types = [];
_ranks = [];
_positions = [];
If (IS_CONFIG(_type)) then {
	for "_i" from 0 to ((count _chars) - 1) do {
		private ["_item"];
		_item = _chars select _i;
		if (isClass _item) then {
			_types = _types + [getText(_item >> "vehicle")];
			_ranks = _ranks + [getText(_item >> "rank")];
			_positions = _positions + [getArray(_item >> "position")];
		};
	};
	_group = switch (getNumber(configFile >> "CfgVehicles" >> _x >> "side")) do {
		case 0 : {createGroup east};
		case 1 : {createGroup west};
		case 2 : {createGroup resistance};
		default {createGroup GVARMAIN(side)};
	};
}else{
	private "_path";
	_path = (missionConfigFile >> "unitlists" >> GVARMAIN(side) >> GVARMAIN(side_string));
	if (isClass (_path >> _type)) then {
		_types = getArray(_path>>_type>>"vehicles");
		_ranks = getArray(_path>>_type>>"ranks");
		_positions = getArray(_path>>_type>>"positions");
	};
	_group = createGroup GVARMAIN(side);
};

CHECK(_types isEqualTo []);
{
	private ["_isMan","_spawnpos"];
	_isMan = getNumber(configFile >> "CfgVehicles" >> _x >> "isMan") == 1;
	If ((count _positions)>(_forEachIndex)) then {
		_spawnpos = = [(_position select 0) + ((_positions select (_forEachIndex-1)) select 0), (_position select 1) + ((_positions select (_forEachIndex-1)) select 1)];
	}else{
		_spawnpos=_position;
	};
	If (_isMan) then {
		_unit = [_spawnpos,_group,_x,"FORM",_direction] call FUNC(unit);
	}else{
		_unit = ([_spawnpos,_group,_x,_direction,true,true,"FORM"] call FUNC(unit))select 1;
	};
	if ((count _ranks) > _forEachIndex) then {
		[_unit,_ranks select _i] call bis_fnc_setRank;
	};
	
	
}forEach _types

_group