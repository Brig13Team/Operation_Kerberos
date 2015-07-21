/*
	Author: Dorbedo
	
	called via:
		[(getPos player),25,(getDir player)] execVM "fnc_export_obj_sqf.sqf";
		[player,25] execVM "fnc_export_obj_sqf.sqf";
		[cursorTarget,25] execVM "fnc_export_obj_sqf.sqf";

	
	class defencepostionname {
		
		material[] = {  {classname,position,direction,offset,vectorUp}  };
		vehicles[] = {  {classname,position,direction,offset,vectorUp}  };		//static and vehicles
		soldier[] = {  {classname,position,direction,offset,vectorUp}  };
	};
*/

params[["_center",[0,0,0],[[],objNull],[3,2]],["_radius",25,[0]],["_centerdir",9999,[0]]];
private["_centerpos","_allObjects","_exportarray"];
hint "Export in progess....";
If (typename _center == "OBJECT") then {
	_centerpos = getPosATL _center;
	If (_centerdir>9998) then {
		_centerdir = getDir _center;
	};
}else{_centerpos = _center};

/// set center on ground
_centerpos set[2,0];

_allObjects = _center nearObjects _radius;
_exportarray = [];


/// offset = [position,direction,vectorUp];
_fnc_getoffset = {
	params["_object","_positionASL"];
	private["_nextObject","_objDir","_objPosASL","_objVectorUp","_terrainNormal","_refpos","_offsetVector","_offsetPos","_offset"];
	_nextObject = [_object] call _fnc_getObjbelow;
	If (isNull _nextObject) then {
		_objDir = getDir _object;
		_objPosASL = getPosASL _object;
		_objVectorUp = vectorUp _object;
		_terrainNormal = surfaceNormal (getPosATL _object);
		_offsetVector = vectorNormalized(_terrainNormal VectorAdd _objVectorUp);
		_offset = [_objPosASL,_objDir,_offsetVector];
	}else{
		_offset = [_nextObject,_positionASL] call _fnc_getoffset;
	};
	_offset
};

_fnc_getObjbelow = {
	params["_object"];
	private["_objPosASL","_terrainPosASL","_terrainPos","_terrainPosATL","_nextObject"];
	_objPosASL = getPosASL _object;
	_terrainPosATL = getPosATL _object;
	_terrainPos = [(_terrainPosATL select 0),(_terrainPosATL select 1),0];
	_terrainPosASL = ATLtoASL _terrainPos;
	_nextObject = lineIntersectsObjs [_objPosASL, _terrainPosASL, objNull, _object, false, 2];
	if (_nextObject isEqualTo []) then {objNull}else{_nextObject select 0};
};

_centerposASL = ATLtoASL _centerpos;

{
	If (!(isPlayer _x)) then {
		private["_temp","_nextObject"];
		_temp = [];
		_nextObject = [_x] call _fnc_getObjbelow;
		
		If (_nextObject isEqualTo []) then {
			/// obj has nothing below -> offset = [0,0,0]
			private["_objDir","_objVectorUp","_objPosASL","_terrainNormal","_temptype","_temppos","_tempdir","_tempoffset","_tempvector"];
			_objDir = getDir _x;
			_objVectorUp = vectorUp _x;
			_objPosASL = getPosASL _x;
			_terrainNormal = surfaceNormal (getPosATL _object);
			_temptype = typeOf _x;
			_temppos = _centerposASL VectorDiff _objPosASL;
			_tempdir = _centerdir + _objDir;
			If (_tempdir >= 360) then {_tempdir = _tempdir - 360;};
			_tempoffset = [0,0,0];
			_tempvector = vectorNormalized(_terrainNormal VectorAdd _objVectorUp);
			_temp = [_temptype,_temppos,_tempdir,_tempoffset,_tempvector];
		}else{
			/// something below -> get offset
			private ["_objDir","_objVectorUp","_objPosASL","_offsetArray","_refpos","_refdir","_refVector","_temptype","_temppos","_tempdir","_tempoffset","_tempvector"];
			_objDir = getDir _x;
			_objVectorUp = vectorUp _x;
			_objPosASL = getPosASL _x;
			_offsetArray = [_x,_objPosASL] call _fnc_getoffset;
			_refpos = _offsetArray select 0;
			_refdir = _offsetArray select 1;
			_refVector = _offsetArray select 2;
			_temptype = typeOf _x;
			_temppos = _centerposASL VectorDiff _refpos;
			_tempdir = _centerdir + _refdir + _objDir;
			If (_tempdir >= 360) then {_tempdir = _tempdir - 360;};
			_tempoffset = _refpos VectorDiff _objPosASL;
			_tempvector = vectorNormalized(_refVector VectorAdd _objVectorUp);
			_temp = [_temptype,_temppos,_tempdir,_tempoffset,_tempvector];
		};
		If (!(_temp isEqualTo [])) then {
			_exportarray pushBack _temp;
		};
	};
}forEach _allObjects;

////// Sort the output
private["_export_material","_export_soldier","_export_vehicles"];
_export_vehicles = [];
_export_soldier = [];
_export_material = [];

{
	if ((_x select 0) isKindOf "LandVehicle") then {
		_export_vehicles pushBack _x;
	}else{
		If ((_x select 0) isKindOf "Man") then {
			_export_soldier pushBack _x;
		}else{
			_export_material pushBack _x;
		};
	};
}forEach _exportarray;




_br = toString [0x0D, 0x0A];
_tab = "    "; // changed into spaces - toString[0x09];
_tab2 = _tab + _tab;
_tab3 = _tab2 + _tab;

_output = _tab2 + format["class defencepos_%1 {",floor(random 99999)] + _br
+ _tab3 + "material[] = {";
If ((count(_export_material))>0) then {
	_i=0;
	_output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",	((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),(((_export_material select _i)select 3)select 0),(((_export_material select _i)select 3)select 1),(((_export_material select _i)select 3)select 2),(((_export_material select _i)select 4)select 0),(((_export_material select _i)select 4)select 1),(((_export_material select _i)select 4)select 2)];
	For "_i" from 1 to (count _export_material -1) do {
		_output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),(((_export_material select _i)select 3)select 0),(((_export_material select _i)select 3)select 1),(((_export_material select _i)select 3)select 2),(((_export_material select _i)select 4)select 0),(((_export_material select _i)select 4)select 1),(((_export_material select _i)select 4)select 2)];
	};
};
_output = _output + "};" + _br
+ _tab3 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
	_i=0;
	_output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",	((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),(((_export_vehicles select _i)select 3)select 0),(((_export_vehicles select _i)select 3)select 1),(((_export_vehicles select _i)select 3)select 2),(((_export_vehicles select _i)select 4)select 0),(((_export_vehicles select _i)select 4)select 1),(((_export_vehicles select _i)select 4)select 2)];
	For "_i" from 1 to (count _export_vehicles -1) do {
		_output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),(((_export_vehicles select _i)select 3)select 0),(((_export_vehicles select _i)select 3)select 1),(((_export_vehicles select _i)select 3)select 2),(((_export_vehicles select _i)select 4)select 0),(((_export_vehicles select _i)select 4)select 1),(((_export_vehicles select _i)select 4)select 2)];
	};
};
_output = _output + "};" + _br
+ _tab3 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
	_i=0;
	_output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",	((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),(((_export_soldier select _i)select 3)select 0),(((_export_soldier select _i)select 3)select 1),(((_export_soldier select _i)select 3)select 2),(((_export_soldier select _i)select 4)select 0),(((_export_soldier select _i)select 4)select 1),(((_export_soldier select _i)select 4)select 2)];
	For "_i" from 1 to (count _export_soldier -1) do {
		_output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),(((_export_soldier select _i)select 3)select 0),(((_export_soldier select _i)select 3)select 1),(((_export_soldier select _i)select 3)select 2),(((_export_soldier select _i)select 4)select 0),(((_export_soldier select _i)select 4)select 1),(((_export_soldier select _i)select 4)select 2)];
	};
};
_output = _output + "};" + _br + _tab2 + "};" + _br;






copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";


