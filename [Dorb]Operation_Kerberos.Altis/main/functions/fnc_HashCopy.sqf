/*
	Author: Dorbedo

	Description:
		copys a hash

	Parameter(s):
		None

	Return
		None
*/
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull,[]]]];

If (_hash isEqualType []) exitWith {
    _hash call FUNC(HashCopyArray);
};

private _newHash = call FUNC(HashCreate);
If !(IS_HASH(_hash)) exitWith {_newHash};

{
    private _value = _hash getVariable _x;
    private _key = _x;
    If (IS_ARRAY(_value)) then {
        _newHash setVariable [_key,(_value call FUNC(HashCopyArray))];
    }else{
        If (IS_HASH(_value)) then {
            _newHash setVariable [_key,(_value call FUNC(HashCopy))];
        }else{
            _newHash setVariable [_key,_value];
        };
    };
} forEach (allVariables _hash);
_newHash;
