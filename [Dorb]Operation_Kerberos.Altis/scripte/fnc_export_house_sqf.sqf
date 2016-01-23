/*
    Author: Dorbedo
    
    called via:
        [cursorTarget,25] execVM "fnc_export_obj_sqf.sqf";

    
    class Housename_randomnumber {
        material[] = {  {classname,position,direction,offset,vectorUp}  };
        vehicles[] = {  {classname,position,direction,offset,vectorUp}  };        //static and vehicles
        soldier[] = {  {classname,position,direction,offset,vectorUp}  };
    };
*/

params[["_house",objNull,[objNull]],["_radius",25,[0]]];

hint "Export in progess....";

If (isNull _house) exitWith {};

_houseType = typeOf _house;
_housePos = getPosASL _house;
_houseVDir = VectorDir _house;
_houseVUp = VectorUp _house;

private _allObjects = _house nearObjects [["CAManBase","Static","LandVehicle","Air","Ship"],_radius];
private _exportarray = [];

_fnc_rotVector = {
    _this params ["_vector","_dir"];
    _vector params ["_x","_y"];
    _vector set [0,(cos _dir)*_x - (sin _dir) * _y];
    _vector set [1,(sin _dir)*_x + (cos _dir) * _y];
    _vector;
};

_fnc_formatRotMat = {
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

_fnc_getRollPitchYaw = {
    _this params ["_objectDir","_objectUp",["_Roll",0,[0]],["_Nick",0,[0]],["_Gier",0,[0]]];

    private _objectDir = VectorDir _object;
    private _objectUp = VectorUp _object;

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

_fnc_ObjGetRollPitchYaw = {
    _this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
    private _objectDir = VectorDir _object;
    private _objectUp = VectorUp _object;
    [_objectDir,_objectUp,_roll,_nick,_gier] call _fnc_getRollPitchYaw;
};

_fnc_ObjGetRotMat = {
    _this params [["_object",objNull,[objNull]],["_roll",0,[0]],["_nick",0,[0]],["_gier",0,[0]]];
    private _tempRollPitchYaw = [_object] call _fnc_ObjGetRollPitchYaw;
    [_tempRollPitchYaw] call _fnc_formatRotMat;
};

([_houseVDir,_houseVUp] call _fnc_getRollPitchYaw) params ["_house_roll","_house_pitch","_house_yaw"];

{
    private _temp = []
    If !(isPlayer _x) then {
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

private _output = _tab2 + format["class %1_ver%2 {",_houseType,floor(random 99999)] + _br
+ _tab3 + "material[] = {";
If ((count(_export_material))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((((_export_material select _i)select 2)select 0)select 0),((((_export_material select _i)select 2)select 0)select 1),((((_export_material select _i)select 2)select 0)select 2),((((_export_material select _i)select 2)select 1)select 0),((((_export_material select _i)select 2)select 1)select 1),((((_export_material select _i)select 2)select 1)select 2),((((_export_material select _i)select 2)select 2)select 0),((((_export_material select _i)select 2)select 2)select 1),((((_export_material select _i)select 2)select 2)select 2)];
    For "_i" from 1 to (count _export_material -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((((_export_material select _i)select 2)select 0)select 0),((((_export_material select _i)select 2)select 0)select 1),((((_export_material select _i)select 2)select 0)select 2),((((_export_material select _i)select 2)select 1)select 0),((((_export_material select _i)select 2)select 1)select 1),((((_export_material select _i)select 2)select 1)select 2),((((_export_material select _i)select 2)select 2)select 0),((((_export_material select _i)select 2)select 2)select 1),((((_export_material select _i)select 2)select 2)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((((_export_vehicles select _i)select 2)select 0)select 0),((((_export_vehicles select _i)select 2)select 0)select 1),((((_export_vehicles select _i)select 2)select 0)select 2),((((_export_vehicles select _i)select 2)select 1)select 0),((((_export_vehicles select _i)select 2)select 1)select 1),((((_export_vehicles select _i)select 2)select 1)select 2),((((_export_vehicles select _i)select 2)select 2)select 0),((((_export_vehicles select _i)select 2)select 2)select 1),((((_export_vehicles select _i)select 2)select 2)select 2)];
    For "_i" from 1 to (count _export_vehicles -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((((_export_vehicles select _i)select 2)select 0)select 0),((((_export_vehicles select _i)select 2)select 0)select 1),((((_export_vehicles select _i)select 2)select 0)select 2),((((_export_vehicles select _i)select 2)select 1)select 0),((((_export_vehicles select _i)select 2)select 1)select 1),((((_export_vehicles select _i)select 2)select 1)select 2),((((_export_vehicles select _i)select 2)select 2)select 0),((((_export_vehicles select _i)select 2)select 2)select 1),((((_export_vehicles select _i)select 2)select 2)select 2)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((((_export_soldier select _i)select 2)select 0)select 0),((((_export_soldier select _i)select 2)select 0)select 1),((((_export_soldier select _i)select 2)select 0)select 2),((((_export_soldier select _i)select 2)select 1)select 0),((((_export_soldier select _i)select 2)select 1)select 1),((((_export_soldier select _i)select 2)select 1)select 2),((((_export_soldier select _i)select 2)select 2)select 0),((((_export_soldier select _i)select 2)select 2)select 1),((((_export_soldier select _i)select 2)select 2)select 2)];
    For "_i" from 1 to (count _export_soldier -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{{%5,%6,%7},{%8,%9,%10},{%11,%12,%13}}}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((((_export_soldier select _i)select 2)select 0)select 0),((((_export_soldier select _i)select 2)select 0)select 1),((((_export_soldier select _i)select 2)select 0)select 2),((((_export_soldier select _i)select 2)select 1)select 0),((((_export_soldier select _i)select 2)select 1)select 1),((((_export_soldier select _i)select 2)select 1)select 2),((((_export_soldier select _i)select 2)select 2)select 0),((((_export_soldier select _i)select 2)select 2)select 1),((((_export_soldier select _i)select 2)select 2)select 2)];
    };
};
_output = _output + "};" + _br + _tab2 + "};" + _br;


copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";