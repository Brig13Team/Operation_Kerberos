/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the strength of a unit
 *
 *  Parameter(s):
 *      0 : STRING/OBEJCT - the Unit
 *
 *  Returns:
 *      ARRAY - the strengh-array
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_type","",["",objNull]]];
If (_type isEqualTo "") exitWith {[0,0,0]};

If (IS_OBJECT(_type)) then {
    If !(HASH_HASKEY(GVAR(strength),typeOf _type)) then {
        [typeOf _type,_type] call FUNC(initVehicle);
    };
    _type = typeOf _type;
} else {
    If !(HASH_HASKEY(GVAR(strength),_type)) then {
        [_type] call FUNC(initVehicle);
    };
};

HASH_GET(GVAR(strength),_type);
