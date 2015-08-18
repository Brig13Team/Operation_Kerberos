/*
	Author: iJesuz
	
	Description:
		Abgestürzte BLUFOR und OPFOR Flugzeuge erstellen

	Parameter(s):
		0 : Array - Arguments
		1 : String - Modus
*/
#include "script_component.hpp"

#define ATTACH_POINT [0,0,-0.1]
#define ANIM_TIME 1.1

SCRIPT(obj_sideby_aircraft);

params [["_args",[],[[]]],["_mode","", [""]]];

/*
// nur zu Debugzwecken auskommentieren (spammt extrem den Log zu)
LOG(FORMAT_2("_mode = %1 | _args = %2",_mode,_args));
*/

switch (_mode) do {
	case ("fnc_SuitcaseAttach"): {
		// executed local

		private ["_target", "_caller", "_id","_action"];
		_target = _args select 0;
		_caller = _args select 1;
		_id = _args select 2;

		_caller action ["SwitchWeapon", _caller, _caller, 100];
		uiSleep ANIM_TIME;

		_target attachTo [_caller, ATTACH_POINT, "RightHand"];
		_target setDir 90;
		_caller forceWalk true;

		_action = _caller addAction [localize "STR_DORB_SIDE_AIRCRAFT_INTEL_DROP", { [_this, "fnc_SuitcaseDetach"] call FM(TRIPLES(obj,sideby,aircraft)); }, _target];
		_target setVariable ["DORB_SUITCASE_ACTIONID",_action];

		[0, {
			private "_handle";
			_handle = [{ [_this,"fnc_SuitcaseGetInHandler"] call FM(TRIPLES(obj,sideby,aircraft)); }, 1, _this] call CBA_fnc_addPerFrameHandler;
			(_this select 0) setVariable ["DORB_SUITCASE_HANDLE",_handle];
			LOG("fnc_SuitcaseGetInHandler Handler gestartet");
		}, [_target,_caller]] FMP;
	};
	case ("fnc_SuitcaseDetach"): {
		// executed local

		private ["_target", "_caller", "_id", "_suitcase","_handle"];
		_target = _args select 0;
		_caller = _args select 1;
		_id = _args select 2;
		_suitcase = _args select 3;
		_target removeAction _id;

		detach _suitcase;
		_suitcase setPosATL (position _caller);
		_caller forceWalk false;

		_handle = _suitcase getVariable ["DORB_SUITCASE_HANDLE",-1];
		if (_handle != -1) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
			LOG("fnc_SuitcaseGetInHandler Handler beendet (fnc_SuitcaseDetach)");
		};
		_handle = _suitcase getVariable ["DORB_SUITCASE_HANDLE2",-1];
		if (_handle != -1) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
			LOG("fnc_SuitcaseGetOutHandler Handler beendet (fnc_SuitcaseDetach)");
		};
	};
	case ("fnc_SuitcaseGetInHandler"): {
		// executed on server

		private["_suitcase","_player","_action"];
		_args = _args select 0;
		_suitcase = _args select 0;
		_player = _args select 1;
		_action = _suitcase getVariable ["DORB_SUITCASE_ACTIONID",-1];

		if (isNull _suitcase) exitWith {		
			// Task beendet (durch ScriptedEventHandler übernommen)
		};

		// Disconnected Handler
		if (isNull player) exitWith {
			private ["_last_position","_handle"];
			_last_position = _suitcase getVariable ["DORB_SUITCASE_LASTPOS",[0,0,0]];
			_handle = _suitcase getVariable "DORB_SUITCASE_HANDLE";
			_suitcase setPos _last_position;
			if (isMultiplayer) then {
				_suitcase enableSimulationGlobal true;
			} else {
				_suitcase enableSimulation true;
			};
			[_handle] call CBA_fnc_removePerFrameHandler;

			LOG("fnc_SuitcaseGetInHandler Handler beendet (player disconnected)");
		};

		// Get In Handler
		if ( (!(isNull attachedTo _suitcase)) && {(vehicle _player) != _player} ) then {
			private "_handle";

			detach _suitcase;
			_suitcase setPos [0,0,0];
			if (isMultiplayer) then {
				_suitcase enableSimulationGlobal false;
			} else {
				_suitcase enableSimulation false;
			};

			_player forceWalk false;
			if (_action != -1) then {
				_player removeAction _action;
				_suitcase setVariable ["DORB_SUITCASE_ACTIONID",-1];
			};

			_handle = [{ [_this,"fnc_SuitcaseGetOutHandler"] call FM(TRIPLES(obj,sideby,aircraft)); }, 1, [_suitcase,_player]] call CBA_fnc_addPerFrameHandler;

			LOG("fnc_SuitcaseGetOutHandler Handler gestartet");

			_suitcase setVariable ["DORB_SUITCASE_HANDLE2",_handle];
		};
		
		// getting data for Disconnected Handler
		_suitcase setVariable ["DORB_SUITCASE_LASTPOS",getPos _player];
	};
	case ("fnc_SuitcaseGetOutHandler"): {
		// executed on server

		private["_suitcase","_player"];
		_args = _args select 0;
		_suitcase = _args select 0;
		_player = _args select 1;

		if (isNull _suitcase) exitWith {		
			// Task beendet (durch ScriptedEventHandler übernommen)
		};

		private "_handle";
		_handle = _suitcase getVariable "DORB_SUITCASE_HANDLE2";

		if (isNull _player) exitWith {
			// Disconnected Event Handler (siehe Oben)
			[_handle] call CBA_fnc_removePerFrameHandler;

			LOG("fnc_SuitcaseGetOutHandler Handler beendet (player disconnected)");
		};

		if ((vehicle _player) == _player) then {
			if (isMultiplayer) then {
				_suitcase enableSimulationGlobal true;
			} else {
				_suitcase enableSimulation true;
			};
			_suitcase setPos (getPos _player);

			[_suitcase,_player] spawn {
				params ["_suitcase","_player"];

				_player action ["SwitchWeapon", _player, _player, 100];
				
				uiSleep ANIM_TIME;
				
				_suitcase attachTo [_player, ATTACH_POINT, "RightHand"];
				_suitcase setDir 90;
				_player forceWalk true;

				[ [[_player,_suitcase], {
					params ["_player","_suitcase"];
					private "_action";
					_action = _player addAction [localize "STR_DORB_SIDE_AIRCRAFT_INTEL_DROP", { [_this, "fnc_SuitcaseDetach"] call FM(TRIPLES(obj,sideby,aircraft)); }, _suitcase];
					_suitcase setVariable ["DORB_SUITCASE_ACTIONID",_action];
				}] ,"BIS_fnc_spawn", _player, true] call BIS_fnc_MP;
			};

			[_handle] call CBA_fnc_removePerFrameHandler;

			LOG("fnc_SuitcaseGetOutHandler Handler beendet (get out of vehicle)");
		};
	};
	case ("fnc_ObjAction"): {
		// executed local

		private ["_target", "_caller", "_id", "_pos", "_typ", "_task", "_main_task"];
		_target = _args select 0;
		_caller = _args select 1;
		_id = _args select 2;
		_typ = _args select 3 select 0;
		_task = _args select 3 select 1;
		_main_task = _args select 3 select 2;

		_target removeAction _id;

		[0,{
			[_this, "fnc_watchSuitcase"] call FM(TRIPLES(obj,sideby,aircraft));
		},[_caller, _main_task, _task, _typ]] FMP;
	};
	case ("fnc_watchSuitcase"): {
		// executed on server

		private ["_caller", "_main_task", "_task", "_typ", "_pos", "_suitcase"];
		_caller = _args select 0;
		_main_task = _args select 1;
		_task = _args select 2;
		_typ = _args select 3;

		_pos = getMarkerPos "rescue_marker";

		if ( !(missionNamespace getVariable ["DORB_CONTER", false]) ) then {

			_suitcase = createVehicle ["Land_Suitcase_F", position _caller, [], 0, "NONE"];
			_suitcase setVariable ["DORB_ISTARGET",true];
			[_suitcase,"DORB_RESCUEPOINT", {
				params["_suitcase"];
				private ["_handle"];
				_handle = _suitcase getVariable ["DORB_SUITCASE_HANDLE",-1];
				if (_handle != -1) then {
					[_handle] call CBA_fnc_removePerFrameHandler;
					LOG("fnc_SuitcaseGetInHandler Handler beendet (task completed)");
				};
				_handle = _suitcase getVariable ["DORB_SUITCASE_HANDLE2",-1];
				if (_handle != -1) then {
					[_handle] call CBA_fnc_removePerFrameHandler;
					LOG("fnc_SuitcaseGetOutHandler Handler beendet (task completed)");
				};
			}] call BIS_fnc_addScriptedEventHandler;
			DORB_SIDEBY_OBJECTS pushBack _suitcase;
			[-1, { _this addAction [localize "STR_DORB_SIDE_AIRCRAFT_INTE_TAKE", { [_this, "fnc_SuitcaseAttach"] call FM(TRIPLES(obj,sideby,aircraft)); }, nil, 1.5, true, true, "", "isNull attachedTo _target;"]; }, _suitcase] FMP;
			ISNILS(DORB_MISSION_FNC,[]);
			DORB_MISSION_FNC = DORB_MISSION_FNC + [ _suitcase , "_this addAction [localize 'STR_DORB_SIDE_AIRCRAFT_INTE_TAKE', { [_this, 'fnc_SuitcaseAttach'] call DORB_fnc_obj_sideby_aircraft; }, nil, 1.5, true, true, "", 'isNull attachedTo _target;'];" ];
			publicVariable "DORB_MISSION_FNC";

			LOG("SCHLEIFE GESTARTET");
			while { (!(DORB_SIDEBY_OBJECTS isEqualTo [])) AND {(((position _suitcase) distance _pos) > 25) OR !(isNull attachedTo _suitcase)} } do { uiSleep 5; };
			LOG("SCHLEIFE ABGEBROCHEN");
			if (DORB_SIDEBY_OBJECTS isEqualTo []) exitWith {
				[_task, "Canceled", false] call BIS_fnc_taskSetState;
			};

			uiSleep 5;

			if (_typ == "Land_Wreck_Plane_Transport_01_F") then {
				#ifndef TEST
					[_main_task, "useless_intel", [1, 1, 50, 50]] call FM(obj_reward);
				#else
					LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 1, 1, 50));
				#endif
			} else {
				#ifndef TEST
					[_main_task, "targets", [2, 50]] call FM(obj_reward);
				#else
					LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, 50));
				#endif
			};
			
			["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FINISHED"],"",false] call FM(disp_info_global);
			#ifdef TEST
				LOG("[SIDEBY] Flugobjekt abgeschlossen!");
			#else
				[_task, "Succeeded", false] call BIS_fnc_taskSetState;
			#endif

			missionNamespace setVariable ["DORB_CONTER",true];
			deleteVehicle _suitcase;
		} else {
			["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FAILED"],"",false] call FM(disp_info_global);
			#ifdef TEST
				LOG("[SIDEBY] Flugobjekt fehlgeschlagen!");
			#else
				[_task, "Failed", false] call BIS_fnc_taskSetState;
			#endif
		};
	};
	default {
		// executed on server

		private ["_position", "_task_array", "_dest", "_typen", "_wichtung", "_typ", "_obj", "_description","_fnc_conter"];

		_position = _args select 0;
		_task_array = _args select 1;

		DORB_SIDEBY_OBJECTS = [];

		#ifdef TEST
			_position = getMarkerPos "spawn_side";
			_dest = getMarkerPos "spawn_conter";
		#else
			private "_buffer";
			_buffer = GETMVAR(DORB_MILITAER,[]);
			CHECK(DORB_MILITAER isEqualTo [])
			for "_i" from 1 to 130 do {
				_dest = ((_buffer SELRND) select 1) + [0];
				if ((_dest distance _position) > 6000) exitWith {};
			};
		#endif

		_typen = ["Land_Wreck_Plane_Transport_01_F","Land_Wreck_Heli_Attack_02_F"];
		_wichtung = [1,1];
		_typ = [_typen, _wichtung] call BIS_fnc_selectRandomWeighted;

		_obj = createVehicle [_typ, _position, [], 0, "NONE"];
		DORB_SIDEBY_OBJECTS pushBack _obj;
		SETPVAR(_obj,DORB_ISTARGET,true);
		missionNamespace setVariable ["DORB_CONTER",false];

		switch (_typ) do
		{
			case "Land_Wreck_Plane_Transport_01_F":
			{
				_description = "STR_DORB_SIDE_AIRCRAFT_DESCRIPTION_BLUFOR";
			};
			case "Land_Wreck_Heli_Attack_02_F":
			{
				_description = "STR_DORB_SIDE_AIRCRAFT_DESCRIPTION_OPFOR";
			};
		};

		[-1,{_this spawn FM(disp_info)},["Nebenmission",["abgestürztes Flugobjekt"],"",true]] FMP;
		#ifdef TEST
			LOG("[SIDEBY] Flugobjekt erstellt!");
		#else
			[_task_array, true, [_description, "STR_DORB_SIDE_AIRCRAFT_DESCRIPTION_SHORT", "STR_DORB_SIDE_SDV_MARKER"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
		#endif

		[-1, {
			private ["_obj", "_typ", "_task_array"];
			params ["_obj", "_typ", "_task_array"];
			_obj addAction [localize "STR_DORB_SIDE_AIRCRAFT_SEARCH_INTEL", { [_this, "fnc_ObjAction"] call FM(TRIPLES(obj,sideby,aircraft)); }, [_typ,_task_array select 0, _task_array select 1]];
		}, [_obj,_typ,_task_array]] FMP;
		ISNILS(DORB_MISSION_FNC,[]);
		DORB_MISSION_FNC = DORB_MISSION_FNC + [ [_obj,_task_array] , "(_this select 0) addAction [localize 'STR_DORB_SIDE_AIRCRAFT_SEARCH_INTEL', { [_this, 'fnc_ObjAction'] call DORB_fnc_obj_sideby_aircraft; }, [_typ,(_this select 1) select 0, (_this select 1) select 1]];" ];
		publicVariable "DORB_MISSION_FNC";

		_conter_size = if (_typ == "Land_Wreck_Plane_Transport_01_F") then { "medium" } else { "big" };
		_fnc_conter = {
			private ["_veh", "_group", "_pos", "_dest", "_target", "_veh_group", "_wp"];
			_veh = _this select 0;
			_group = _this select 1;
			_dest = _this select 2 select 0;
			_target = _this select 2 select 1;
			_pos = _this select 2 select 2;

			_veh_group = group driver _veh;
			(units _veh_group) join _group;

			_wp = [ _group addWaypoint [ [_dest,_pos,50] call FM(pointBetween) , 0 ] ]; // _wp0
			(_wp select 0) setWaypointType "GETOUT";

			_wp = _wp + [ _group addWaypoint [ [_dest, position leader _group, 5] call FM(pointBetween) , 0 ] ]; // _wp1
			(_wp select 1) setWaypointType "MOVE";
			(_wp select 1) setWaypointBehaviour "AWARE";
			(_wp select 1) setWaypointStatements ["true", "missionNamespace setVariable ['DORB_CONTER',true];"];

			_wp = _wp + [ _group addWaypoint [ _veh, 0 ] ]; // _wp2
			(_wp select 2) setWaypointType "GETIN";

			_wp = _wp + [ _group addWaypoint [ _pos, 0 ] ]; // _wp3
			(_wp select 3) setWaypointType "MOVE";
			(_wp select 3) setWaypointStatements ["true","[group this, position this, 400] call BIS_fnc_taskPatrol;"];
		};
		[_conter_size, _dest, _fnc_conter, [_position, _obj, _dest]] spawn FM(TRIPLES(obj,sideby,conter));
	};
};
