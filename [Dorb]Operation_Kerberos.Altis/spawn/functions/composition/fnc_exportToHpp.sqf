/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports a composition for *.hpp file
 *
 *  Parameter(s):
 *      0 : LOCATION - the composition saved as HASH
 *
 *  Returns:
 *      STRING - the composition to save in the hpp
 *
 */
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull]],["_classname",format["composition_%1",floor(random 1000000)],[""]],["_tabsamount",1,[0]],["_isRecursive",false,[true]]];


TRACEV_4(_hash,_classname,_tabsamount,_isRecursive);

If (isNull _hash) exitWith {""};



private _tab = "    ";
private _br = toString [0x0D, 0x0A];

private _output = "";

for "_i" from 1 to _tabsamount do {
    _output = _output + _tab;
};

_output = _output + format ["class %1 {%2",_classname,_br];

{
    private _curKey = _x;
    private _value = HASH_GET(_hash,_curKey);
    IF (IS_HASH(_value)) then {
        _output = _output + ([_value,_curKey,_tabsamount + 1,true] call FUNC(composition_exportToHpp));
    }else{
        for "_i" from 1 to (_tabsamount + 1) do {
            _output = _output + _tab;
        };
        If (IS_ARRAY(_value)) then {
            private _arr = str _value;
            _arr = [_arr,"[","{"] call CBA_fnc_replace;
            _arr = [_arr,"]","}"] call CBA_fnc_replace;
            _output = _output + format ["%1[] = %2;",_curKey,_arr] + _br;
        }else{
            private _tesst = [_value isEqualType true];

            If (IS_BOOL(_value)) then {
                _value = [0,1] select _value;
            };
            If (IS_STRING(_value)) then {
                _output = _output + format ["%1 = ""%2"";",_curKey,_value] + _br;
            }else{
                _output = _output + format ["%1 = %2;",_curKey,_value] + _br;
            };
        };
    };
} forEach (HASH_KEYS(_hash));

for "_i" from 1 to (_tabsamount) do {
    _output = _output + _tab;
};
_output = _output + "};" + _br;

If (_isRecursive) exitWith {_output;};


copyToClipboard _output;
If (canSuspend) then {uisleep 3;};
hint "copied to clipboard";
