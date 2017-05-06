/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!isServer)

If (isNil QEGVAR(mission,rescuepositions)) then {
    {
        if !(_x isEqualTo [0,0,0]) then {
            EGVAR(mission,rescuepositions) pushBack _x;
        };
    } forEach [
        (getMarkerPos "bay_east"),
        (getMarkerPos "bay_west"),
        (getMarkerPos "bay_north"),
        (getMarkerPos "bay_south")
    ];
};
