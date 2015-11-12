/*
	Author: Dorbedo
	
	Description:
		creates the unitslists
	
	Parameter(s):
		0 : SCALAR (opt)	- Number
	
*/
#include "script_component.hpp"
SCRIPT(choose_army);
params[["_rand",-1,[0]]];
TRACEV_1(_rand);

If (_rand < 0) then {
	_rand = floor(random 5);
};

private ["_ArmyArray","_path"];

_ArmyArray = [
	["regular",1], //mixed
	//fighting troups
	["armored",1],
	["infanterie",1],
	// special troups
	["airborne",1],
	["specops",1],	// special trained soldiers
	["specialoperations",1], // droneoperations
	//other
	["guards",1]
];

GVARMAIN(side_type) = [_ArmyArray,1] call EFUNC(common,sel_array_weighted);

_path = (missionConfigFile >> "unitlists" >> QGVARMAIN(side) >> QGVAR(side_type));


GVAR(list_crewmen) = getArray(_path >> "crewmen");
GVAR(list_divers) = getArray(_path >> "divers");
GVAR(list_soldiers) = getArray(_path >> "soldiers");

GVAR(list_veh_transport) = getArray(_path >> "veh_transport");
GVAR(list_veh_mechanized) = getArray(_path >> "veh_mechanized");
GVAR(list_veh_armored) = getArray(_path >> "veh_armored");

GVAR(list_boat_patrol) = getArray(_path >> "boat_patrol");

GVAR(list_hq_mobile) = getArray(_path >> "hq_mobile");

GVAR(list_static) = getArray(_path >> "static");
GVAR(list_static_high) = getArray(_path >> "static_high");
GVAR(list_static_aa) = getArray(_path >> "static_aa");

GVAR(list_art_mortar) = getArray(_path >> "art_mortar");
GVAR(list_art_shells) = getArray(_path >> "art_shells");
GVAR(list_art_rocket) = getArray(_path >> "art_rocket");


EGVAR(ai,hq_callIn_airinterception) = getNumber(_path >> "callIn" >> "airinterception" >> "amount");
GVAR(callIn_airinterception) = getArray(_path >> "callIn" >> "airinterception" >> "units");

EGVAR(ai,hq_callIn_cas) = getNumber(_path >> "callIn" >> "cas" >> "amount");
GVAR(callIn_cas) = getArray(_path >> "callIn" >> "cas" >> "units");

EGVAR(ai,hq_callIn_motorized) = getNumber(_path >> "callIn" >> "motorized" >> "amount");
GVAR(callIn_motorized) = getArray(_path >> "callIn" >> "motorized" >> "units");

EGVAR(ai,hq_callIn_armored) = getNumber(_path >> "callIn" >> "armored" >> "amount");
GVAR(callIn_armored) = getArray(_path >> "callIn" >> "armored" >> "units");

EGVAR(ai,hq_callIn_airborne) = getNumber(_path >> "callIn" >> "airborne" >> "amount");
GVAR(callIn_airborne) = getArray(_path >> "callIn" >> "airborne" >> "units");
GVAR(callIn_transport) = getArray(_path >> "callIn" >> "transport" >> "units");

GVAR(list_civ_cars) = getArray(_path >> "civ_cars");
GVAR(list_civ_cars_garage) = getArray(_path >> "civ_smallcars");


GVAR(list_pow) = getArray(_path >> "pow");
GVAR(list_intel) = getArray(_path >> "intel");
GVAR(list_tower) = getArray(_path >> "tower");
GVAR(list_prototype) = getArray(_path >> "prototyp");
GVAR(list_weaponcache) = getArray(_path >> "weaponcache");
GVAR(list_commander) = getArray(_path >> "commander");
GVAR(list_radar) = getArray(_path >> "radar");
GVAR(list_device) = getArray(_path >> "device");

GVAR(group_patrol) = getArray(_path >> "group_patrol");
GVAR(group_armored) = getArray(_path >> "group_armored");
GVAR(group_infanterie) = getArray(_path >> "group_infanterie");

