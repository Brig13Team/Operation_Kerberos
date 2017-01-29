/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows a notification
 *
 *  Parameter(s):
 *      0 : STRING - Unique ID
 *      1 : STRING - Text
 *      2 : STRING - Image-Path
 *      3 : CODE - condition to show the notification
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    ["_ID","",[""]],
    ["_imgPath","",[""]],
    ["_conditionToShow",{false},[{}]],
    ["_parameter",[],[[]]]
];

CHECK((_ID isEqualTo "")||(_imgPath isEqualTo ""))

private "_hash";
If !(HASH_HASKEY(GVAR(notifications),"ID")) then {
    _hash = HASH_GET(GVAR(notifications),"ID");
}else{
    _hash = HASH_CREATE;
};

HASH_SET(_hash,"img",_imgPath);
HASH_SET(_hash,"condition",_conditionToShow);
HASH_SET(_hash,"parameter",_parameter);
