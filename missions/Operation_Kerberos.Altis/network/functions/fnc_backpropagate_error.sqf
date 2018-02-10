#include "script_component.hpp"

/*
    Name: dorb_network_fnc_backpropagate_error
    Author: Dorbedo
    description

    Arguments:
        0: argument name <TYPENAME>

    Return Value:
        return name <TYPENAME>

    Public: Yes
*/

params ["_network", "_expected"];

private _reversednetwork =+ _network;
reverse _reversednetwork;

for "_i" from (count _reversednetwork -1 ) to 0 step -1 do {
    private _layer = _network select _i;
    private _errors = [];
    if (_i != (count _network)) then {
        for "_j" from 0 to ((count _layer) -1 ) do {
            private _error = 0;
            {
                error = error + (([_x, 'weights'] call CBA_fnc_hashGet) select _j) * ([_x, 'delta'] call CBA_fnc_hashGet);
            } forEach (_network select (_i + 1));
            _errors pushBack _error;
        };
    } else {
        for "_j" from 0 to ((count _layer) -1 ) do {
            private _neuron = _layer select _j;
            errors pushBack ((_expected select _j) - ([_neuron, 'output'] call CBA_fnc_hashGet));
        };
    };
    for "_j" from 0 to ((count _layer) -1 ) do {
        private _neuron = _layer select j;
        private _delta = (errors select _j) * (([_neuron, 'output'] call CBA_fnc_hashGet) * (1 - ([_neuron, 'output'] call CBA_fnc_hashGet)));
        [_neuron, 'delta', _delta] call CBA_fnc_hashSet;
    };
};
