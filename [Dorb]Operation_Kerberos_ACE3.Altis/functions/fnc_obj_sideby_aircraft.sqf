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

params ["_position", "_task_array"];

#ifdef TEST
	_position = getMarkerPos "spawn_side";
	_dest = getMarkerPos "spawn_conter";
#else
	_dest = [_task_array select 1] call BIS_fnc_taskDestination;
#endif

_typen = ["Land_Wreck_Plane_Transport_01_F","Land_Wreck_Heli_Attack_02_F"];
_wichtung = [1,1];
_typ = [_typen, _wichtung] call BIS_fnc_selectRandomWeighted;

_obj = _typ createVehicle _position;
SETPVAR(_obj,DORB_ISTARGET,true);
missionNamespace setVariable ["DORB_CONTER",false];

fnc_SuitcaseAttach = {
	private ["_target", "_caller", "_id"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;

	_caller action ["SwitchWeapon", _caller, _caller, 100];
	uiSleep 1;

	_target attachTo [_caller, [0,0,0], "RightHand"];
	_target setDir 90;
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

	if ( !(missionNamespace getVariable ["DORB_CONTER", false]) ) then {

		_suitcase = "Land_Suitcase_F" createVehicle (position _caller);
		[-1, { _this addAction ["Nehmen", { _this call fnc_SuitcaseAttach }, nil, 1.5, true, true, "", "isNull attachedTo _target;"]; }, _suitcase] FMP;
		DORB_MISSION_FNC = DORB_MISSION_FNC + [ _suitcase , "_this addAction ['Nehmen', { _this call fnc_SuitcaseAttach }, nil, 1.5, true, true, "", 'isNull attachedTo _target;'];" ];
		publicVariable "DORB_MISSION_FNC";

		while { (((position _suitcase) distance _pos) > 25) OR !(isNull attachedTo _suitcase) } do {};
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
		
		[-1,{_this spawn FM(disp_info)},["Nebenmission",["abgeschlossen"],"",true]] FMP;
		#ifdef TEST
			LOG("[SIDEBY] Flugobjekt abgeschlossen!");
		#else
			[_task, "Succeeded", true] call BIS_fnc_taskSetState;
		#endif

		missionNamespace setVariable ["DORB_CONTER",true];
		deleteVehicle _suitcase;
	} else {
		[-1,{_this spawn FM(disp_info)},["Nebenmission",["fehlgeschlagen"],"",true]] FMP;
		#ifdef TEST
			LOG("[SIDEBY] Flugobjekt fehlgeschlagen!");
		#else
			[_task, "Failed", true] call BIS_fnc_taskSetState;
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

[-1,{_this spawn FM(disp_info)},["Nebenmission",["abgestürztes Flugobjekt"],"",true]] FMP;
#ifdef TEST
	LOG("[SIDEBY] Flugobjekt erstellt!");
#else
	[_task_array, true, [_description, "abgestürztes Flugobjekt", "Bergen"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

[-1, {
	private ["_obj", "_typ", "_task_array"];
	params ["_obj", "_typ", "_task_array"];
	_obj addAction ["Informationen suchen", { _this call fnc_ObjAction; }, [_typ,_task_array select 0, _task_array select 1]];
}, [_obj,_typ,_task_array]] FMP;
DORB_MISSION_FNC = DORB_MISSION_FNC + [ [_obj,_task_array] , "(_this select 0) addAction ['Informationen suchen', { _this call fnc_ObjAction; }, [_typ,(_this select 1) select 0, (_this select 1) select 1]];" ];
publicVariable "DORB_MISSION_FNC";

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
	(_wp select 1) setWaypointStatements ["true", "missionNamespace setVariable ['DORB_CONTER',true];"];

	_wp = _wp + [ _group addWaypoint [ _veh, 0 ] ]; // _wp2
	(_wp select 2) setWaypointType "GETIN";

	_wp = _wp + [ _group addWaypoint [ _pos, 0 ] ]; // _wp3
	(_wp select 3) setWaypointType "MOVE";
	(_wp select 3) setWaypointStatements ["true","[group this, position this, 400] call BIS_fnc_taskPatrol;"];
};
[_conter_size, _dest, fnc_conter, [_position, _obj, _typ, _dest]] call FM(TRIPLES(obj,sideby,conter));
