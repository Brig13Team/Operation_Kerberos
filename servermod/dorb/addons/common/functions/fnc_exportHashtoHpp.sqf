/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports a hash into a hpp-file
 *
 *  Parameter(s):
 *      0 : LOCATION - the hash to be exported
 *
 *  Returns:
 *      STRING - the composition to save in the hpp
 *
 */
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull]],["_tabsamount",0,[0]],["_isRecursive",false,[true]]];

If (isNull _hash) exitWith {""};

private _tab = "";
private _keys = (HASH_KEYS(_hash));
private _sortedKeys = (_keys select {!IS_AHASH(HASH_GET(_hash,_x))}) + (_keys select {IS_AHASH(HASH_GET(_hash,_x))});

{
    private _curKey = _x;
    private _value = HASH_GET(_hash,_curKey);
    IF (IS_AHASH(_value)) then {
        _tab = "";
        for "_i" from 1 to (_tabsamount + 1) do {
            _tab = _tab + "    ";
        };
        "ace_clipboard" callExtension format["%1class %2 {%3",_tab,_curKey,endl];
        [_value,_tabsamount + 1,true] call FUNC(exportHashtoHpp);
        "ace_clipboard" callExtension format["%1};%2",_tab,endl];
    }else{
        _tab = "";
        for "_i" from 1 to (_tabsamount + 1) do {
            _tab = _tab + "    ";
        };
        If (IS_ARRAY(_value)) then {
            private _arr = str _value;
            _arr = [_arr,"[","{"] call CBA_fnc_replace;
            _arr = [_arr,"]","}"] call CBA_fnc_replace;
            "ace_clipboard" callExtension format ["%1%2[] = %3;%4",_tab,_curKey,_arr,endl];
        }else{
            If (IS_BOOL(_value)) then {
                _value = [0,1] select _value;
            };
            If (IS_STRING(_value)) then {
                "ace_clipboard" callExtension format ["%1%2 = ""%3"";%4",_tab,_curKey,_value,endl];
            }else{
                "ace_clipboard" callExtension format ["%1%2 = %3;%4",_tab,_curKey,_value,endl];
            };
        };
    };
} forEach _sortedKeys;

If (_isRecursive) exitWith {};

"ace_clipboard" callExtension format["%1  ",endl];
"ace_clipboard" callExtension "--COMPLETE--";
hint "copied to clipboard";
