/*
	Author: iJesuz
	
	Description:
		Abgestürzte BLUFOR und OPFOR Flugzeuge erstellen

	Parameter(s):
		0 : Array - Position
*/
#include "script_component.hpp"

private ["_position", "_typen", "_wichtung", "_obj"];

_position = _this select 0;

_typen = ["Land_Wreck_Plane_Transport_01_F","Land_Wreck_Heli_Attack_02_F"];
_wichtung = [1,1];
_typ = [_typen, _wichtung] call BIS_fnc_selectRandomWeighted;

_obj = _typ createVehicle _position;

LOG(FORMAT_2("[SIDEBY] %1 an Position %2 gespawnt!", _typ, _position));

fnc_SuitcaseAttach = {
	private ["_target", "_caller", "_id"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_target removeAction _id;

	_target attachTo [_caller, [0.24,0,-0.25], "Pelvis"];
	_target setDir 75;
	_caller forceWalk true;

	LOG(FORMAT_1("[SIDEBY] %1 hat das Suitcase aufgehoben!", _caller));

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

	LOG(FORMAT_1("[SIDEBY] %1 hat das Suitcase losgelassen!", _caller));
	
	_suitcase addAction ["Nehmen", { _this call fnc_SuitcaseAttach; }];
};

fnc_ObjAction = {
	private ["_target", "_caller", "_id", "_pos", "_typ", "_suitcase"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_typ = _this select 3;

	_target removeAction _id;
	_pos = getMarkerPos "respawn_west";

	_suitcase = "Land_Suitcase_F" createVehicle (position _caller);
	_suitcase addAction ["Nehmen", { _this call fnc_SuitcaseAttach; }];

	while { (((position _suitcase) distance _pos) > 25) OR !(isNull attachedTo _suitcase) } do {};
	uiSleep 5;

	if (_typ == "Land_Wreck_Plane_Transport_01_F") then {
		#ifndef TEST
			["random", [1, 1, 50] call FM(examine);
		#else
			LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 1, 1, 50));
		#endif
	} else {
		#ifndef TEST
			["random", [2, 0, 50] call FM(examine);
		#else
			LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 2, 0, 50));
		#endif
	};

	hint "Informationen wurden erfolgreich ausgewertet!";

	deleteVehicle _suitcase;
};

_obj addAction ["Informationen suchen", { _this call fnc_ObjAction; }, _typ];
