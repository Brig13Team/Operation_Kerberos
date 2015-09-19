/*
	Author: Dorbedo

	Description:
	Random Position

	Parameter(s):
		0 :	ARRAY	- Posistion
		1 : NUMBER 	- Radius
		2 : NUMBER	- Typ
		

	Returns:
	Position
*/
#include "script_component.hpp"
SCRIPT(random_pos);
private ["_pos","_dir","_radx","_rady","_generiere"];
_this params [["_start",[],[[]],[2,3]],["_rad",200,[0]],["_typ",-1,[0]]];
TRACE_3(_start,_rad,_typ);

switch _typ do {
	// in radius
	case 0 : {
		_rad = floor(random _rad);
		_generiere=true;
		while {_generiere} do {
	
			_dir = random 360;
			_radx = (cos _dir) * _rad;
			_rady = (sin _dir) * _rad;
			
			_radx = _radx + (_start select 0);
			_rady = _rady + (_start select 1);
			
			_pos=[_radx,_rady,0];
			
			If (!(surfaceIsWater [_radx,_rady])) then {_generiere=false};
	
		};
	};
	// at Radius
	case 1 : {
		_generiere=true;
		while {_generiere} do {
	
			_dir = random 360;
			_radx = (cos _dir) * _rad;
			_rady = (sin _dir) * _rad;
			
			_radx = _radx + (_start select 0);
			_rady = _rady + (_start select 1);
			
			_pos=[_radx,_rady,0];
			
			If (!(surfaceIsWater [_radx,_rady])) then {_generiere=false};
	
		};
	};
	// with distance to player
	case 2 : {
		_generiere=true;
		private "_players";
		_players=[];
		while {_generiere} do {
	
			_dir = random 360;
			_radx = (cos _dir) * _rad;
			_rady = (sin _dir) * _rad;
			
			_radx = _radx + (_start select 0);
			_rady = _rady + (_start select 1);
			
			_pos=[_radx,_rady,0];
			
			_players = call CBA_fnc_players;
			{
				If ((!(surfaceIsWater [_radx,_rady]))and ((_x distance _pos)>1500)) exitWith {_generiere=false};
			}forEach _players;
		};
	};
	//Water
	case 3 : {
		_generiere=true;
		private["_max_run"];
		_max_run = 3000;
		while {(_generiere && (_max_run>0))} do {
			_rad = floor(random _rad);
			_dir = random 360;
			_radx = (cos _dir) * _rad;
			_rady = (sin _dir) * _rad;
			
			_radx = _radx + (_start select 0);
			_rady = _rady + (_start select 1);
			
			_pos=[_radx,_rady,0];
			
			If ((surfaceIsWater [_radx,_rady])) then {_generiere=false};
			DEC(_max_run);
		};
		If (_max_run<1) then {_pos=[];};
	};
};
_pos