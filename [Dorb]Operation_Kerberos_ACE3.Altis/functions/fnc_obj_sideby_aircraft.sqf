/*
	Author: iJesuz
	
	Description:
		Abgestürzte BLUFOR und OPFOR Flugzeuge erstellen

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

private ["_position", "_task_array", "_dest", "_typen", "_wichtung", "_obj", "_description"];

_position = _this select 0;
_task_array = _this select 1;

#ifdef TEST
	_position = getMarkerPos "spawn_side";
	_dest = getMarkerPos "spawn_conter";
#else
	_dest = taskDestination (_task_array select 1);
#endif

_typen = ["Land_Wreck_Plane_Transport_01_F","Land_Wreck_Heli_Attack_02_F"];
_wichtung = [1,1];
_typ = [_typen, _wichtung] call BIS_fnc_selectRandomWeighted;

_obj = _typ createVehicle _position;
SETPVAR(_obj,DORB_ISTARGET,true);
missionNamespace setVariable [DORB_CONTER,false];

// LOG(FORMAT_2("[SIDEBY] %1 an Position %2 gespawnt!", _typ, _position));

fnc_SuitcaseAttach = {
	private ["_target", "_caller", "_id"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_target removeAction _id;

	_target attachTo [_caller, [0.24,0,-0.25], "Pelvis"];
	_target setDir 75;
	_caller forceWalk true;

	_caller addAction ["Loslassen", { _this call fnc_SuitcaseDetach; }, _target];
};

fnc_SuitcaseDetach = {
	private ["_target", "_caller", "_id", "_suitcase"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_suitcase = _this select 3;
	_target removeAction _id;

	detach _suitcase;
	_suitcase setPosATL (position _caller);
	_caller forceWalk false;

	_suitcase addAction ["Nehmen", { _this call fnc_SuitcaseAttach; }];
};

fnc_ObjAction = {
	private ["_target", "_caller", "_id", "_pos", "_typ", "_task", "_main_task", "_suitcase"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_typ = _this select 3 select 0;
	_task = _this select 3 select 1;
	_main_task = _this select 3 select 2;

	_target removeAction _id;
	_pos = getMarkerPos "respawn_west";

	if (GETVAR(missionNamespace,DORB_CONTER,false)) then {
		hint "Ein Aktenkoffer wurde im Wrack gefunden!";

		_suitcase = "Land_Suitcase_F" createVehicle (position _caller);
		_suitcase addAction ["Nehmen", { _this call fnc_SuitcaseAttach; }];

		while { (((position _suitcase) distance _pos) > 25) OR !(isNull attachedTo _suitcase) } do {};
		uiSleep 5;

		if (_typ == "Land_Wreck_Plane_Transport_01_F") then {
			#ifndef TEST
				["random", _main_task, [1, 1, 50]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 1, 1, 50));
			#endif
		} else {
			#ifndef TEST
				["random", _main_task, [2, 0, 50]] call FM(examine);
			#else
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, 50));
			#endif
		};

		hint "Informationen wurden erfolgreich ausgewertet!";
		
		#ifdef TEST
			LOG("[SIDEBY] Flugobjekt abgeschlossen!");
		#else
			_task setTaskState "Succeeded";
		#endif

		missionNamespace setVariable [DORB_CONTER,true];
		deleteVehicle _suitcase;
	} else {
		hint "Es wurden keine Informationen gefunden!";
		

		#ifdef TEST
			LOG("[SIDEBY] Flugobjekt fehlgeschlagen!");
		#else
			_task setTaskState "Failed";
		#endif
	};
};

switch (_typ) do
{
	case "Land_Wreck_Plane_Transport_01_F":
	{
		_description = "Eines unserer Flugzeuge ist abgestürzt! An Bord war einer unserer Geheimagenten mit streng geheimen Informationen. Finden Sie die Informationen und Bringen Sie diese zurück zur Basis!";
	};
	case "Land_Wreck_Heli_Attack_02_F":
	{
		_description = "Ein feindlicher Helikopter ist abgestürzt! Suchen Sie ihn und prüfen Sie ob sich Informationen an Bord befinden. Bringen Sie diese ggf. zurück zur Basis!";
	};
};

#ifdef TEST
	LOG("[SIDEBY] Flugobjekt erstellt!");
#else
	[_task_array, true, [_description, "abgestürztes Flugobjekt", "Bergen"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

_obj addAction ["Informationen suchen", { _this call fnc_ObjAction; }, [_typ,_task_array select 0, _task_array select 1]];

_conter_size = if (_typ == "Land_Wreck_Plane_Transport_01_F") then { "medium" } else { "big" };
fnc_conter = {
	private ["_veh", "_group", "_pos", "_dest", "target", "_typ", "_veh_group", "_wp", "_buf"];
	_veh = _this select 0;
	_group = _this select 1;
	_dest = _this select 2 select 0;
	_target = _this select 2 select 1;
	_typ = _this select 2 select 2;
	_pos = _this select 2 select 3;

	_veh_group = group driver _veh;
	(units _veh_group) join _group;

	_wp = [ _group addWaypoint [ [_dest,_pos,50] call FM(pointBetween) , 0 ] ]; // _wp0
	(_wp select 0) setWaypointType "GETOUT";

	_wp = _wp + [ _group addWaypoint [ [_dest, position leader _group, 5] call FM(pointBetween) , 0 ] ]; // _wp1
	(_wp select 1) setWaypointType "MOVE";
	(_wp select 1) setWaypointBehaviour "AWARE";
	(_wp select 1) setWaypointStatements ["true", "missionNamespace setVariable [DORB_CONTER,true];"];

	_wp = _wp + [ _group addWaypoint [ _veh, 0 ] ]; // _wp2
	(_wp select 2) setWaypointType "GETIN";

	_wp = _wp + [ _group addWaypoint [ _pos, 0 ] ]; // _wp3
	(_wp select 3) setWaypointType "MOVE";
	(_wp select 3) setWaypointStatements ["true","[group this, position this, 400] call BIS_fnc_taskPatrol;"];
};
[_conter_size, _dest, fnc_conter, [_position, _obj, _typ, _dest]] call FM(TRIPLES(obj,sideby,conter));
