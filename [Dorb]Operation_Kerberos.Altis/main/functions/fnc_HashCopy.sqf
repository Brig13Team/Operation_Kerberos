/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      copys a hash
 *
 *  Parameter(s):
 *      0 : LOCATION - Hash to copy
 *
 *  Returns:
 *      LOCATION - copied hash
 *
 */
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull,[]]]];

If (_hash isEqualType []) exitWith {
    _hash call FUNC(HashCopyArray);
};

private _newHash = HASH_CREATE;
If !(IS_HASH_ALL(_hash)) exitWith {_newHash};

{
    private _value = _hash getVariable _x;
    private _key = _x;
    If (IS_ARRAY(_value)) then {
        _newHash setVariable [_key,(_value call FUNC(HashCopyArray))];
    }else{
        If (IS_HASH_ALL(_value)) then {
            _newHash setVariable [_key,(_value call FUNC(HashCopy))];
        }else{
            _newHash setVariable [_key,_value];
        };
    };
} forEach (allVariables _hash);
_newHash;
