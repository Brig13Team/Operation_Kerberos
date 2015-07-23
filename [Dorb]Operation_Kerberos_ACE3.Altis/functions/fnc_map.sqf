/*
	Author: iJesuz

	Description:
		Executes the code given by the first argument on every array element given
		by the second argument.
		The side (right or left) of the array element depends on second argument
		(see examples).

	Parameter(s):	
		0 : String
		1 : Array
		2 : String (Optional) - Default: "r", Other Value: "l"

	Example(s):
		["+1",[1,2,3,4,5]] call DORB_fnc_map; // with function
		MAP("+1",[1,2,3,4,5]); // with macro (see script_macros.hpp)
		MAPR("+1",[1,2,3,4,5]);
		MAPL("1+",[1,2,3,4,5]);
			==> [2,3,4,5,6]

		MAP("setDir (random 360)",_enemys);
			==> applies random direction to every unit in _enemys

		MAPL("position",_enemys);
			==> returns array of positions

	Returns:
		Array
*/

private ["_codes","_array", "_mode", "_code", "_ret"];

// params [["_codes","",[""]],["_array",[],[[]]],["_mode","r",""]];

_codes = [_this, 0, "", [""]] call BIS_fnc_param;
_array = [_this, 1, [], [[],""]] call BIS_fnc_param;
_mode = [_this, 2, "r", [""]] call BIS_fnc_param;

if (_mode == "l" ) then {
	_code = compile (_codes + " _this;")
} else {
	_code = compile ("_this " + _codes + ";");
};

_ret = [];
{
	_ret = _ret + [_x call _code];
} forEach _array;

{
	_x = _x call _code;
} count _array;

_ret
