/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      Serializes a hash
 *
 *  Parameter(s):
 *      0 : LOCATION - Hash to serialize
 *
 *  Returns:
 *      ARRAY - serialized Hash
 *
 */
#include "script_component.hpp"

#define SELF EFUNC(main,hash_serialize)
_this params ["_hash"];
If (IS_AHASH(_hash)) exitWith {
    private _keys = [];
    private _values = [];
    private _variables = allVariables _hash;
    {
        private _val = HASH_GET(_hash,_x);
        If (!isNil "_val") then {
            _keys pushBack _x;
            _values pushBack ([_val] call SELF);
        };
    } forEach _variables;
    [DORB_HASH_TYPE,_keys,_values];
};
If (IS_ARRAY(_hash)) exitWith {
    private _return = [];
    {
        _return pushBack ([_x] call SELF);
        nil;
    } count _hash;
    _return;
};
_hash;
