/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a group for the grouptracker
 *
 *  Parameter(s):
 *      0 : GROUP - The GroupID
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_group"];

private _groupHash = HASH_CREATE;
GVAR(grouphashes) pushBack _groupHash;

_group setVariable [QGVAR(grouphash),_groupHash];

HASH_SET(_groupHash,"positions",[]);
HASH_SET(_groupHash,"symbol",[]);
HASH_SET(_groupHash,"size",[]);

private _value = switch (true) do {
    case ((side _group) == east) : {"o_"};
    case ((side _group) == resistance) : {"n_"};
    default {"b_"};
};
HASH_SET(_groupHash,"prefix",_value);
_value = [_group] call FUNC(getColor);
HASH_SET(_groupHash,"color",_value);
_groupHash;
