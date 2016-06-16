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
*            Functions
*
*
*******************************************************************/

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
        reverse _nextObjects;
        {
            if (((getPosASL _x)select 2) < (_objPosASL select 2)) exitWith {_currentObject = _x};
        } forEach _nextObjects;
        _currentObject;
    };
};

/*******************************************************************
*
*
*            Get all Objects
*
*
*******************************************************************/
_this params[["_center",[0,0,0],[[],objNull],[3,2]],["_radius",25,[0]],["_centerDir",nil,[0]]];

hint "Export in progess....";

private ["_centerPosASL","_centerPosATL"];

If (_center isEqualType objNull) then {
    If (isNil "_centerDir") then {
        _centerDir = getDir _center;
    };
    _centerPosATL = getPosATL _center;
    _centerPosATL set [2,0];
    _centerPosASL = ATLtoASL _centerPosASL;
}else{
    If (isNil "_centerDir") then {_centerDir = 0;};
    _centerPosATL = _center;
    _centerPosATL set [2,0];
    _centerPosASL = ATLtoASL _centerPosATL;
};

private _allObjects = nearestObjects [_centerPosATL,[],_radius];
_allObjects = _allObjects select {((!(isPlayer _x))&&(!((toLower(format["%1",typeOf _x])) in ["camera","#dynamicsound","#animator"])))};
private _exportarray = [];


{
    private _currentObject = _x;
    private _pos = [0,0,0];
    private _type = typeOf _currentObject;
    private _gier = direction _currentObject;
    private _offset = (getPosASL _currentObject) vectorDiff _centerPosASL;
    (_currentObject call BIS_fnc_getPitchBank) params ["_wank","_nick"];
    private _objBelow = [_currentObject] call _fnc_getObjectBelow;
    If !(isNull _objBelow) then {
        _pos = (getPosASL _objBelow) vectorDiff _centerPosASL;
        _offset = (getPosASL _currentObject) vectorDiff (getPosASL _objBelow);
    };
    _exportarray pushBack [_type,_pos,_offset,_wank,_nick,_gier];
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
private _tab4 = _tab3 + _tab;

private _output = _tab3 + format["class defencepos_%1 {",floor(random 99999)] + _br
+ _tab4 + "material[] = {";
If ((count(_export_material))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),(((_export_material select _i)select 2)select 0),(((_export_material select _i)select 2)select 1),(((_export_material select _i)select 2)select 2),((_export_material select _i)select 3),((_export_material select _i)select 4),((_export_material select _i)select 5)];
    For "_i" from 1 to (count _export_material -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),(((_export_material select _i)select 2)select 0),(((_export_material select _i)select 2)select 1),(((_export_material select _i)select 2)select 2),((_export_material select _i)select 3),((_export_material select _i)select 4),((_export_material select _i)select 5)];
    };
};
_output = _output + "};" + _br
+ _tab4 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),(((_export_vehicles select _i)select 2)select 0),(((_export_vehicles select _i)select 2)select 1),(((_export_vehicles select _i)select 2)select 2),((_export_vehicles select _i)select 3),((_export_vehicles select _i)select 4),((_export_vehicles select _i)select 5)];
    For "_i" from 1 to (count _export_vehicles -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),(((_export_vehicles select _i)select 2)select 0),(((_export_vehicles select _i)select 2)select 1),(((_export_vehicles select _i)select 2)select 2),((_export_vehicles select _i)select 3),((_export_vehicles select _i)select 4),((_export_vehicles select _i)select 5)];
    };
};
_output = _output + "};" + _br
+ _tab4 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),(((_export_soldier select _i)select 2)select 0),(((_export_soldier select _i)select 2)select 1),(((_export_soldier select _i)select 2)select 2),((_export_soldier select _i)select 3),((_export_soldier select _i)select 4),((_export_soldier select _i)select 5)];
    For "_i" from 1 to (count _export_soldier -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},{%5,%6,%7},%8,%9,%10}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),(((_export_soldier select _i)select 2)select 0),(((_export_soldier select _i)select 2)select 1),(((_export_soldier select _i)select 2)select 2),((_export_soldier select _i)select 3),((_export_soldier select _i)select 4),((_export_soldier select _i)select 5)];
    };
};
_output = _output + "};" + _br + _tab3 + "};" + _br;


copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";