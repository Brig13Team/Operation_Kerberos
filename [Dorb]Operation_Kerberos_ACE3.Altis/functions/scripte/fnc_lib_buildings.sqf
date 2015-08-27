/*
	Author: Dorbedo
	
	Description:
		Creates a Libary with all Buildings
	
	Parameter(s):
		none
	
	[] execVM "fnc_lib_buildings.sqf";
*/



/*
Vorraussetzung: Object muss gespawnt sein

- Größe via boundingBoxReal und boundingCenter
- Direction immer 0 (Nord)
- Positionen für einzelne Soldaten im Gebäude (Abhängig von Bounding-Center)
- Positionen für statische Waffen (Freies Dach, sowie Sicht)
- Türen (Zentrum der Tür sowie richtung) für Tripwires





Türen:
Position über {_house selectionPosition "door_1_axis"} erhalten
die Position ist immer am Türanschlag unten
Position2 über {_house selectionPosition  "door_1_trigger"}
die Position ist immer Zentral in der Tür
daraus dir durch BIS_fnc_dirTo
Breite der Tür = 1m

fenster:
{_house selectionPosition "glass_6_effects"}






Zielarray

[configname	,	boundingCenter , boundingBoxReal , soldierpos, doors]


soldierpos:
	- [x,y,z]
	- dir1 ()
	- dir2 ()
		- dir: -1 disabled
	- level
		0: indoor
		1: indoor, static possible (no AT, no AA)
		2: open
		3: open, static possible

formation für output:
struct buildings *buildingname*;
*buildingname*.centerpos = {x,y,z};
*buildingname*.boundingBox = {{x,y,z},{x,y,z}};
*buildingname*.soldierpos = {{x,y,z,dir1,dir2,level},...};
*buildingname*.doorpos = {{x,y,z,dir},...};




*/

/// Filter


_cfgvehicles = configFile >> "cfgvehicles";
_nullposition = [0,0,0];
_buildingsarray = [];

for "_i" from 0 to (count _cfgvehicles)-1  do {
	_vehicle	= _cfgvehicles select _i;
	if (isClass _vehicle) then {		
		_class = configName(_vehicle);
		_scope = getNumber(configFile >> "cfgvehicles" >> _class >> "scope");
		
		If ((_class isKindOf "House")&&(_scope > 0)) then {
			/// exclude damaged buildings
			_namearr = (toLower(_class)) splitString "_";
			If (!("dam" in _namearr)) then {
				_temp = [];
				_house = createVehicle [_class, _nullposition, [], 0, "CAN_COLLIDE"];
				_house setPosATL _nullposition;
				_house setVectorUp [0,0,1];
				_house setDir 0;
				
				/// Boundingbox 
				_centerpos = _house modeltoworld (boundingCenter _house);
				_boundingBox = [_house modeltoworld ((boundingBoxReal _house) select 0),_house modeltoworld ((boundingBoxReal _house) select 1)];
				
				/// Doorpos
				_doorscount = floor((count(configFile >> "cfgvehicles" >> _class >> "UserActions"))/3);
				_doorpos = [];
				_temppos = [];
				_temppos_helper = [];
				for "_i" from 0 to _doorscount do {
					_temppos_helper = _house modeltoworld (_house selectionPosition format["door_%1_trigger",_i+1]);
					_temppos = _house modeltoworld (_house selectionPosition format["door_%1_axis",_i+1]);
					_temppos_dir = [_temppos,_temppos_helper]call BIS_fnc_dirTo;
					If (((_temppos select 0)!=0)&&((_temppos select 1)!=0)) then {
						private "_temppos2";
						_temppos2 = [(_temppos_helper select 0),(_temppos_helper select 1),((_temppos_helper select 2)-1)];
						_temppos2 append [_temppos_dir];
						_doorpos pushback _temppos2;					
					};
				};
				
				/// SoldierPos
				_allbuildingpos = [_house] call BIS_fnc_buildingPositions;
				_allWindows = [];
				_soldierpos = [];
				_index = 1;
				while { (_house selectionPosition format["glass_%1_effects",_index]) distance [0,0,0] > 0 && _index < 99 } do {
					_allWindows set [count _allWindows, _house modeltoworld (_house selectionPosition format["glass_%1_effects",_index])];
					_index = _index + 1;
				};
				
				_wpnrad = 1.5;
				for "_j" from 0 to ((count _allbuildingpos)-1) do {
					_buildPosASL = ATLtoASL(_allbuildingpos select _j);
					_isObstructedZ = lineIntersects [_buildPosASL, [(_buildPosASL select 0), (_buildPosASL select 1), (_buildPosASL select 2) + 20]];
					_hasSurfaceBelowXa = lineIntersects [[(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
					_hasSurfaceBelowXb = lineIntersects [[(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
					_hasSurfaceBelowYa = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2) - 0.5]];
					_hasSurfaceBelowYb = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2) - 0.5]];
					
					_level = 0;
					If (!_isObstructedZ) then {_level = _level + 2;};
					If (_hasSurfaceBelowXa and _hasSurfaceBelowXb and _hasSurfaceBelowYa and _hasSurfaceBelowYb) then {_level = _level + 1;};
					_dir1 = -1;
					_dir2 = -1;
					If (_level < 2) then {
						_nextwindow = [0,0,-4];
						for "_k" from 0 to ((count _allWindows)-1) do {
							If ((_nextwindow distance (_allbuildingpos select _j)) >((_allWindows select _k) distance (_allbuildingpos select _j))) then {
								_nextwindow = (_allWindows select _k);
							};
						};
						_dir = [(_allbuildingpos select _j),_nextwindow] call BIS_fnc_dirTo;
						_atan = (_nextwindow distance (_allbuildingpos select _j)) atan2 (0.5);
						_dir1 = _dir - _atan;
						_dir2 = _dir + _atan;
						
					}else{
						_dir1 = [[0,0,0],(_allbuildingpos select _j)] call BIS_fnc_dirTo;
						_dir2 = -1;
					};
					_soldierpos_temp = (_allbuildingpos select _j);
					_soldierpos_temp append [_dir1,_dir2,_level];
					_soldierpos pushback _soldierpos_temp;
				};
				
				_temp pushback _class;
				_temp pushback _centerpos;
				_temp pushback _boundingBox;
				_temp pushback _soldierpos;
				_temp pushback _doorpos;
				
				_buildingsarray pushback _temp;
				deleteVehicle _house;
			};
		};
	};
};

////// Output for description.ext
Private["_br","_output","_i","_tab","_tab2","_tab3"];
_br = toString [0x0D, 0x0A];
_tab = "    "; // changed into spaces - toString[0x09];
_tab2 = _tab + _tab;
_tab3 = _tab2 + _tab;
_output = "class city_defence {" + _br + _tab + "class buildings_vanilla {";

{
	_output = _output + _br
	+ _tab2 + format["class %1 {",_x select 0] + _br
	+ _tab3 + format["centerpos[] = {%1,%2,%3};",(_x select 1) select 0,(_x select 1) select 1,(_x select 1) select 2] + _br
	+ _tab3 + format["boundingBox[] = {{%1,%2,%3},{%4,%5,%6}};",((_x select 2)select 0)select 0,((_x select 2)select 0)select 1,((_x select 2)select 0)select 2,((_x select 2)select 1)select 0,((_x select 2)select 1)select 1,((_x select 2)select 1)select 2] + _br
	+ _tab3 + "soldierpos[] = {";
	If ((count(_x select 3))>0) then {
		_i=0;
		_output = _output + format["{%1,%2,%3,%4,%5,%6}",(((_x select 3)select _i)select 0),(((_x select 3)select _i)select 1),(((_x select 3)select _i)select 2),(((_x select 3)select _i)select 3),(((_x select 3)select _i)select 4),(((_x select 3)select _i)select 5)];
		For "_i" from 1 to (count(_x select 3)-1) do {
			_output = _output + format[",{%1,%2,%3,%4,%5,%6}",(((_x select 3)select _i)select 0),(((_x select 3)select _i)select 1),(((_x select 3)select _i)select 2),(((_x select 3)select _i)select 3),(((_x select 3)select _i)select 4),(((_x select 3)select _i)select 5)];
		};
	};
	_output = _output + "};" + _br
	+ _tab3 + "doorpos[] = {";
	If ((count(_x select 4))>0) then {
		_i=0;
		_output = _output + format["{%1,%2,%3,%4}",(((_x select 4)select _i)select 0),(((_x select 4)select _i)select 1),(((_x select 4)select _i)select 2),(((_x select 4)select _i)select 3)];
		For "_i" from 1 to (count(_x select 4)-1) do {
			_output = _output + format[",{%1,%2,%3,%4}",(((_x select 4)select _i)select 0),(((_x select 4)select _i)select 1),(((_x select 4)select _i)select 2),(((_x select 4)select _i)select 3)];
		};
	};
	_output = _output + "};" + _br + _tab2 + "};"; 



}forEach _buildingsarray;

_output = _output + _br + _tab + "};" + _br + "};" + _br;





/*

///// Output for Cpp
Private["_br","_output","_i"];
_br = toString [0x0D, 0x0A]; 
_output = "";

{
	_output = _output + _br
	+ format["struct buildings %1",_x select 0] + _br
	+ format["%1.centerpos = {%2,%3,%4};",_x select 0,(_x select 1) select 0,(_x select 1) select 1,(_x select 1) select 2] + _br
	+ format["%1.boundingBox = {{%2,%3,%4},{%5,%6,%7}};",_x select 0,((_x select 2)select 0)select 0,((_x select 2)select 0)select 1,((_x select 2)select 0)select 2,((_x select 2)select 1)select 0,((_x select 2)select 1)select 1,((_x select 2)select 1)select 2] + _br
	+ format["%1.soldierpos = {",_x select 0];
	If ((count(_x select 3))>0) then {
		_i=0;
		_output = _output + format["{%1,%2,%3,%4,%5,%6}",(((_x select 3)select _i)select 0),(((_x select 3)select _i)select 1),(((_x select 3)select _i)select 2),(((_x select 3)select _i)select 3),(((_x select 3)select _i)select 4),(((_x select 3)select _i)select 5)];
		For "_i" from 1 to (count(_x select 3)-1) do {
			_output = _output + format[",{%1,%2,%3,%4,%5,%6}",(((_x select 3)select _i)select 0),(((_x select 3)select _i)select 1),(((_x select 3)select _i)select 2),(((_x select 3)select _i)select 3),(((_x select 3)select _i)select 4),(((_x select 3)select _i)select 5)];
		};
	};
	_output = _output + "};" + _br
	+ format["%1.doorpos = {",_x select 0];
	If ((count(_x select 4))>0) then {
		_i=0;
		_output = _output + format["{%1,%2,%3,%4}",(((_x select 4)select _i)select 0),(((_x select 4)select _i)select 1),(((_x select 4)select _i)select 2),(((_x select 4)select _i)select 3)];
		For "_i" from 1 to (count(_x select 4)-1) do {
			_output = _output + format[",{%1,%2,%3,%4}",(((_x select 4)select _i)select 0),(((_x select 4)select _i)select 1),(((_x select 4)select _i)select 2),(((_x select 4)select _i)select 3)];
		};
	};
	_output = _output + "};" + _br;
}forEach _buildingsarray;

*/



copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";