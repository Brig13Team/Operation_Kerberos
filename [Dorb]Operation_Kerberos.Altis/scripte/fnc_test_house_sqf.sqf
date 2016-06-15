/*
    Author: Dorbedo

    Description:
        Spawns predefined defencepositions

    Parameter(s):
        0 : ARRAY    - Startpos
        1 : ARRAY     - ConfigArray
        2 : SCALAR    - Centerdirection

    [(getMarkerPos "testmarker"),["missionConfigFile","defence_positions","terrain","bunker_medium"],0] execVM "functions\fnc_spawn_macro_exec3d";
    
*/
_this params [["_dir",35,[0]]];
private _houseType = "Land_Offices_01_V1_F";

private _pos = getPos player;
_pos set [1,(_pos select 1)+40];
_house = "Land_Offices_01_V1_F" createVehicle _pos;
_house setDir _dir;

private _allCfg = (format["getText(_x >> 'housetype') isEqualTo '%1'",_houseType]) configClasses (missionConfigFile >> "city_houses" >> "east");

private _cfg = selectRandom _allCfg;

private _material = getArray(_cfg>>"material");
private _vehicles = getArray(_cfg>>"vehicles");
private _soldiers = getArray(_cfg>>"soldiers");
private _targets = getArray(_cfg>>"targets");

hint format ["%1",_cfg];

[_house,_material,_vehicles,_soldiers] execVM "fnc_exec_house_sqf.sqf";