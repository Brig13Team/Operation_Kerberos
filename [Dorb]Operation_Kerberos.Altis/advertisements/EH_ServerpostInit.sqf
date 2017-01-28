/*
    Author: Dorbedo

*/
#include "script_component.hpp"
CHECK(!isServer)

GVAR(advertisements) = [];
GVAR(lastadvertisements) = [];

[
    {[] call FUNC(loadAdvertisements);},
    (60*30)
] call CBA_fnc_addPerFrameHandler;
