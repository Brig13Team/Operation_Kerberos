/*
    Author: Dorbedo

    Description:


    Parameter(s):
   
    
*/
_this params [ ["_centerpos",[],[[]]],["_centerdir",0,[0]],["_material",[],[[]]],["_vehicles",[],[[]]],["_soldiers",[],[[]]] ];

If (_centerpos isEqualTo []) exitWith {};

_centerpos set [2,0];
_centerpos = ATLToASL _centerpos;

private _gruppe = createGroup east;
test3=[];
{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    };
    diag_log [_currentObjectType,_newpos];
    private _vehicle = createVehicle [_currentObjectType,_newpos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
    test3 pushBack _vehicle;
} forEach _material;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    };
    diag_log [_currentObjectType,_newpos];
    private _vehicle = createVehicle [_currentObjectType,_newpos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
    test3 pushBack _vehicle;
} forEach _vehicles;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 1) atan2 1 + _nick;
        _wank = (_terNorm select 0) atan2 1 + _wank;
    };
    private _vehicle = _gruppe createUnit[_currentObjectType,_newpos, [], 0, "NONE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
    
    test3 pushBack _vehicle;
} forEach _soldiers;
