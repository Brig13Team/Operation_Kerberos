#include "script_component.hpp"

/*
    Name: dorb_network_fnc_updateWeights
    Author: Dorbedo
    description

    Arguments:
        0: argument name <TYPENAME>

    Return Value:
        return name <TYPENAME>

    Public: Yes
*/

params ["_network", "_row", "_learnrate"];
for "_i" from 0 to ((count _network) - 1) do {
    private _inputs = _row select [0, (count _network) - 2];
    if (_i != 0) then {
        _inputs =
    } else {

    };
};


update_weights

def update_weights(network, row, l_rate):
    for i in range(len(network)):
        inputs = row[:-1]
        if i != 0:
            inputs = [neuron['output'] for neuron in network[i - 1]]
        for neuron in network[i]:
            for j in range(len(inputs)):
                neuron['weights'][j] += l_rate * neuron['delta'] * inputs[j]
            neuron['weights'][-1] += l_rate * neuron['delta']
