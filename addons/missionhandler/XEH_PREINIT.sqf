#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(rescuepoints) = [];

If ((getMarkerPos "rescuepoint_west") isEqualTo [0, 0, 0]) then {
    ["rescuepoint_west", west] call FUNC(rescuepoint_add);
};
If ((getMarkerPos "rescuepoint_east") isEqualTo [0, 0, 0]) then {
    ["rescuepoint_east", east] call FUNC(rescuepoint_add);
};
If ((getMarkerPos "rescuepoint_independent") isEqualTo [0, 0, 0]) then {
    ["rescuepoint_independent", independent] call FUNC(rescuepoint_add);
};
