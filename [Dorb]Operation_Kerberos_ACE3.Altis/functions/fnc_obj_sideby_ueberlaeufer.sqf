/*
	Author: iJesuz
	
	Description:
		Überläufer erstellen
		Eigenschaften:
			Flugangst --> wenn er geflogen wird der Radius der Infos größer
			Paranoia --> wenn er mit zuviel Ammis in Kontakt kommt, denkt er sich zufällige Positionen aus
			Suizidgefährdet --> wenn er nach dem ersten Kontakt mit Ammis den Kontakt zu lang verliert, macht er Selbstmord
			nichts --> nichts

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

private ["_position", "_task_array", "_dest", "_ziel", "_zielPos", "_kleidung", "_description"];

params ["_position", "_task_array"];

LOG("ueberlaeufer");

#ifdef TEST
	_position = getMarkerPos "spawn_side";
	_dest = getMarkerPos "spawn_conter";
#else
	_dest = [_task_array select 1] call BIS_fnc_taskDestination;
#endif

_zielPos = _position;

_ziel = [_zielPos, createGroup civilian, "C_man_polo_1_F"] call FM(spawn_unit);
removeAllWeapons _ziel; removeAllItems _ziel; removeAllAssignedItems _ziel; removeUniform _ziel; removeVest _ziel; removeBackpack _ziel; removeHeadgear _ziel; removeGoggles _ziel;
_ziel forceAddUniform (getText (missionConfigFile >> "sideby_config" >> "deserter" >> "uniform"));
for "_i" from 1 to (getNumber (missionConfigFile >> "sideby_config" >> "deserter" >> "magc")) do {_ziel addItemToUniform (getText (missionConfigFile >> "sideby_config" >> "deserter" >> "mag"));};
_ziel addHeadgear (getText (missionConfigFile >> "sideby_config" >> "deserter" >> "headgear"));
_ziel addGoggles (getText (missionConfigFile >> "sideby_config" >> "deserter" >> "googles"));
_ziel addWeapon (getText (missionConfigFile >> "sideby_config" >> "deserter" >> "weapon"));
// for "_i" from 1 to 3 do {_ziel addItemToUniform "ACE_fieldDressing";}; _ziel addItemToUniform "ACE_EarPlugs"; for "_i" from 1 to 2 do {_ziel addItemToUniform "ACE_morphine";}; _ziel addItemToUniform "ACE_atropine"; _ziel addItemToUniform "ACE_epinephrine"; _ziel addItemToUniform "ACE_packingBandage"; _ziel addItemToUniform "ACE_elasticBandage"; _ziel addItemToUniform "ACE_Banana";
_eigenschaften = ["Flugangst", "Paranoia", "suizidgefaehrdet", "nichts"];
_wichtung = [0.125, 0.25, 0.01, 1];
_eigenschaft = [_eigenschaften, _wichtung] call BIS_fnc_selectRandomWeighted;

LOG(FORMAT_2("[SIDEBY] Ueberlaeufer an Position %1 mit Eigenschaft %2 erstellt!", position _ziel, _eigenschaft));

_description = "Wir haben Informationen über einen feindlichen Überläufer erhalten. Gehen Sie diesen nach und leiten Sie Maßnahmen ein!%1";
switch (_eigenschaft) do
{
	case "Flugangst":
	{
		_description = FORMAT_1(_description," Unserem Informanten zu Folge leidet der Überläufer unter Flugangst!");
	};
	case "Paranoia":
	{
		_description = FORMAT_1(_description," Unserem Informanten zu Folge hat der Überläufer Angst vor Amerikanern. Schüchtern Sie ihn also nicht ein!");
	};
	case "suizidgefaehrdet":
	{
		_description = FORMAT_1(_description," Unserem Informanten zu Folge ist der Zustand des Informanten sehr instabil. Gehen Sie vorsichtig vor!");
	};
	case "nichts":
	{
		_description = FORMAT_1(_description,"");
	};
};

[-1,{_this spawn FM(disp_info)},["Nebenmission",["Überläufer"],"",true]] FMP;
#ifdef TEST
	LOG("[SIDEBY] Überläufer erstellt!");
#else
	[_task_array, true, [_description, "Überläufer", "Finden"], _zielPos,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

[_ziel, _eigenschaft, _task_array] spawn FM(TRIPLES(obj,sideby,ueberlaeuferVerhoeren));

_conter_size = "big";
fnc_conter = {
	private ["_veh", "_group", "_veh_group", "_dest", "_target", "_ret", "_wp"];
	_veh = _this select 0;
	_group = _this select 1;
	_dest = _this select 2 select 0;
	_target = _this select 2 select 1;
	_ret = _this select 2 select 2;

	_veh_group = group driver _veh;
	(units _veh_group) join _group;

	_wp = [ _group addWaypoint [ [_dest, position leader _group, 100] call FM(pointBetween) , 0 ] ]; // _wp0
	(_wp select 0) setWaypointType "GETOUT";

	_wp = _wp + [ _group addWaypoint [ [_dest, position leader _group, 50] call FM(pointBetween) , 0 ] ]; // _wp1
	(_wp select 1) setWaypointType "MOVE";
	(_wp select 1) setWaypointBehaviour "AWARE";

	/*
		TODO:
			. kill him
	*/

	_wp = _wp + [ _group addWaypoint [ _veh, 0 ] ]; // _wp2
	(_wp select 2) setWaypointType "GETIN";

	_wp = _wp + [ _group addWaypoint [ _dest, 0 ] ]; // _wp3
	(_wp select 3) setWaypointType "MOVE";
	(_wp select 3) setWaypointStatements ["true","[group this, position this, 400] call BIS_fnc_taskPatrol;"];
};
[_conter_size, _dest, fnc_conter, [_zielPos, _ziel, _dest]] call FM(TRIPLES(obj,sideby,conter));
