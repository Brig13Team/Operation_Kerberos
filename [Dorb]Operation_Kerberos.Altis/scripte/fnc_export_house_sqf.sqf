/*
    Author: Dorbedo

    Rotation nach DIN 8855
        1. Gier
        2. Nick
        3. Wank


    Call via:
        [cursorTarget,25] execVM "fnc_export_house_sqf.sqf";


    class Housename_randomnumber {
        housetype = "Classname";
        material[] = {  {classname,position,direction,offset,vectorUp}  };
        vehicles[] = {  {classname,position,direction,offset,vectorUp}  };        //static and vehicles
        soldier[] = {  {classname,position,direction,offset,vectorUp}  };
    };
*/

_this params[["_haus",objNull,[objNull]],["_radius",25,[0]]];
hint "Export in progess....";
If (isNull _haus) exitWith {hint "No Object";};
private _haustyp = typeOf _haus;
private _hauspos = getPosASL _haus;

private _alleobjekte = nearestObjects [_haus,["CAManBase","Static","LandVehicle","Air","Ship"],_radius];
private _exportarray = [];

private _fnc_getPitchBank = {
    _this params ["_obj"];
    private _yaw = getdir _obj;
    private _vdir = vectordir _obj;
    _vdir = [_vdir, _yaw] call BIS_fnc_rotateVector2D;
    private _vdirY = _vdir select 1;
    if (_vdirY == 0) then {_vdirY = 0.01;};
    private _pitch = atan ((_vdir select 2) / _vdirY);
    private _vup = vectorup _obj;
    _vup = [_vup, _yaw] call BIS_fnc_rotateVector2D;
    private _vupZ = _vup select 2;
    if (_vupZ == 0) then {_vupZ = 0.01;};
    private _bank = atan ((_vup select 0) / _vupZ);
    [_pitch, _bank];
};

(_haus call _fnc_getPitchBank) params ["_haus_Wank","_haus_Nick"];
private _haus_Gier = getDir _haus;

{
    private _temp = [];
    If !(isPlayer _x) then {
        private _currentObject = _x;

        private _currenttype = typeOf _currentObject;
        private _currentPos = getPosASL _currentObject;
        private _temppos = _currentPos vectorDiff _hauspos;
        
        (_currentObject call _fnc_getPitchBank) params ["_obj_Wank","_obj_Nick"];
        private _obj_Gier = getDir _currentObject;

        private _wank = _haus_Wank + _obj_Wank;
        private _nick = _haus_Nick + _obj_Nick;
        private _gier = _haus_Gier + _obj_Gier;
        
        _temp = [_currenttype,_temppos,_wank,_nick,_gier];
    };
    If !(_temp isEqualTo []) then {
        _exportArray pushBack _temp;
    };
}forEach (_alleobjekte - [_haus]);;


private _export_vehicles = [];
private _export_soldier = [];
private _export_material = [];
private _export_targets = [];

{
    If ((_x select 0) isKindOf "Land_CargoBox_V1_F") then {
        _export_targets pushBack _x;
    }else{
        if ((_x select 0) isKindOf "LandVehicle") then {
            _export_vehicles pushBack _x;
        }else{
            If ((_x select 0) isKindOf "Man") then {
                _export_soldier pushBack _x;
            }else{
                _export_material pushBack _x;
            };
        };
    };
}forEach _exportarray;


private _br = toString [0x0D, 0x0A];
private _tab = "    "; // changed into spaces - toString[0x09];
private _tab2 = _tab + _tab;
private _tab3 = _tab2 + _tab;

private _output = _tab2 + format["class %1_ver%2 {",_haustyp,floor(random 99999)] + _br
+ _tab3 + format["housetype = ""%1"";",_haustyp] + _br
+ _tab3 + "material[] = {";
If ((count(_export_material))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,%6,%7}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),((_export_material select _i)select 3),((_export_material select _i)select 4)];
    For "_i" from 1 to (count _export_material -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,%6,%7}",((_export_material select _i)select 0),(((_export_material select _i)select 1)select 0),(((_export_material select _i)select 1)select 1),(((_export_material select _i)select 1)select 2),((_export_material select _i)select 2),((_export_material select _i)select 3),((_export_material select _i)select 4)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "vehicles[] = {";
If ((count(_export_vehicles))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,%6,%7}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),((_export_vehicles select _i)select 3),((_export_vehicles select _i)select 4)];
    For "_i" from 1 to (count _export_vehicles -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,%6,%7}",((_export_vehicles select _i)select 0),(((_export_vehicles select _i)select 1)select 0),(((_export_vehicles select _i)select 1)select 1),(((_export_vehicles select _i)select 1)select 2),((_export_vehicles select _i)select 2),((_export_vehicles select _i)select 3),((_export_vehicles select _i)select 4)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "soldiers[] = {";
If ((count(_export_soldier))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,%6,%7}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),((_export_soldier select _i)select 3),((_export_soldier select _i)select 4)];
    For "_i" from 1 to (count _export_soldier -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,%6,%7}",((_export_soldier select _i)select 0),(((_export_soldier select _i)select 1)select 0),(((_export_soldier select _i)select 1)select 1),(((_export_soldier select _i)select 1)select 2),((_export_soldier select _i)select 2),((_export_soldier select _i)select 3),((_export_soldier select _i)select 4)];
    };
};
_output = _output + "};" + _br
+ _tab3 + "targets[] = {";
If ((count(_export_targets))>0) then {
    _i=0;
    _output = _output + format["{%1,{%2,%3,%4},%5,%6,%7}",((_export_targets select _i)select 0),(((_export_targets select _i)select 1)select 0),(((_export_targets select _i)select 1)select 1),(((_export_targets select _i)select 1)select 2),((_export_targets select _i)select 2),((_export_targets select _i)select 3),((_export_targets select _i)select 4)];
    For "_i" from 1 to (count _export_targets -1) do {
        _output = _output + format[",{%1,{%2,%3,%4},%5,%6,%7}",((_export_targets select _i)select 0),(((_export_targets select _i)select 1)select 0),(((_export_targets select _i)select 1)select 1),(((_export_targets select _i)select 1)select 2),((_export_targets select _i)select 2),((_export_targets select _i)select 3),((_export_targets select _i)select 4)];
    };
};
_output = _output + "};" + _br + _tab2 + "};" + _br;


copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";