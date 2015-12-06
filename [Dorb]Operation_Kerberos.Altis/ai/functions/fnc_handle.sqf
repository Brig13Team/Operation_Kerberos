/*
	Author: Dorbedo
	
	Description:
		handles AI HQ
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(handle);
CHECK(GETMVAR(GVAR(working),false))
SETMVAR(GVAR(working,true));

CHECK((GETMVAR(GVAR(centerpos),[]) isEqualTo []))

//// remove dead groups
{
	private "_temp";
	_temp = missionnamespace getVariable [_x,[]];
	If !(_temp isEqualTo []) then {
		_temp = _temp - [grpNull];
		missionnamespace setVariable [_x,_temp];
	};
} forEach [QGVAR(Other),QGVAR(marine),QGVAR(Car),
			QGVAR(Drone),QGVAR(Tank),QGVAR(Infanterie),
			QGVAR(Attack_Helicopter),QGVAR(Transport_Helicopter),
			QGVAR(CAS_Plane),QGVAR(Air_other)];


_attackLogics = [] call FUNC(attackpos_getAll);

_waitingGroups = [];

{
	If (side _x == GVARMAIN(side)) then {
		if ((_x getVariable [QGVAR(state),""]) isEqualTo "wait") then {
			_waitingGroups pushBack _x;
		};
	};
}forEach allGroups;

TRACEV_2(_attackLogics,_waitingGroups);

{
	private ["_enemy","_troops"];
	_enemy = _x getVariable[QGVAR(enemy),0];
	_troops = _x getVariable[QGVAR(troops),0];
	
	If (_troops < _enemy) then {
		for "_i" from _troops to _enemy do {
			private["_curGroup","_strength"];
			_curGroup = _waitingGroups deleteAt 0;
			_strength = [_curGroup] call FUNC(strength);
			_curGroup setVariable [QGVAR(target),_x];
			_curGroup setVariable [QGVAR(state),"attack"];
			[_curGroup] spawn FUNC(state_change);
			
			_troops = _troops + (_strength select 1);
			_i = _i + (_strength select 1);
		};
	};
	
	_x setVariable[QGVAR(troops),_troops];
}forEach _attackLogics;




/*
//// Gather Informations -> where does the enemy attack
private["_attackpositions","_attackarray"];
_attackarray = [QGVAR(dangerzones)] call EFUNC(common,matrix_find_peaks);
_attackpositions = [];
{
	_attackpositions pushBack [
							((GVAR(centerpos) select 0)-(GVAR(definitions) select 0) + ((_x select 1)*(GVAR(definitions) select 1))),
							((GVAR(centerpos) select 1)+(GVAR(definitions) select 1) - ((_x select 2)*(GVAR(definitions) select 1))),
							0
							];
}forEach _attackarray;

// Check Radars
_aircontacts = [] call FUNC(check_radars);
// Check Spotters
_spotter_requests = [] call FUNC(check_spotter);
// Check Requests
_support_requests = GETMVAR(GVAR(support_requests),[]);
SETMVAR(GVAR(support_requests),[]);
*/

//// Check for availlaible Squads in Range




///// Make decisions




//// Call Support (Call-In Units or Off-Map Support)




SETMVAR(GVAR(working),false);

