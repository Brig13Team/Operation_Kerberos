/*
 *  Author: Dorbedo
 *
 *  Description:
 *      basic Settings
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

acre_api_basicMissionSetup = true;
acre_player setVariable ["acre_api_basicMissionSetup", true, true];
// diable the basic mission setup
CHECK(true)


if (!hasInterface) exitWith {true};

private _defaultRadios = [
    "",
    "",
    "",
    ""
];

private _addRadios = {
    params ["_defaultRadios", "_player"];

    // Don't regive radios if already given
    if (_player getVariable ["acre_api_basicMissionSetup", false]) exitWith {};
    _player setVariable ["acre_api_basicMissionSetup", true, true];

    private _cleanRadioList = [];
    if !("ACRE_PRC343" in _defaultRadios) then {
        [_player, "ItemRadio"] call acre_sys_core_fnc_removeGear;
        [_player, "ACRE_PRC343"] call acre_sys_core_fnc_removeGear;
        _cleanRadioList = _defaultRadios;
    } else {
        private _countDefaultRadios = 0;
        {
            if (_x == "ACRE_PRC343") then {
                _countDefaultRadios = _countDefaultRadios + 1;
                if (_countDefaultRadios > 1) then {
                    _cleanRadioList pushBack _x;
                };
            } else {
                _cleanRadioList pushBack _x;
            };
        } forEach _defaultRadios;

    };


    if ((backpack _player == "") && {!((["ACRE_PRC77", "ACRE_PRC117F"] arrayIntersect _cleanRadioList) isEqualTo [])}) then {
        _player addBackpack "B_AssaultPack_khk";
    };

    {
        if (_x != "") then {
            _player addItem _x;
        };
    } forEach _cleanRadioList;
};

[{
    !isNull acre_player
}, {
    [_this select 0, acre_player] call (_this select 1);
}, [_defaultRadios, _addRadios]] call CBA_fnc_waitUntilAndExecute;
