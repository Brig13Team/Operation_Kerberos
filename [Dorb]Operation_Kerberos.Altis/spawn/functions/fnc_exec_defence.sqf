/*
    Author: Dorbedo

    Description:
        Spawns predefined defencepositions

    Parameter(s):
        0 : ARRAY    - Startpos
        1 : ARRAY     - ConfigArray
        2 : SCALAR    - Centerdirection

    [(getMarkerPos "testmarker"),["missionConfigFile","defence_positions","terrain","bunker_medium"],0] execVM "functions\fnc_spawn_macro_exec3d";
    
*/
#include "script_component.hpp"
_this params [ ["_centerpos",[],[[]]],["_centerdir",0,[0]],["_material",[],[[]]],["_vehicles",[],[[]]],["_soldiers",[],[[]]] ];

If (_centerpos isEqualTo []) exitWith {};

_centerpos set [2,0];
_centerpos = ATLToASL _centerpos;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentOffset select 2)];
        _newpos = ATLToASL _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentPos select 2)];
        _newpos = ATLToASL _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    };
    diag_log [_currentObjectType,_newpos];
    private _vehicle = createVehicle [_currentObjectType,_newpos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
} forEach _material;
private _gruppe = grpNull;
If ((count _vehicles)>0) then {
    _gruppe = createGroup GVARMAIN(side);
    SETVAR(_gruppe,EGVAR(headquarter,state),"defend");
    SETVAR(_gruppe,EGVAR(headquarter,target),_centerpos);
};

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentOffset select 2)];
        _newpos = ATLToASL _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentPos select 2)];
        _newpos = ATLToASL _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    };
    diag_log [_currentObjectType,_newpos];
    private _vehicle = createVehicle [_currentObjectType,_newpos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
    
    If ("Artillery" in getArray(configFile>>"cfgVehicles">>_currentObjectType>>"availableforsupporttypes")) then {[QEGVAR(headquarter,register_artillery),[_vehicle]] call CBA_fnc_serverEvent;};
    _vehicle enableSimulation true;
    
    If (!(_vehicle isKindOf "StaticWeapon")) then {
        [_vehicle,_gruppe] call FUNC(crew);
        _vehicle setFuel 0;
        _vehicle lock 3;
    }else{
        _vehicle lock 0;
        [_vehicle,_gruppe] call FUNC(crew);
        private["_watchpos"];
        _watchpos = [_newpos,250,_gier] call BIS_fnc_relPos;
        _watchpos set[2,0];
        (gunner _vehicle) doWatch (_watchpos);
    };
} forEach _vehicles;

If ((count _soldiers)>0) then {
    _gruppe = createGroup GVARMAIN(side);
    SETVAR(_gruppe,EGVAR(headquarter,state),"defend");
    SETVAR(_gruppe,EGVAR(headquarter,target),_centerpos);
};

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_currentOffset",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [];
    If (_currentPos isEqualTo [0,0,0]) then {
        _newpos = [_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D;
        _newpos = _centerpos vectorAdd _newpos;
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentOffset select 2)];
        _newpos = ATLToASL _newpos;
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    }else{
        _newpos = _centerpos vectorAdd ([_currentPos,-1*_centerdir] call BIS_fnc_rotateVector2D);
        private _terNorm = surfaceNormal _newpos;
        _newpos set [2,(_currentPos select 2)];
        _newpos = ATLToASL _newpos;
        _newpos = _newpos vectorAdd ([_currentOffset,-1*_centerdir] call BIS_fnc_rotateVector2D);
        _gier = _gier + _centerdir;
        _nick = (_terNorm select 0) atan2 (_terNorm select 2) + _nick;
        _wank = (_terNorm select 1) atan2 (_terNorm select 2) + _wank;
    };
    private _currentObjectType = [_currentObjectType] call FUNC(get_Similar_Class);
    private _vehicle = _gruppe createUnit[_currentObjectType,_newpos, [], 0, "NONE"];
    doStop _vehicle;
    _vehicle setPosASL _newpos;
    [_vehicle,[_gier,_wank,_nick]] call BIS_fnc_setobjectrotation;
} forEach _soldiers;
