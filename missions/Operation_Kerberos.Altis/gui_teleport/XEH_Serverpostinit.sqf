/*
    Author: Dorbedo

    Description:
        postinit client
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(!isServer)

If (isNil QEGVAR(mission,rescuepositions)) then {
    EGVAR(mission,rescuepositions) = [];
};
{
    if !(_x isEqualTo [0,0,0]) then {
        EGVAR(mission,rescuepositions) pushBack _x;
        TRACEV_1(_x);
    };
} forEach [
    (getMarkerPos "bay_east"),
    (getMarkerPos "bay_west"),
    (getMarkerPos "bay_north"),
    (getMarkerPos "bay_south")
];
TRACEV_1(EGVAR(mission,rescuepositions));
