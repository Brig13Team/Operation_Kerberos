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
    _hash call FUNC(hash_AcopyArray);
};

private _newHash = call FUNC(hash_Acreate);
If !(IS_AHASH(_hash)) exitWith {_newHash};

{
    private _value = _hash getVariable _x;
    private _key = _x;
    If (IS_ARRAY(_value)) then {
        _newHash setVariable [_key,([_value] call FUNC(hash_AcopyArray))];
    }else{
        If (IS_AHASH(_value)) then {
            _newHash setVariable [_key,([_value] call FUNC(hash_Acopy))];
        }else{
            _newHash setVariable [_key,_value];
        };
    };
} forEach (allVariables _hash);
_newHash;
