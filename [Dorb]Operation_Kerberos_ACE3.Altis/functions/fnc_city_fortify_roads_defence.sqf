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

params["_weight","_pos_x","_pos_y","_pos_z","_dir","_size"];
private "_pos";
_pos = [_pos_x,_pos_y,_pos_z];


If (dorb_debug) then {
	_mrkr = createMarker [format["Fortification-%1",_pos],_pos];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorOPFOR";
	_mrkr setMarkerType "mil_arrow";
	_mrkr setMarkerDir _dir;
};





true

