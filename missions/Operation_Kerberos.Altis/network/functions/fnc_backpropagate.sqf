#include "script_component.hpp"

/*
    Name: dorb_network_fnc_backpropagate
    Author: Dorbedo
    description

    Arguments:
        0: argument name <TYPENAME>

    Return Value:
        return name <TYPENAME>

    Public: Yes
*/

params ["_trainingdata", "_testdata", "_learnrate", "_epoch", "_hidden"];

private _input = count _trainingdata;
private _output = (count (_trainingdata select 0)) - 1;

private _network = [_input, _hidden, _output] call FUNC(initialize);

[_network, _trainingdata, _learrate, _epoch, _output] call FUNC(train);

private _predictions = [];

{
    private _curPred = [_network, _x] call FUNC(predict);
    _predictions append _curPred;
} forEach _trainingdata

_repdictions
