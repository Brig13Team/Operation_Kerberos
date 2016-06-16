/*
    Author: Dorbedo

    Description:


    Parameter(s):
   
    
*/
_this params [ ["_house",objNull,[objNull]],["_material",[],[[]]],["_vehicles",[],[[]]],["_soldiers",[],[[]]] ];

If (isNull _house) exitWith {};

private _housePos = getPosASL _house;
(_house call BIS_fnc_getPitchBank) params ["_haus_Wank","_haus_Nick"];
private _haus_Gier = getDir _house;

private _gruppe = createGroup east;
test3=[];
{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _vehicle = createVehicle [_currentObjectType,_setPos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
    test3 pushBack _vehicle;
} forEach _material;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _vehicle = createVehicle [_currentObjectType,_setPos, [], 0, "CAN_COLLIDE"];
    _vehicle enableSimulation false;
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
    test3 pushBack _vehicle;
} forEach _vehicles;

{
    _x params[ ["_currentObjectType","",[""]],["_currentPos",[],[[]]],["_wank",0,[0]],["_nick",0,[0]],["_gier",0,[0]]  ];
    
    private _newpos = [_currentPos,-1*_haus_Gier] call BIS_fnc_rotateVector2D;
    private _setPos = _housePos vectorAdd _newpos;
    private _vehicle = _gruppe createUnit[_currentObjectType,_setPos, [], 0, "NONE"];
    _vehicle setPosASL _setPos;
    [_vehicle,[(_gier + _haus_Gier),(_wank+_haus_Wank),(_nick+_haus_Nick)]] call BIS_fnc_setobjectrotation;
    test3 pushBack _vehicle;
} forEach _soldiers;
