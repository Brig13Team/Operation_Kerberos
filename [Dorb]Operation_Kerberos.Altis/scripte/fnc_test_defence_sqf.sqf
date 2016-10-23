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

private _centerpos = getPos player;
_centerpos set [1,(_centerpos select 1)+40];

private _allCfg = "true" configClasses (missionConfigFile >> "terrain_positions" >> "east" >> "terrain");

private _cfg = selectRandom _allCfg;

private _material = getArray(_cfg>>"material");
private _vehicles = getArray(_cfg>>"vehicles");
private _soldiers = getArray(_cfg>>"soldiers");
hint str _cfg;
[_centerpos,_dir,_material,_vehicles,_soldiers] execVM "fnc_test_defence_exec.sqf";