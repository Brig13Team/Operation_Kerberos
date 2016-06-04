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
#include "script_component.hpp"
SCRIPT(exec_housemacro);
_this params [["_house",objNull,[objNull]]];

If (isNull _house) exitWith {};

private _houseType = typeOf _house;


private _allCfg = (format["getText(_x >> 'housetype') isEqualTo '%1'",_houseType]) configClasses (missionConfigFile >> "city_houses" >> str GVARMAIN(side));

private _cfg = selectRandom _allCfg;

private _material = getArray(_cfg>>"material");
private _vehicles = getArray(_cfg>>"vehicles");
private _soldiers = getArray(_cfg>>"soldiers");
private _targets = getArray(_cfg>>"targets");

[_house,_material,_vehicles,_soldiers] call FUNC(exec_housemacro);


