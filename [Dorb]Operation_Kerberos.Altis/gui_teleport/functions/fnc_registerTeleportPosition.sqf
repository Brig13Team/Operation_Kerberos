/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a vehicle Teleport Target
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : STRING - Type ("default","Ship","Air")
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_position",[],[[],{}],[3]],["_targetName","",[""]],["_type","",["",[]]],["_condition",{true},[{}]],["_params",[],[[]]]];

CHECK(_position isEqualTo [])

If (IS_ARRAY(_type)) exitWith {
    {
        [_position,_targetName,_x,_condition,_params] call FUNC(registerTeleportPosition);
    } forEach _type;
};

switch (toLower _type) do {
    case "air" : {
        GVAR(pos_air) pushBack [_position,_targetName,_condition,_params];
    };
    case "ship" : {
        GVAR(pos_ship) pushBack [_position,_targetName,_condition,_params];
    };
    case "infanterie" : {
        GVAR(pos_infanterie) pushBack [_position,_targetName,_condition,_params];
    };
    default {
        GVAR(pos_default) pushBack [_position,_targetName,_condition,_params];
    };
};
