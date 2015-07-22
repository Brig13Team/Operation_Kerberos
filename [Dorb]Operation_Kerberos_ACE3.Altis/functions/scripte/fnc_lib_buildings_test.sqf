/*
	["Land_GH_House_2_F"] execVM "fnc_lib_buildings_test.sqf";
*/
params["_building_type"];

test3=[];
_building = createVehicle[_building_type,[0,0,0],[],0,"CAN_COLLIDE"];
test3 pushBack _building;
_building setPosATL [0,0,0];
_building setDir 0;

_buildingpos = getArray(missionConfigFile >> "city_defence" >> "buildings_vanilla" >> _building_type >> "soldierpos");
hint format["_buildingpos=%1",_buildingpos];
{
	private["_arrow","_arrowtype","_arrowtypedir","_pos","_dir"];
	_arrowtype = "Sign_Arrow_Yellow_F";
	_arrowtypedir = "Sign_Arrow_Direction_Yellow_F";
	If (((_x select 5)==3)||((_x select 5)==1)) then {
		_arrowtype = "Sign_Arrow_Large_F";
		_arrowtypedir = "Sign_Arrow_Direction_F";
	};
	_pos = [(_x select 0),(_x select 1),(_x select 2)];
	_dir = (_x select 3);
	If ((_x select 4)>=0) then {
		_dir =  (( ( ( (_x select 4)-(_x select 3) )/2) ) + (_x select 3) );
	};
	_arrow =  createVehicle[_arrowtype,_pos,[],0,"CAN_COLLIDE"];
	test3 pushBack _arrow;
	_arrow =  createVehicle[_arrowtypedir,_pos,[],0,"CAN_COLLIDE"];
	test3 pushBack _arrow;
	_arrow setPosATL _pos;
	_arrow setDir _dir;

}forEach _buildingpos;

