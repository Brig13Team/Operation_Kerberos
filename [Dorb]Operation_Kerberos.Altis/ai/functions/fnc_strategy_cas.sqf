/*
	Author: Dorbedo
	
	Description:
		revon
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(strategy_helicopter);
_this params ["_currentLogic"];

private _currentPos = getPos _currentLogic;

private _spawnpos = [_currentPos,6000,2] call EFUNC(common,random_pos);

if (!(_spawnpos isEqualTo [])) then {
	GVAR(callInArray) params ["_airborne","_airinterception","_armored","_cas","_fortifications","_motorized","_drones"];
	GVAR(callInArray) = [_airborne,_airinterception,_armored,(_cas-1),_fortifications,_motorized,_drones];
	
	private _allcas = getNumber(missionconfigfile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type)>> "callIn" >> "cas" >> "units");
	private _casVehType = _allcas SELRND;
	_spawnpos set [2,1500];
	_dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;
	
	([_spawnpos,GVARMAIN(side),_casVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_casGroup","_casVeh"];

	_casVeh flyInHeight 400;
	
	[_casGroup, _currentPos, 0, "SAD", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [180,260,380], 80] call FUNC(waypoints_add);
	
	_casGroup addWaypoint [_spawnpos, 0];
	
	[_casVeh,_spawnpos] spawn {
		SCRIPTIN(strategy_airinterception_reset);
		params ["_casVeh","_spawnpos"];
		uisleep 60;
		while {(alive _casVeh) && ((_casVeh distance2D _spawnpos)<100)} do {
			uisleep 5;
		};
		If (alive _casVeh) then {
			GVAR(callInArray) params ["_airborne","_airinterception","_armored","_cas","_fortifications","_motorized","_drones"];
			GVAR(callInArray) = [_airborne,_airinterception,_armored,(_cas - 1),_fortifications,_motorized,_drones];
		};
	};
};
