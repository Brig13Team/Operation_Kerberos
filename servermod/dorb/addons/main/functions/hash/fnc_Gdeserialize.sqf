/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deserializes a hash
 *
 *  Parameter(s):
 *      0 : ARRAY - Hash in array form
 *
 *  Returns:
 *      LOCATION - Hash
 *
 */
#include "script_component.hpp"

#define SELF EFUNC(main,hash_Gdeserialize)
_this params ["_toDeserialize"];
If (IS_SERIALIZEDHASH(_toDeserialize)) exitWith {
    _toDeserialize params ["","_keys","_values"];
    private _hash = GHASH_CREATE;
    {
        private _val = _values select _forEachIndex;
        If (IS_SERIALIZEDHASH(_val)) then {
            _val = [_val] call SELF;
        }else{
            If (IS_ARRAY(_val)) then {
                _val = [_val] call SELF;
            };
        };
        GHASH_SET(_hash,_x,_val);
    } forEach _keys;
    _hash;
};
If (IS_ARRAY(_toDeserialize)) exitWith {
    private _return = [];
    {
        _return pushBack ([_x] call SELF);
        nil;
    } count _toDeserialize;
    _return;
};
_toDeserialize;
