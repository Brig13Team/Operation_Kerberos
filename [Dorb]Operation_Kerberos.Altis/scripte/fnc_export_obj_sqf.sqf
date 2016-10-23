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

_this params[["_centerpos",[0,0,0],[[],objNull],[3,2]],["_radius",25,[0]],["_centerdir",nil,[0]]];

hint "Export in progess....";

If (_centerpos isEqualType objNull) then {
    _centerpos = getPosATL _centerpos;
};
/// set center on ground
_centerpos set[2,0];

if (isNil "_centerdir") then {
    _centerdir = getDir _centerpos;
};

private _allObjects = _centerpos nearObjects _radius;
private _exportarray = [];
private _centerposASL = ATLtoASL _centerpos;


//// FUNKTIONS
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
    _this params ["_VectorDir","_VectorUp",["_Roll",0,[0]],["_Nick",0,[0]],["_Gier",0,[0]]];

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

private _fnc_ObjGetVDirVup = {
    _this params [["_object",objNull,[objNull]]];

    private _objectVDir = VectorDir _object;
    private _objectVUp = VectorUp _object;
    private _objectDir = getDir _object;

    private _VectorDir = [_objectVDir,_objectDir] call _fnc_rotVector;
    private _VectorUp = [_objectVUp,_objectDir] call _fnc_rotVector;
    [_VectorDir,_VectorUp];
};


private _fnc_ObjGetRollPitchYaw = {
    _this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
    ([_object] call _fnc_ObjGetVDirVup) params ["_objectDir","_objectUp"];
    [_objectDir,_objectUp,_roll,_nick,_gier] call _fnc_getRollPitchYaw;
};

private _fnc_ObjGetRotMat = {
    _this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
    private _tempRollPitchYaw = [_object] call _fnc_ObjGetRollPitchYaw;
    [_tempRollPitchYaw] call _fnc_formatRotMat;
};

















/// offset = [position,direction,vectorUp];
private _fnc_getoffset = {
    _this params["_object","_positionASL"];
    
    private "_offset";
    private _nextObject = [_object] call _fnc_getObjbelow;
    If (isNull _nextObject) then {
        private _objDir = getDir _object;
        private _objPosASL = getPosASL _object;
        private _objVectorUp = vectorUp _object;
        private _terrainNormal = surfaceNormal (getPosATL _object);
        private _offsetVector = vectorNormalized(_terrainNormal VectorAdd _objVectorUp);
        _offset = [_objPosASL,_objDir,_offsetVector];
    }else{
        _offset = [_nextObject,_positionASL] call _fnc_getoffset;
    };
    _offset
};

private _fnc_getObjbelow = {
    _this params["_object"];
    private["_objPosASL","_terrainPosASL","_terrainPos","_terrainPosATL","_nextObject"];
    private _objPosASL = getPosASL _object;
    private _terrainPosATL = getPosATL _object;
    private _terrainPos = [(_terrainPosATL select 0),(_terrainPosATL select 1),0];
    private _terrainPosASL = ATLtoASL _terrainPos;
    private _nextObject = lineIntersectsObjs [_objPosASL, _terrainPosASL, objNull, _object, false, 2];
    if (_nextObject isEqualTo []) then {
        objNull
    }else{
        private _lastObject = [_nextObject select 0] call _fnc_getObjbelow;
        If (isNull _lastObject) then {
            _lastObject;
        }else{
            _nextObject select 0;
        };
    };
};

/// _centerdir _centerposASL _centerpos
{
    If ((!(isPlayer _x))&&(!((toLower(format["%1",typeOf _x])) in ["camera","#dynamicsound"]))) then {
        private _temp = [];
        private _nextObject = [_x] call _fnc_getObjbelow;
        If (isNull _nextObject) then {
            private _currentObject = _x;
            private _currenttype = typeOf _currentObject;
            private _currentPos = getPosASL _currentObject;
            private _currentRotMat = [_currentObject,_house_roll,_house_pitch,_house_yaw] call _fnc_ObjGetRotMat;
            
        
        
        }else{
        
        
        };
        private _currentObject = _x;
        private _currenttype = typeOf _currentObject;
        private _currentPos = getPosASL _currentObject;
        private _currentRotMat = [_currentObject,_house_roll,_house_pitch,_house_yaw] call _fnc_ObjGetRotMat;
        private _temppos = _housePos vectorDiff _currentPos;
        private _temppos = [_temppos,_house_yaw] call _fnc_rotVector;
        _temp = [_currenttype,_temppos,_currentRotMat];
    };
    If !(_temp isEqualTo []) then {
        _exportArray pushBack _temp;
    };
}forEach _allObjects;





{
    If ((!(isPlayer _x))&&(!((toLower(format["%1",typeOf _x])) in ["camera","#dynamicsound"]))) then {
        private _temp = [];
        private _nextObject = [_x] call _fnc_getObjbelow;
        If (isNull _nextObject) then {
            /// obj has nothing below -> offset = [0,0,0]
            private _objDir = getDir _x;
            private _objVectorUp = vectorUp _x;
            private _objPosASL = getPosASL _x;
            private _terrainNormal = surfaceNormal (getPosATL _x);
            private _temptype = typeOf _x;
            private _temppos = _centerposASL VectorDiff _objPosASL;
            private _tempdir = _centerdir + _objDir;
            If (_tempdir >= 360) then {_tempdir = _tempdir - 360;};
            private _tempoffset = [0,0,0];
            private _tempvector = vectorNormalized(_terrainNormal VectorAdd _objVectorUp);
            _temp = [_temptype,_temppos,_tempdir,_tempoffset,_tempvector];
        }else{
            /// something below -> get offset
            private _objDir = getDir _x;
            private _objVectorUp = vectorUp _x;
            private _objPosASL = getPosASL _x;
            private _offsetArray = [_x,_objPosASL] call _fnc_getoffset;
            private _refpos = _offsetArray select 0;
            private _refdir = _offsetArray select 1;
            private _refVector = _offsetArray select 2;
            private _temptype = typeOf _x;
            private _temppos = _centerposASL VectorDiff _refpos;
            private _tempdir = _centerdir + /*_refdir +*/ _objDir;
            If (_tempdir >= 360) then {_tempdir = _tempdir - 360;};
            private _tempoffset = _refpos VectorDiff _objPosASL;
            private _tempvector = vectorNormalized(_refVector VectorAdd _objVectorUp);
            _temp = [_temptype,_temppos,_tempdir,_tempoffset,_tempvector];
        };
        If (!(_temp isEqualTo [])) then {
            _exportarray pushBack _temp;
        };
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
    _output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",    ((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),(((_export_material select _i)select 3)select 0),(((_export_material select _i)select 3)select 1),(((_export_material select _i)select 3)select 2),(((_export_material select _i)select 4)select 0),(((_export_material select _i)select 4)select 1),(((_export_material select _i)select 4)select 2)];
    For "_i" from 1 to (count _export_material -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),(((_export_material select _i)select 3)select 0),(((_export_material select _i)select 3)select 1),(((_export_material select _i)select 3)select 2),(((_export_material select _i)select 4)select 0),(((_export_material select _i)select 4)select 1),(((_export_material select _i)select 4)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",    ((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),(((_export_vehicles select _i)select 3)select 0),(((_export_vehicles select _i)select 3)select 1),(((_export_vehicles select _i)select 3)select 2),(((_export_vehicles select _i)select 4)select 0),(((_export_vehicles select _i)select 4)select 1),(((_export_vehicles select _i)select 4)select 2)];
    For "_i" from 1 to (count _export_vehicles -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),(((_export_vehicles select _i)select 3)select 0),(((_export_vehicles select _i)select 3)select 1),(((_export_vehicles select _i)select 3)select 2),(((_export_vehicles select _i)select 4)select 0),(((_export_vehicles select _i)select 4)select 1),(((_export_vehicles select _i)select 4)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",    ((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),(((_export_soldier select _i)select 3)select 0),(((_export_soldier select _i)select 3)select 1),(((_export_soldier select _i)select 3)select 2),(((_export_soldier select _i)select 4)select 0),(((_export_soldier select _i)select 4)select 1),(((_export_soldier select _i)select 4)select 2)];
    For "_i" from 1 to (count _export_soldier -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,{%6,%7,%8},{%9,%10,%11}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),(((_export_soldier select _i)select 3)select 0),(((_export_soldier select _i)select 3)select 1),(((_export_soldier select _i)select 3)select 2),(((_export_soldier select _i)select 4)select 0),(((_export_soldier select _i)select 4)select 1),(((_export_soldier select _i)select 4)select 2)];
    };
};
_output = _output + "};" + _br + _tab2 + "};" + _br;






copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";


