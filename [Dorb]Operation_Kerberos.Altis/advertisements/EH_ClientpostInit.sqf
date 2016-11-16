


#include "script_component.hpp"
CHECK(!hasInterface)

If (isNil QGVAR(advertisements)) then {
    GVAR(advertisements) = [];
};

[
    {[] spawn FUNC(showAdvertisements);},
    (60*30)
] call CBA_fnc_addPerFrameHandler;
