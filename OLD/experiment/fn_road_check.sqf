/*

_pos=getMarkerPos "Testmarker";
_road=[_pos,20,[]] call BIS_fnc_nearestRoad;
[_road] call mfs_fnc_road_type;


_pos=getMarkerPos "Testmarker2";
_road=[_pos,20,[]] call BIS_fnc_nearestRoad;
[_road] call mfs_fnc_road_type;

_pos=getMarkerPos "Testmarker3";
_road=[_pos,20,[]] call BIS_fnc_nearestRoad;
[_road] call mfs_fnc_road_type;

*/

_pos=getMarkerPos "Testmarker_gr";

_list = _pos nearRoads 15000;

//hint format["road=%1",_list];
/*
{
	[_x] spawn mfs_fnc_road_type;
}forEach _list;
*/
{
	[_x] spawn mfs_fnc_road_array;
}forEach _list;