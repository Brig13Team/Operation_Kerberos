#include "script_component.hpp"

/*
    Name: dorb_network_fnc_train
    Author: Dorbedo
    description

    Arguments:
        0: argument name <TYPENAME>

    Return Value:
        return name <TYPENAME>

    Public: Yes
*/

params ["_network", "_traingingdata", "_learnrate", "_epoch", "_output"];

for "_i" from 0 to _epoch do {
    {
        private _curTrain = _x;
        private _outputs = [_network, _curTrain] call FUNC(forwardPropagate);
        private _expected = _curTrain select ((count _curTrain) - 1); // TODO
        [_network, _expected] call FUNC(backwardPropagate);
        [_network, _curTrain, _learnrate] call FUNC(updateWeights);
    } forEach _trainingdata;
};
