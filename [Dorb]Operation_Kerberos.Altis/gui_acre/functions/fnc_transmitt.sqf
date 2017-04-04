/*
 *  Author: Dorbedo
 *
 *  Description:
 *      transfers the local hashes into global ones
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACE("transmitting");
private _target = GVAR(radioSettingsTarget);

If !([_target] call FUNC(canSaveRadioList)) exitWith {};


private _currentRadios = (_target getVariable [QGVAR(radios),[]]) select {!(isNull _x)};
private _newRadios = GVAR(tempRadioList);
private _newList = [];


{
    private _curRadioHash = _x;
    private _copyTarget = LHASH_GET_DEF(_curRadioHash,"isCopyOf",locationNull);
    If !(isNull _copyTarget) then {
        // compare the values and update if needed;
        private _keys =+ LHASH_GET(_curRadioHash,"keysOrdered");
        _keys append ["keysOrdered","radioType","presetName","channel","channelName"];
        {
            private _curKey = _x;
            private _newVal = LHASH_GET(_curRadioHash,_curKey);
            If !(GHASH_GET(_copyTarget,_curKey) isEqualTo _newVal) then {
                GHASH_SET(_copyTarget,_curKey,_newVal);
            };
        } forEach _keys;
        _newList pushBack _copyTarget;
    }else{
        private _newHash = GHASH_CREATE;
        private _keys =+ LHASH_GET(_curRadioHash,"keysOrdered");
        _keys append ["keysOrdered","radioType","presetName","channel","channelName"];
        {
            private _newVal = LHASH_GET(_curRadioHash,_x);
            GHASH_SET(_newHash,_x,_newVal);
        } forEach _keys;

        _newList pushBack _newHash;
    };
} forEach _newRadios;

// delete old hashes to clear the space
{
    If !(_x in _newRadios) then {
        GHASH_DELETE(_x);
    };
} forEach _currentRadios;

_target setVariable [QGVAR(radios),_newList,true];
