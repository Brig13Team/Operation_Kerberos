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
SCRIPT(fortify_roads_defence);
params["_weight","_pos_x","_pos_y","_pos_z","_dir","_size"];
private _position = [_pos_x,_pos_y,_pos_z];

/// Check if Road is ATL
If (_pos_z > 1) then {
	_position = ASLtoATL _position;
};

#ifdef DEBUG_MODE_FULL
	[_position,format["Fortification-%1",_position],"ColorOPFOR","mil_arrow",_dir] call EFUNC(common,debug_marker_create);
#endif

/// Direction
private _rand = floor(random 2);
//_dir = _dir - 90;
if (_rand>0) then {
	_dir = _dir + 180;
};

private _sizestring = switch (_size) do {
	case 3 : {"roads_crossing"};
	case 2 : {"roads_main"};
	default {"roads_medium"};
};

private _config = missionconfigfile>>"missions_config">>"defence_positions">>_sizestring;
private _makros = [];
for "_i" from 0 to (count _config)-1 do {
	_makros pushBack [configname (_config select _i),getNumber((_config select _i)>>"probability")];
};

private _currentmakro = ([_makros,1] call EFUNC(common,sel_array_weighted))select 0;
private _configarray = ["missionConfigFile","defence_positions","terrain"];
private _configarray pushBack _currentmakro;

[_position,_configarray,_dir] call FUNC(macro_exec3d);