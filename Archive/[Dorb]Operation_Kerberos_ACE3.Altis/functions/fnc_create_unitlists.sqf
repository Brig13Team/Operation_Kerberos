/*
	Author: Dorbedo
	
	Description:
		creates the unitslists
	
	Parameter(s):
		0 : SCALAR (opt)	- Number
	
*/
#include "script_component.hpp"
SCRIPT(create_unitlists);
params[["_rand",0,[0]]];

If (_rand < 1) then {
	If (worldName == "pja305") exitWith {_rand = 50;};
	If (DORB_PLAYERSIDE == east) exitWith {
		ISNILS(DORB_MODS_BWA,false);
		If (DORB_MODS_BWA) then {
			_rand = ((floor(random 6))+ 100);
		}else{
			_rand = ((floor(random 4))+ 100);
		};
	};
	_rand = floor(random 5) +1 ;
};
private "_path";
switch (_rand) do {
	case 1: {dorb_side = east;_path = (missionConfigFile >> "unitlists" >> "east" >> "vdv");};
	case 2: {dorb_side = east;_path = (missionConfigFile >> "unitlists" >> "east" >> "vdv_flora");};
	case 3: {dorb_side = east;_path = (missionConfigFile >> "unitlists" >> "east" >> "vdv_mflora");};
	case 4: {dorb_side = east;_path = (missionConfigFile >> "unitlists" >> "east" >> "msv");};
	case 5: {dorb_side = east;_path = (missionConfigFile >> "unitlists" >> "east" >> "msv_emr");};
	
	case 50: {dorb_side = resistance;_path = (missionConfigFile >> "unitlists" >> "resistance" >> "LOP_AFR");};
	
	case 100: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "US_Army_desert");};
	case 101: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "US_Army_woodland");};
	case 102: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "USMC_desert");};
	case 103: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "USMC_woodland");};
	case 104: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "BWA3_tropen");};
	case 105: {dorb_side = west;_path = (missionConfigFile >> "unitlists" >> "west" >> "BWA3_fleck");};
};

private["_dorb_grouplist_inf","_dorb_grouplist_mech","_dorb_grouplist_sf","_dorb_grouplist_panz"];
dorb_side_nr = _rand;
dorb_pow = getArray(_path >> "pow");
dorb_intel = getArray(_path >> "intel");
dorb_tower = getArray(_path >> "tower");
dorb_prototyp = getArray(_path >> "prototyp");
dorb_civ_cars = getArray(_path >> "civ_cars");
dorb_civ_cars_garage = getArray(_path >> "civ_smallcars");
dorb_staticlist_high = getArray(_path >> "static_high");
dorb_sniper = getArray(_path >> "sniper");
dorb_device = getArray(_path >> "device");
dorb_menlist = getArray(_path >> "menlist");
dorb_diverlist = getArray(_path >> "diver");
dorb_crewmenlist = getArray(_path >> "crewmen");
_dorb_grouplist_inf = getArray(_path >> "group_inf");
_dorb_grouplist_mech = getArray(_path >> "group_mech");
_dorb_grouplist_sf = getArray(_path >> "group_sf");
_dorb_grouplist_panz = getArray(_path >> "group_tanks");
If (!(_dorb_grouplist_inf isEqualTo [])) then {
	_temp = [];
	{
		_temp pushBack ([_x,configFile] call BIS_fnc_configPath) ;
	}forEach _dorb_grouplist_inf;
	dorb_grouplist_inf = _temp;
};
If (!(_dorb_grouplist_mech isEqualTo [])) then {
	_temp = [];
	{
		_temp pushBack  ([_x,configFile] call BIS_fnc_configPath) ;
	}forEach _dorb_grouplist_mech;
	dorb_grouplist_mech = _temp;
};
If (!(_dorb_grouplist_sf isEqualTo [])) then {
	_temp = [];
	{
		_temp pushBack  ([_x,configFile] call BIS_fnc_configPath) ;
	}forEach _dorb_grouplist_sf;
	dorb_grouplist_sf = _temp;
};
If (!(_dorb_grouplist_panz isEqualTo [])) then {
	_temp = [];
	{
		_temp pushBack  ([_x,configFile] call BIS_fnc_configPath) ;
	}forEach _dorb_grouplist_panz;
	dorb_grouplist_panz = _temp;
};
dorb_veh_armored = getArray(_path >> "veh_armored");
dorb_veh_unarmored = getArray(_path >> "veh_unarmored");
dorb_veh_aa = getArray(_path >> "veh_aa");
dorb_veh_car = getArray(_path >> "veh_car");
dorb_veh_truck = getArray(_path >> "veh_truck");
dorb_veh_arty = getArray(_path >> "veh_arty");
dorb_veh_mortar = getArray(_path >> "veh_mortar");
dorb_staticlist = getArray(_path >> "static");
dorb_staticlist_art = getArray(_path >> "veh_mortar");
dorb_patrolboatlist = getArray(_path >> "boat");
dorb_transport_heli_list = getArray(_path >> "heli_transport");
dorb_attack_heli_list = getArray(_path >> "heli_attack");
dorb_patrol_air_list = getArray(_path >> "plane_patrol");
dorb_attack_air_list = getArray(_path >> "plane_attack");
dorb_commanderlist = getArray(_path >> "commander");
dorb_wpncache_list = getArray(_path >> "weaponcache");
dorb_commandveh_radio = getArray(_path >> "commandoveh");
dorb_commandveh_arty = getArray(_path >> "commandoveh_arty");
private["_dorb_commandveh_side_nr"];
_dorb_commandveh_side_nr = getNumber(_path >> "commandoveh_side");If (_dorb_commandveh_side_nr < 1) then {dorb_commandveh_side=east;}else{dorb_commandveh_side=west;};
dorb_radar = getArray(_path >> "commandoveh_radar");

ISNILS(DORB_MODS_RDS,false);
If (DORB_MODS_RDS) then {
	dorb_staticlist_aa = getArray(missionConfigFile >> "unitlists" >> "mods" >> "rds" >> format["rds_%1",dorb_side] >> "static_aa");
	dorb_staticlist = dorb_staticlist append ( getArray(missionConfigFile >> "unitlists" >> "mods" >> "rds" >> format["rds_%1",dorb_side] >> "static") );
	dorb_veh_arty = getArray(missionConfigFile >> "unitlists" >> "mods" >> "rds" >> format["rds_%1",dorb_side] >> "static_arty");
	dorb_veh_mortar = getArray(missionConfigFile >> "unitlists" >> "mods" >> "rds" >> format["rds_%1",dorb_side] >> "veh_mortar");
};

LOG_2(_rand,dorb_side);