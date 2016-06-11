/*
	Author: Dorbedo
	
	Description:
	Big Cleanup
	
*/
#include "script_component.hpp"
SCRIPT(cleanup_big);
PARAMS_2(_pos,_rad);

private _exeptions = [["boat_spawn",100],["shooting_range",500],["repair_mark",50],[GVARMAIN(respawnmarker),800]];

private _objectsToDelete = allMissionObjects "All" select {private _curObj = _x;!({(_curObj distance2D (getMarkerPos (_x select 0)))<(_x select 1)} count _exeptions>0)};

{_x TILGE;} forEach _objectsToDelete;
{_x TILGE;} forEach allMines;

{if (!(alive _x)) then {_x TILGE;};} foreach vehicles;
{_x TILGE;} forEach allDead;

{_x TILGE;} foreach nearestObjects [(getmarkerpos DORB_RESPAWNMARKER),["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], 2000];

{_x TILGE;} foreach allGroups;

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;

[-1,{if(hasInterface)exitWith{};{deleteGroup _x;} foreach allGroups;}] FMP;	//Headless remove Groups

ISNILS(EGVAR(mission,sideby_objects),[]);
{_x TILGE;} forEach EGVAR(mission,sideby_objects);
EGVAR(mission,sideby_objects) = [];
EGVAR(mission,fnc) = [];
publicVariable QEGVAR(mission,fnc);
