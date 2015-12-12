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
CHECK(GETMVAR(GVAR(active),false))
CHECK(GETMVAR(GVAR(working),false))
CHECK((GETMVAR(GVAR(centerpos),[]) isEqualTo []))
SETMVAR(GVAR(working,true));

/// spawn to move it in the ingame sheduler
[] spawn {
	
	//// remove dead groups ***OBSOLET?
	{
		private _temp = missionnamespace getVariable [_x,[]];
		If !(_temp isEqualTo []) then {
			_temp = _temp - [grpNull];
			missionnamespace setVariable [_x,_temp];
		};
	} forEach [QGVAR(Other),QGVAR(marine),QGVAR(Car),
				QGVAR(Drone),QGVAR(Tank),QGVAR(Infanterie),
				QGVAR(Attack_Helicopter),QGVAR(Transport_Helicopter),
				QGVAR(CAS_Plane),QGVAR(Air_other)];


	/// gather Informations


	private _attackarray = [QGVAR(dangerzones)] call EFUNC(common,matrix_find_peaks);
	private _attackpositions = [];
	{
		_attackpositions pushBack [
								((GVAR(centerpos) select 0)-(GVAR(definitions) select 0) + ((_x select 1)*(GVAR(definitions) select 1))),
								((GVAR(centerpos) select 1)+(GVAR(definitions) select 1) - ((_x select 2)*(GVAR(definitions) select 1))),
								0
								];
	}forEach _attackarray;


	//// create new Attacklogics
	private _attackLogics = [] call FUNC(attackpos_getAll);

	{
		private _curentAttackPos = _x;
		{
			if ((_x distance _curentAttackPos)<400) exitWith {
				[_curentAttackPos,0] call FUNC(attackpos_create_logic);
			};
		}forEach _attackLogics;
	}forEach _attackpositions;



	/// Update the enemyamount on each Attackpos
	_attackLogics = [] call FUNC(attackpos_getAll);

	{
		([getPos _x] call FUNC(dangerzones_convert)) params ["_x_coord","_y_coord"];
		private _enemy = 0;
		{
			_temp = _temp + _x call EFUNC(common,matrix_value_get);
		}forEach [
			[_x_coord,_y_coord],
			
			[_x_coord+1,_y_coord],
			[_x_coord-1,_y_coord],
			[_x_coord,_y_coord+1],
			[_x_coord,_y_coord-1],
			
			[_x_coord+1,_y_coord+1],
			[_x_coord-1,_y_coord-1],
			[_x_coord-1,_y_coord+1],
			[_x_coord+1,_y_coord-1],
			
			[_x_coord+2,_y_coord-2],
			[_x_coord+2,_y_coord+2],
			[_x_coord-2,_y_coord-2],
			[_x_coord-2,_y_coord+2],
			
			[_x_coord-1,_y_coord-2],
			[_x_coord-2,_y_coord-1],
			[_x_coord+1,_y_coord-2],
			[_x_coord+2,_y_coord-1],
			[_x_coord+1,_y_coord+2],
			[_x_coord+2,_y_coord+1],
			[_x_coord-1,_y_coord+2],
			[_x_coord-2,_y_coord+1],
			
			[_x_coord+2,_y_coord],
			[_x_coord-2,_y_coord],
			[_x_coord,_y_coord+2],
			[_x_coord,_y_coord-2]
		];
		_x setVariable[QGVAR(enemy),_enemy];
	} forEach _attackLogics;


/*
	// Check Radars
	_aircontacts = [] call FUNC(check_radars);
	// Check Spotters
	_spotter_requests = [] call FUNC(check_spotter);
	// Check Requests
	_support_requests = GETMVAR(GVAR(support_requests),[]);
	SETMVAR(GVAR(support_requests),[]);
*/




	/// get the availlible groups
	private _waitingGroups = [];
	/// the bored groups
	{
		If (side _x != GVARMAIN(playerside)) then {
			if ((_x getVariable [QGVAR(state),""]) isEqualTo "wait") then {
				_waitingGroups pushBack _x;
			};
		};
	}forEach allGroups;
	/// the veterans
	{
		If (side _x != GVARMAIN(playerside)) then {
			if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
				_waitingGroups pushBack _x;
			};
		};
	}forEach allGroups;
	
	
	private _missingstrenght = 0;
	/// move into battle
	[_attackLogics,_waitingGroups] call FUNC(strategy);
	/*
	{
		private _enemy = _x getVariable[QGVAR(enemy),0];
		private _troops = _x getVariable[QGVAR(troopsNeeded),0];
		
		If ((_enemy - _troops)>0) then {
			for "_i" from 0 to _troops do {
				private _curGroup = _waitingGroups deleteAt 0;
				private _strength = [_curGroup] call FUNC(strength);
				_curGroup setVariable [QGVAR(target),_x];
				_curGroup setVariable [QGVAR(strength),_x];
				_curGroup setVariable [QGVAR(state),"attack"];
				[_curGroup] spawn FUNC(state_change);
				
				_troops = _troops + (_strength select 1);
				_i = _i + (_strength select 1);
			};
		};
		_missingstrenght = _missingstrenght + ((_enemy - _troops) max 0);
		_x setVariable[QGVAR(troopsNeeded),_troops];
	}forEach _attackLogics;
	*/
	
	//// Let the rest do something too.
	{
		if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
			private _curPOI = GVAR(POI) SELRND;
			private _curPos = [_curPOI,800,0] call EFUNC(common,pos_random);
			_x setVariable [QGVAR(target),_curPos];
			_x setVariable [QGVAR(state),"wait"];
			[_x] spawn FUNC(state_change);
		};
	} forEach _waitingGroups;
	
	
	// remove groups from patroling when the shit hits the fan
	/*
	If (_missingstrenght > 0) then {
		_waitingGroups = [];
		{
			If (side _x != GVARMAIN(playerside)) then {
				if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
					_waitingGroups pushBack _x;
				};
			};
		}forEach allGroups;

		{
			if (_missingstrenght <= 0) exitWith {};
			private _strength = [_x] call FUNC(strength);
			private _curPOI = GVAR(POI) SELRND;
			private _curPos = [_curPOI,200,0] call EFUNC(common,pos_random);
			_x setVariable [QGVAR(target),_curPos];
			_x setVariable [QGVAR(state),"retreat"];
			[_x] spawn FUNC(state_change);
			_missingstrenght = _missingstrenght - _strength;
		} forEach _waitingGroups;
	};
	*/
	
	


	SETMVAR(GVAR(working),false);

};