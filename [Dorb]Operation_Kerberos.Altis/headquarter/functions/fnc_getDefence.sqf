/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the defence of a unit
 *
 *  Parameter(s):
 *      0 : STRING/OBEJCT - the Unit
 *
 *  Returns:
 *      ARRAY - the defence-array
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_type","",["",objNull]]];
If (_type isEqualTo "") exitWith {[0,0,0]};

If (IS_OBJECT(_type)) then {
    If !(HASH_HASKEY(GVAR(defence),typeOf _type)) then {
        [typeOf _type,_type] call FUNC(initVehicle);
    };
    _type = typeOf _type;
} else {
    If !(HASH_HASKEY(GVAR(defence),_type)) then {
        [_type] call FUNC(initVehicle);
    };
};

HASH_GET(GVAR(defence),_type);
