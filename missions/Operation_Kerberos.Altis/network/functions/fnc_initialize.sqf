#include "script_component.hpp"

/*
    Name: dorb_network_fnc_initialize
    Author: Dorbedo
    initializes a network

    Arguments:
        0: argument name <TYPENAME>

    Return Value:
        return name <TYPENAME>

    Public: Yes
*/

params ["_inputs","_hidden","_outputs"];

private _network = [];

private _fnc_array = {
    params ["_outer","_inner"];
    private _ret = [];
    for "_i" from 0 to _outer do {
        private _temp = [];
        for "_j" from 0 to (_inner + 1) do {
            _temp pushBack (9999 random 1);
        };
        _ret pushBack _temp;
    };
    _ret;
};


private _hidden = [_hidden, _inputs] call _fnc_array;
_network pushBack _hidden;
private _output = [_outputs, _hidden] call _fnc_array;
_network pushBack _output;

_network
