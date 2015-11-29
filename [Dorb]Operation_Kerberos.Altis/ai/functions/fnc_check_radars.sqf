/*
	Author: Dorbedo
	
	Description:
		checks the radars for enemys
	
	Parameter(s):
		none

	Returns:
		ARRAY - array with 
*/
#include "script_component.hpp"
SCRIPT(init_mission);
private ["_radarpos","_radars"];
_radarpos = [];
_radars = GETMVAR(GVAR(radars),[]);
CHECK(_radars isEqualTo [])
{if !(alive _x) then {_x = objNull;}else{_radarpos pushBack (getPos _x);};} forEach _radars;
_radars = _radars - objNull;
SETVAR(GVAR(radars),_radars);


private ["_units","_targets"];
_targets = [];
_units = [] call EFUNC(common,players);
{If ((side _x == GVARMAIN(playerside))&&{_x isKindOf "Plane";}) then {_units pushBack _x;};} forEach allUnitsUAV;
{
	for "_i" from 0 to (count _units) do {
		private ["_cur_unit","_cur_radarpos"];
		_cur_unit = _units select _i;
		_cur_radarpos = getPosASL _x;
		_cur_radarpos set [2,(_cur_radarpos + 2)];
		If (((vehicle _cur_unit) isKindOf "Air")&&(!((vehicle _cur_unit) isKindOf "ParachuteBase"))) then {
			if ((((getPos _cur_unit) distance _pos) < 5000)&&{(!(lineintersects[getPosASL _cur_unit,_cur_radarpos,_cur_unit,_x]))}) then {
				_targets pushBack (_cur_unit);
			};
		};
	
	};
	
} forEach _radars;

GVAR(airtargets)=_targets;

