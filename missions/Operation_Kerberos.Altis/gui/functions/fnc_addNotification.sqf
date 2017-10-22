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

params [
    ["_ID","",[""]],
    ["_imgPath","",[""]],
    ["_conditionToShow",{false},[{}]],
    ["_parameter",[]]
];

CHECK((_ID isEqualTo "")||(_imgPath isEqualTo ""))

TRACEV_6(_ID,HASH_HASKEY(GVAR(notifications),_ID),_imgPath,_conditionToShow,_parameter,_this);
private "_hash";
If (HASH_HASKEY(GVAR(notifications),_ID)) then {
    _hash = HASH_GET(GVAR(notifications),_ID);
}else{
    _hash = HASH_CREATE;
    HASH_SET(GVAR(notifications),_ID,_hash);
};

HASH_SET(_hash,"img",_imgPath);
HASH_SET(_hash,"condition",_conditionToShow);
HASH_SET(_hash,"parameter",_parameter);

If (isNil QGVAR(notification_handlerID)) then {
    TRACE("ADDING PFH");
    GVAR(notification_handlerID) = [
        FUNC(handleNotifications),
        NOTIFICATION_SHOW_DELAY,
        []
    ] call CBA_fnc_addPerFrameHandler;
};
