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
_this params [ ["_house",objNull,[objNull]],["_material",[],[[]]],["_vehicles",[],[[]]],["_soldiers",[],[[]]] ];

If (isNull _house) exitWith {};

private _housePos = getPosASL _house;
(_house call BIS_fnc_getPitchBank) params ["_haus_Wank","_haus_Nick"];
private _haus_Gier = getDir _house;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _vehicle = createVehicle [_currentObjectType,_setPos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
} forEach _material;

If ((count _vehicles)>0) then {
    _gruppe = createGroup GVARMAIN(side);
    SETVAR(_gruppe,EGVAR(headquarter,state),"defend");
    SETVAR(_gruppe,EGVAR(headquarter,target),_centerpos);
};

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _vehicle = createVehicle [_currentObjectType,_setPos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
    
    If ("Artillery" in getArray(configFile>>"cfgVehicles">>_currentObjectType>>"availableforsupporttypes")) then {[_vehicle] call EFUNC(headquarter,fdc_register);};
    _vehicle enableSimulation true;
    [_vehicle,_gruppe] call FUNC(crew);
    If (!(_vehicle isKindOf "StaticWeapon")) then {
        _vehicle setFuel 0;
        _vehicle lock 3;
    }else{
        _vehicle lock 0;
        private["_watchpos"];
        _watchpos = [_setPos,250,(_gier + _haus_Gier)] call BIS_fnc_relPos;
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
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _currentObjectType = [_currentObjectType] call FUNC(get_Similar_Class);
    private _vehicle = _gruppe createUnit[_currentObjectType,_setPos, [], 0, "NONE"];
    //private _vehicle = createVehicle [_currentObjectType,_setPos, [], 0, "CAN_COLLIDE"];
    
    doStop _vehicle;
    
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
} forEach _soldiers;
