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
#include "makros.hpp"
private ["_pos","_start","_rad","_typ","_dir","_radx","_rady"];

_start = _this select 0;
_rad = _this select 1;
_typ = _this select 2;

switch _typ do {
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
	case 2 : {
		_generiere=true;
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
};
_pos