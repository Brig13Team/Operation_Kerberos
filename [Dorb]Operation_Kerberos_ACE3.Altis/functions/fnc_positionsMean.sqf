/*
	Author: Dorbedo

	Description:
		return artimetic mean of an array of points

	Parameter(s):
		0 :	ARRAY	- Array with Positions

	Returns:
	ARRAY : Array with Centerposition

	
*/

private ["_positionsarray","_all_x","_all_y","_all_z","_x","_y","_z","_currentpos","_return"];
SCRIPT(positionsMean);
_positionsarray = [_this,0,[],[[]]] call BIS_fnc_Param;

If (_positionsarray isEqualTo []) exitWith {[]};
_all_x = [((_positionsarray select 0) select 0)];
_all_y = [((_positionsarray select 0) select 1)];
If ((count(_positionsarray select 0))>2) then {
	_all_z = [((_positionsarray select 0) select 2)];
}else{_all_z=[0]};

for "_i" from 1 to ((count _positionsarray)-1) do {
	_currentpos = [(_positionsarray select _i),_i,[],[[]],[2,3]] call BIS_fnc_Param;
	_all_x pushBack (_currentpos select 0);
	_all_x pushBack (_currentpos select 0);
	If ((count(_currentpos))>2) then {
		_all_x pushBack (_currentpos select 0);
	};
};

_x = _all_x call BIS_fnc_arithmeticMean;
_y = _all_y call BIS_fnc_arithmeticMean;
_z = _all_z call BIS_fnc_arithmeticMean;

If ((count _all_x)>(count _all_z)) then {
	_return=[_x,_y];
}else{
	_return=[_x,_y,_z];
};

_return
