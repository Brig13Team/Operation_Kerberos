/*
 *  Author: Dorbedo
 *
 *  Description:
 *      load the advertisements
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

private _return = ["getAdvertisements"] call DB_get;

private _loadedAdverts = [];

{
    _loadedAdverts pushBack [_x,(_return select 1)select _forEachIndex];
} forEach (_return select 0);


if !(_loadedAdverts isEqualTo []) then {
    GVAR(advertisements) = _loadedAdverts;
};

If !( GVAR(advertisements) == GVAR(lastadvertisements) ) then {
    GVAR(lastadvertisements) = GVAR(advertisements);
    publicVariable QGVAR(advertisements);
};
