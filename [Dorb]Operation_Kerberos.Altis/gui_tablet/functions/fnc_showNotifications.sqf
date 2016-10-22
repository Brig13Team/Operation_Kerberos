/*
 *  Author: DOrbedo
 *
 *  Description:
 *      shows the notifications
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

private _allNotifications = HASH_KEYS(GVAR(notifications));


for "_i" from 0 to 6 do {

};




{
    If (_forEachIndex > 6) exitWith {}
    private _key = _x;
    (HASH_GET(GVAR(notifications),_key)) params ["_picture","_condition","_target"];



} forEach _allNotifications;
