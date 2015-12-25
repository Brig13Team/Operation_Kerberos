/*
    Author: Dorbedo
    
    called via:
        [(getPos player),25,(getDir player)] execVM "fnc_export_obj_sqf.sqf";
        [player,25] execVM "fnc_export_obj_sqf.sqf";
        [cursorTarget,25] execVM "fnc_export_obj_sqf.sqf";

    
    class defencepostionname {
        
        material[] = {  {classname,position,direction,offset,vectorUp}  };
        vehicles[] = {  {classname,position,direction,offset,vectorUp}  };        //static and vehicles
        soldier[] = {  {classname,position,direction,offset,vectorUp}  };
    };
*/
/*******************************************************************
*
*
*			Functions
*
*
*******************************************************************/

private _fnc_rotVector = {
	_this params ["_vector","_dir"];
	_vector params ["_x","_y"];
	_vector set [0,(cos _dir)*_x - (sin _dir) * _y];
	_vector set [1,(sin _dir)*_x + (cos _dir) * _y];
	_vector;
};

private _fnc_formatRotMat = {
	_this params ["_Rollwinkel","_Nickwinkel","_Gierwinkel"];
	[[
		(cos _Gierwinkel) * (cos _Nickwinkel),
		(sin _Gierwinkel) * (cos _Nickwinkel),
		(-1 * (sin _Nickwinkel))
	 ],
	 [
		(cos _Gierwinkel) * (sin _Nickwinkel) * (sin _Rollwinkel) - (sin _Gierwinkel) * (cos _Rollwinkel),
		(sin _Gierwinkel) * (sin _Nickwinkel) * (sin _Rollwinkel) + (cos _Gierwinkel) * (cos _Rollwinkel),
		(cos _Nickwinkel) * (sin _Rollwinkel)
	 ],
	 [
		(cos _Gierwinkel) * (sin _Nickwinkel) * (cos _Rollwinkel) + (sin _Gierwinkel) * (sin _Rollwinkel),
		(sin _Gierwinkel) * (sin _Nickwinkel) * (cos _Rollwinkel) - (cos _Gierwinkel) * (sin _Rollwinkel),
		(cos _Nickwinkel) * (cos _Rollwinkel)
	]];
};

private _fnc_getRollPitchYaw = {
	_this params ["_objectDir","_objectUp",["_Roll",0,[0]],["_Nick",0,[0]],["_Gier",0,[0]]];

	private _Rollwinkel = 0;
	private _Gierwinkel = 0;
	private _Nickwinkel = 0;

	private _objectVDir = VectorDir _object;
	private _objectVUp = VectorUp _object;
	private _objectVSide = _objectVDir VectorcrossProduct _objectVUp;
	private _objectDir = getDir _object;

	private _VectorDir = [_objectVDir,_objectDir] call _fnc_rotVector;
	private _VectorUp = [_objectVUp,_objectDir] call _fnc_rotVector;

	private _VectorDirY = _VectorDir select 1;
	private _VectorUpZ = _VectorUp select 2;

	if (_VectorDirY == 0) then {_VectorDirY = 0.01;};
	if (_VectorUpZ == 0) then {_VectorUpZ = 0.01;};

	_Nickwinkel = atan ((_VectorDir select 2) / _VectorDirY);
	_Rollwinkel = atan ((_VectorUp select 0) / _VectorUpZ);
	_Gierwinkel = 360 - _objectDir;

	if((_VectorUp select 2) < 0) then {
		_Rollwinkel = _Rollwinkel - ([1,-1] select (_Rollwinkel < 0)) * 180;
	};
	
	_Rollwinkel = _Rollwinkel - _Roll;
	_Nickwinkel = _Nickwinkel - _Nick;
	_Gierwinkel = _Gierwinkel - _Gier;
	[_Rollwinkel,_Nickwinkel,_Gierwinkel];
};

private _fnc_ObjGetRollPitchYaw = {
	_this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
	private _objectDir = VectorDir _object;
	private _objectUp = VectorUp _object;
	[_objectDir,_objectUp,_roll,_nick,_gier] call _fnc_getRollPitchYaw;
};

private _fnc_ObjGetRotMat = {
	_this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
	private _tempRollPitchYaw = [_object] call _fnc_ObjGetRollPitchYaw;
	[_tempRollPitchYaw] call _fnc_formatRotMat;
};

private _fnc_getOffset = {
	_this params ["_object"];
	private _lastObject = _object;
	private _nextObject = _object;
	while {!isNull _nextObject} do {
		_lastObject = _nextObject;
		_nextObject = [_lastObject] call _fnc_getObjectBelow;
	};
	private _objPosASL = getPosASL _object;
	private _objBelowPosASL = getPosASL _lastObject;
	private ["_offset","_RotMat"];
	If ((_objPosASL distance _objBelowPosASL) < 0.5) then {
		_offset = [0,0,0];
		_RotMat = [_object] call _fnc_ObjGetRotMat;
	}else{
		_offset = _objBelowPosASL vectorDiff _objPosASL;
		([vectorDir _lastObject,surfaceNormal _objBelowPosASL] call _fnc_getRollPitchYaw) params ["_roll","_pitch","_yaw"];
		_RotMat = [_object,_roll,_pitch,_yaw] call _fnc_ObjGetRotMat;
	};
	[_objPosASL,_offset,_RotMat];
};

private _fnc_getObjectBelow = {
    _this params["_object"];
    private _objPosASL = getPosASL _object;
	private _terrainPosASL =+ _objPosASL;
	_terrainPosASL set [2,0];
	_terrainPosASL = ATLtoASL _terrainPosASL;
    private _nextObjects = lineIntersectsObjs [_objPosASL, _terrainPosASL, objNull, _object, true, 2];
    if (_nextObjects isEqualTo []) then {
		objNull
	}else{
		private _currentObject = objNull;
		For "_i" from (count _nextObject) to 0 step -1 do {
			_currentObject = _nextObjects select _i;
			if (((getPosASL _currentObject)select 2) < (_objPosASL select 2)) exitWith {_currentObject};
			_currentObject = objNull;
		};
		_currentObject;
	};
};

/*******************************************************************
*
*
*			Get all Objects
*
*
*******************************************************************/
_this params[["_center",[0,0,0],[[],objNull],[3,2]],["_radius",25,[0]],["_centerDir",nil,[0]]];

hint "Export in progess....";

private ["_centerPosASL","_centerPos","_centerVDir","_centerVUp"];

If (_center isEqualType objNull) then {
    If (isNil "_centerDir") then {
		_centerDir = getDir _center;
	};
	_centerVUp = [0,0,1];
	_centerVDir = [[0,1,0],_centerDir] call _fnc_rotVector;
	_centerPosASL = getPosATL _center;
	_centerPosASL set [2,0];
	_centerPosASL = ATLtoASL _centerPosASL;
}else{
	If (isNil "_centerDir") then {_centerDir = 0;};
	_centerVUp = [0,0,1];
	_centerVDir = [[0,1,0],_centerDir] call _fnc_rotVector;
	_centerPos = _center;
	_centerPos set [2,0];
	_centerPosASL = ATLtoASL _centerPos;
};

private _allObjects = _centerposASL nearObjects _radius;
private _exportarray = [];

/// offset = [position,direction,vectorUp];
// [ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentRotMat",[],[[]]]  ]

{
    If ((!(isPlayer _x))&&(!((toLower(format["%1",typeOf _x])) in ["Camera","#dynamicsound"]))) then {
		private _currentObject = _x;
        ([_currentObject] call _fnc_getOffset) params ["_currentPos","_currentOffset","_currentRotMat"];
        [typeOf _currentObject,_currentPos,_currentOffset,_currentRotMat];
    };
}forEach _allObjects;

////// Sort the output
private _export_vehicles = [];
private _export_soldier = [];
private _export_material = [];

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
private _br = toString [0x0D, 0x0A];
private _tab = "    "; // changed into spaces - toString[0x09];
private _tab2 = _tab + _tab;
private _tab3 = _tab2 + _tab;

private _output = _tab2 + format["class defencepos_%1 {",floor(random 99999)] + _br
+ _tab3 + "material[] = {";
If ((count(_export_material))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),(((_export_material select _i)select 2)select 0),(((_export_material select _i)select 2)select 1),(((_export_material select _i)select 2)select 2),((((_export_material select _i)select 3)select 0)select 0),((((_export_material select _i)select 3)select 0)select 1),((((_export_material select _i)select 3)select 0)select 2),((((_export_material select _i)select 3)select 1)select 0),((((_export_material select _i)select 3)select 1)select 1),((((_export_material select _i)select 3)select 1)select 2),((((_export_material select _i)select 3)select 2)select 0),((((_export_material select _i)select 3)select 2)select 1),((((_export_material select _i)select 3)select 2)select 2)];
    For "_i" from 1 to (count _export_material -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),(((_export_material select _i)select 2)select 0),(((_export_material select _i)select 2)select 1),(((_export_material select _i)select 2)select 2),((((_export_material select _i)select 3)select 0)select 0),((((_export_material select _i)select 3)select 0)select 1),((((_export_material select _i)select 3)select 0)select 2),((((_export_material select _i)select 3)select 1)select 0),((((_export_material select _i)select 3)select 1)select 1),((((_export_material select _i)select 3)select 1)select 2),((((_export_material select _i)select 3)select 2)select 0),((((_export_material select _i)select 3)select 2)select 1),((((_export_material select _i)select 3)select 2)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),(((_export_vehicles select _i)select 2)select 0),(((_export_vehicles select _i)select 2)select 1),(((_export_vehicles select _i)select 2)select 2),((((_export_vehicles select _i)select 3)select 0)select 0),((((_export_vehicles select _i)select 3)select 0)select 1),((((_export_vehicles select _i)select 3)select 0)select 2),((((_export_vehicles select _i)select 3)select 1)select 0),((((_export_vehicles select _i)select 3)select 1)select 1),((((_export_vehicles select _i)select 3)select 1)select 2),((((_export_vehicles select _i)select 3)select 2)select 0),((((_export_vehicles select _i)select 3)select 2)select 1),((((_export_vehicles select _i)select 3)select 2)select 2)];
    For "_i" from 1 to (count _export_vehicles -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),(((_export_vehicles select _i)select 2)select 0),(((_export_vehicles select _i)select 2)select 1),(((_export_vehicles select _i)select 2)select 2),((((_export_vehicles select _i)select 3)select 0)select 0),((((_export_vehicles select _i)select 3)select 0)select 1),((((_export_vehicles select _i)select 3)select 0)select 2),((((_export_vehicles select _i)select 3)select 1)select 0),((((_export_vehicles select _i)select 3)select 1)select 1),((((_export_vehicles select _i)select 3)select 1)select 2),((((_export_vehicles select _i)select 3)select 2)select 0),((((_export_vehicles select _i)select 3)select 2)select 1),((((_export_vehicles select _i)select 3)select 2)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),(((_export_soldier select _i)select 2)select 0),(((_export_soldier select _i)select 2)select 1),(((_export_soldier select _i)select 2)select 2),((((_export_soldier select _i)select 3)select 0)select 0),((((_export_soldier select _i)select 3)select 0)select 1),((((_export_soldier select _i)select 3)select 0)select 2),((((_export_soldier select _i)select 3)select 1)select 0),((((_export_soldier select _i)select 3)select 1)select 1),((((_export_soldier select _i)select 3)select 1)select 2),((((_export_soldier select _i)select 3)select 2)select 0),((((_export_soldier select _i)select 3)select 2)select 1),((((_export_soldier select _i)select 3)select 2)select 2)];
    For "_i" from 1 to (count _export_soldier -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},{{%8,%9,%10},{%11,%12,%13},{%14,%15,%16}}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),(((_export_soldier select _i)select 2)select 0),(((_export_soldier select _i)select 2)select 1),(((_export_soldier select _i)select 2)select 2),((((_export_soldier select _i)select 3)select 0)select 0),((((_export_soldier select _i)select 3)select 0)select 1),((((_export_soldier select _i)select 3)select 0)select 2),((((_export_soldier select _i)select 3)select 1)select 0),((((_export_soldier select _i)select 3)select 1)select 1),((((_export_soldier select _i)select 3)select 1)select 2),((((_export_soldier select _i)select 3)select 2)select 0),((((_export_soldier select _i)select 3)select 2)select 1),((((_export_soldier select _i)select 3)select 2)select 2)];
    };
};
_output = _output + "};" + _br + _tab2 + "};" + _br;


copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";