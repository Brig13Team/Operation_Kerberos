/*
	Author: Dorbedo
	
	Description:
		
		spawn road - defence positions
		
	
	Parameter(s):
		_this : ARRAY		- roadpositions
		
	Returns:
		BOOL
	
*/
#include "script_component.hpp"
SCRIPT(city_fortify_roads_defence);
params["_weight","_pos_x","_pos_y","_pos_z","_dir","_size"];
private "_position";
_position = [_pos_x,_pos_y,_pos_z];

/// Check if Road is ATL
If (_pos_z > 1) then {_position = ASLtoATL _position;};



If (dorb_debug) then {
	_mrkr = createMarker [format["Fortification-%1",_position],_position];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorOPFOR";
	_mrkr setMarkerType "mil_arrow";
	_mrkr setMarkerDir _dir;
};
private "_rand";
/// Direction
_rand = floor(random 2);
//_dir = _dir - 90;
if (_rand>0) then {
	_dir = _dir + 180;
};

_type = 0;

if (_size>1) then {
	_rand = floor(random 2);
	if (_rand>0) then {
		_type = 10;
	}else{
		_type = 11;
	};
};
if (_size<2) then {
	_rand = floor(random 2);
	if (_rand>0) then {
		_type = 20;
	}else{
		_type = 21;
	};
};
private "_configarray";
_configarray = ["missionConfigFile","defence_positions","roads"];
switch (_type) do {
	// Roadblock Mainroad - MG
	case 10 : {
		_configarray pushBack "main_small_inf";
		[_position,_configarray,_dir] call FUNC(macro_exec3d);
	};
	
	// Roadblock Mainroad - AT
	case 11 : {
		_configarray pushBack "main_big_inf";
		[_position,_configarray,_dir] call FUNC(macro_exec3d);
	};
	
	// Roadblock Middelroad - MG
	case 20 : {
		_configarray pushBack "medium_small_inf";
		[_position,_configarray,_dir] call FUNC(macro_exec3d);
	};
	
	// Roadblock Middelroad - AT
	case 21 : {
		_configarray pushBack "medium_big_inf";
		[_position,_configarray,_dir] call FUNC(macro_exec3d);
	};
	
	// Roadblock Crossing (4 roads)
	case 30 : {
		_configarray pushBack "crossing";
		[_position,_configarray,_dir] call FUNC(macro_exec3d);
	};

};

true