#include "script_component.hpp"
ADDON = false;

PREP(cache);
PREP(handler);
PREP(enable);
PREP(disable);

ADDON = true;

If (isNil QGVAR(distances)) then {
    GVAR(distances)=[
        2500, // footdistance to reveal
        3500, // vehiclesdistance to reveal
        3500, // airdistance to reveal
        1000, // distance to hide (added to footdistance)
    ];
};