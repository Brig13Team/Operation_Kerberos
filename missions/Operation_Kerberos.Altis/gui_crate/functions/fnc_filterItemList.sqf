/**
 * Author: Dorbedo
 * filters the itemlist
 *
 * Arguments:
 * 0: <ARRAY> the itemlist
 *
 * Return Value:
 * <ARRAY> the modified itemlist
 *
 */

#include "script_component.hpp"

params [["_itemlist",[],[[]]]];

_itemlist apply {
    [
        configname _x,
        [_x] call EFUNC(common,getModPicture),
        [_x] call EFUNC(common,getMod),
        [_x] call FUNC(getVehicleIcon),
        getText(_x >> "displayName"),
        _x
    ]
}
