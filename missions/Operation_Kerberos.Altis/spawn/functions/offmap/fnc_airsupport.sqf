/**
 * Author: Dorbedo
 * spawns an offmap Air-support
 *
 * Arguments:
 * 0: <ARRAY> the target position
 * 1: <STRING> the type
 * 2: <CODE> callback
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_position",[],[[]],[2,3]],
    ["_type","",[""]],
    ["_callback","",[{},""]]
];

if (isNil QGVARMAIN(side_type)) then {
    [] call FUNC(army_set);
};
