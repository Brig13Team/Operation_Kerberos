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
_radars = GETMVAR(GVAR(hq_radars),[]);
CHECK(_radars isEqualTo [])
{if !(alive _x) then {_x = objNull;}else{_radarpos pushBack (getPos _x);};} forEach _radars;
_radars = _radars - objNull;
SETVAR(GVAR(hq_radars),_radars);


private ["_players","_targets"];
_targets = [];
_players = [] call EFUNC(common,players);
{
	for "_i" from 0 to (count _players) do {
		private ["_cur_player","_cur_radarpos"];
		_cur_player = _players select _i;
		_cur_radarpos = getPosASL _x;
		_cur_radarpos set [2,(_cur_radarpos + 2)];
		If (((vehicle _cur_player) isKindOf "Air")&&(!((vehicle _cur_player) isKindOf "ParachuteBase"))) then {
			if ((((getPos _cur_player) distance _pos) < 5000)&&{(!(lineintersects[getPosASL _cur_player,_cur_radarpos,_cur_player,_x]))}) then {
				_targets pushBack (_cur_player);
			};
		};
	
	};
	
} forEach _radars;

GVAR(hq_airtargets)=_targets;

