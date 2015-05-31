/*
	Author: Dorbedo
	
	Description:
	Type 0 : Nur Boden (inkl. Fahrzeuge)
	Type 1 : Nur Luft
	Type 2 : Nur Fahrzeuge
	
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"

_pos = _this select 0;
_type = [_this,1,0,[0]] call BIS_fnc_param;
_command_veh = [_this,2,objNull,[objNull]] call BIS_fnc_param;

_players = [];
_targets = [];
_return = [];

_players = call CBA_fnc_players;

switch (_type) do {
	case 0 : {
		{
			_level = dorb_side knowsAbout _x;
			If ((_level > (random 6))&&(_level != 0)&&(!((vehicle _x) isKindOf "Air"))) then {
				_player_pos = getPos _x;
				if ((_player_pos distance _pos) < 2000) then {
					_targets pushBack (_player_pos);
				};
			};
		}forEach _players;
	};
	case 1 : {
		{
			If ((vehicle _x) isKindOf "Air") then {
				_player_pos = getPosATL _x;
				if ((_player_pos distance _pos) < 5000) then {
					_targets pushBack (_player_pos);
				};
			};
		}forEach _players;
	};
	case 2 : {
		{
			_level = dorb_side knowsAbout _x;
			If ((_level > (random 6))&&(_level != 0)&&((vehicle _x) isKindOf "LandVehicle")) then {
				_player_pos = getPos _x;
				if ((_player_pos distance _pos) < 2000) then {
					_targets pushBack (_player_pos);
				};
			};
		}forEach _players;
	};
};
d_log(FORMAT_1("COMMANDVEH - CHECK - Targets=%1",_targets))

if ((count _targets)>0) then {
	_return = _targets call BIS_fnc_selectRandom;
};
_return