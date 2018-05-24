/*
    Author: Dorbedo

    hint typeOf cursorTarget;[cursortarget] execVM "scripte\fnc_logHelperCargo.sqf";
*/

params[["_vehicle",objNull,[objNull]]];

if(isNull _vehicle) exitWith {hint "Kein Fahrzeug übergeben"};

DORB_HELPER_VEH=_vehicle;
DORB_HELPER_SIZE=[0,0,0];
DORB_HELPER_OFFSET=[0,0,0];

If (!(isNil "DORB_HELPER_ARROW")) then {
    {deleteVehicle _x} forEach DORB_HELPER_ARROW;
};

If (!(isNil "DORB_HELPER_ID")) then {
    [DORB_HELPER_ID] call CBA_fnc_removePerFrameHandler;
};


DORB_HELPER_ARROW = [
    (createVehicle ["Sign_Arrow_F", [0,0,0], [], 0, "CAN_COLLIDE"]),(createVehicle ["Sign_Arrow_Pink_F", [0,0,0], [], 0, "CAN_COLLIDE"]),
    (createVehicle ["Sign_Arrow_Blue_F", [0,0,0], [], 0, "CAN_COLLIDE"]),(createVehicle ["Sign_Arrow_Cyan_F", [0,0,0], [], 0, "CAN_COLLIDE"]),
    (createVehicle ["Sign_Arrow_Green_F", [0,0,0], [], 0, "CAN_COLLIDE"]),(createVehicle ["Sign_Arrow_Yellow_F", [0,0,0], [], 0, "CAN_COLLIDE"])
    ];

DORB_HELPER_ID = [{
    private["_pos"];
    If (isNull DORB_HELPER_VEH) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;{deleteVehicle _x} forEach DORB_HELPER_ARROW;};
    _pos = DORB_HELPER_VEH modelToWorld [(((DORB_HELPER_SIZE select 0)/2)+(DORB_HELPER_OFFSET select 0)),0,(DORB_HELPER_OFFSET select 2)-((DORB_HELPER_SIZE select 2)/2)];
    (DORB_HELPER_ARROW select 0) setPos _pos;
    _pos = DORB_HELPER_VEH modelToWorld [((-1*(DORB_HELPER_SIZE select 0))/2)+(DORB_HELPER_OFFSET select 0),0,(DORB_HELPER_OFFSET select 2)-((DORB_HELPER_SIZE select 2)/2)];
    (DORB_HELPER_ARROW select 1) setPos _pos;
    _pos = DORB_HELPER_VEH modelToWorld [0,((DORB_HELPER_SIZE select 1)/2)+(DORB_HELPER_OFFSET select 1),(DORB_HELPER_OFFSET select 2)-((DORB_HELPER_SIZE select 2)/2)];
    (DORB_HELPER_ARROW select 2) setPos _pos;
    _pos = DORB_HELPER_VEH modelToWorld [0,((-1*(DORB_HELPER_SIZE select 1))/2)+(DORB_HELPER_OFFSET select 1),(DORB_HELPER_OFFSET select 2)-((DORB_HELPER_SIZE select 2)/2)];
    (DORB_HELPER_ARROW select 3) setPos _pos;
    _pos = DORB_HELPER_VEH modelToWorld [((DORB_HELPER_SIZE select 0)/2)+(DORB_HELPER_OFFSET select 0),((DORB_HELPER_SIZE select 1)/2)+(DORB_HELPER_OFFSET select 1),((DORB_HELPER_SIZE select 2)/2)+(DORB_HELPER_OFFSET select 2)];
    (DORB_HELPER_ARROW select 4) setPos _pos;
    _pos = DORB_HELPER_VEH modelToWorld [((-1*(DORB_HELPER_SIZE select 0))/2)+(DORB_HELPER_OFFSET select 0),((-1*(DORB_HELPER_SIZE select 1))/2)+(DORB_HELPER_OFFSET select 1),((-1*(DORB_HELPER_SIZE select 2))/2)+(DORB_HELPER_OFFSET select 2)];
    (DORB_HELPER_ARROW select 5) setPos _pos;
}, 0, []] call CBA_fnc_addPerFrameHandler;
