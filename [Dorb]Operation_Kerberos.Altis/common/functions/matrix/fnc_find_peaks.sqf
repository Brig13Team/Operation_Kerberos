/*
	Author: Dorbedo

	Description:
		finds peaks in a matrix

	Parameter(s):
		
		0 : STRING - Variable name
		(optional)
		1 : NAMESPACE - Namepace
	
	Return:
		ARRAY - [[value,x,y], ... ]
*/
#include "script_component.hpp"
SCRIPT(find_peaks);
#define MAXIMACOUNT 5

_this params [["_variablename","",["",[]]],["_namespace",missionnamespace,[missionnamespace,profilenamespace,uinamespace]]];

Private ["_matrix"];

if (IS_STRING(_variablename)) then {
	If !(_variablename isEqualTo "") then {
		_matrix = _namespace getVariable [_variablename,[]];
	}else{
		_matrix = [];
	};
}else{
	_matrix = _variablename;
};

If ((_matrix isEqualTo [])) exitWith {false};
private ["_x_size","_y_size","_maxima","_last_maxima","_temp"];
_x_size = count (_variable);
If (_x_size == 0) exitWith {false};
_y_size = count (_variable select 0);
If (_y_size == 0) exitWith {false};

_maxima=[];
for "_i" from 0 to MAXIMACOUNT do {
	_maxima pushBack [0,0,0];
};

for "_x" from 0 to (_x_size-1) do {
	_maxima sort false;
	_maxima resize MAXIMACOUNT;
	_last_maxima = (_maxima select 4)select 0;
	for "_y" from 0 to (_y_size) do {
		_temp = ((_matrix select _x)select _y)+(if(_x>0)then{((_matrix select (_x-1))select _y)}else{0})+(if(_y>0)then{((_matrix select (_x))select (_y-1))}else{0})+(if(_x<(_x_size-1))then{((_matrix select (_x+1))select _y)}else{0})+(if(_y<(_y_size-1))then{((_matrix select (_x))select (_y+1))}else{0});
		if ((_temp>_last_maxima)&&{!([_temp,_x,_y] in _maxima)}) then {
				_maxima pushBack [_temp,_x,_y];
		};
	};
};

for "_y" from 0 to (_y_size-1) do {
	_maxima sort false;
	_maxima resize MAXIMACOUNT;
	_last_maxima = (_maxima select 4)select 0;
	for "_x" from 0 to (_x_size-1) do {
		_temp = ((_matrix select _x)select _y)+(if(_x>0)then{((_matrix select (_x-1))select _y)}else{0})+(if(_y>0)then{((_matrix select (_x))select (_y-1))}else{0})+(if(_x<(_x_size-1))then{((_matrix select (_x+1))select _y)}else{0})+(if(_y<(_y_size-1))then{((_matrix select (_x))select (_y+1))}else{0});
		if ((_temp>_last_maxima)&&{!([_temp,_x,_y] in _maxima)}) then {
				_maxima pushBack [_temp,_x,_y];
		};
	};
};

_maxima sort false;
_maxima resize MAXIMACOUNT;
	
_maxima
