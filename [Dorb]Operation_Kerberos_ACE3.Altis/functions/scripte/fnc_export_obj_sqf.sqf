



Private["_center","_radius","_temp"];
_center = [_this,0,[0,0,0],[[],objNull],[3,2]] call BIS_fnc_Param;
If (typename _center == "OBJECT") then {_temp = getPosATL _center;_center=[];_center=_temp;};
_radius = [_this,1,50,[0]] call BIS_fnc_Param;


_allObjects = _center nearObjects _radius;
_exportarray = [];

For "_i" from 0 to ((count _allObjects)-1) do {
	_temp = [];
	_temp pushBack (typeOf (_allObjects select _i));
	_temppos = getPosATL (_allObjects select _i);
	_temppos set [0,((_temppos select 0)-(_center select 0))];
	_temppos set [1,((_temppos select 1)-(_center select 1))];
	_temppos set [2,((_temppos select 2)-(_center select 2))];
	_temp pushBack _temppos;
	_temp pushBack (getDir (_allObjects select _i));
	_exportarray pushBack _temp;
};


_output = format["%1",_exportarray];

copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";


