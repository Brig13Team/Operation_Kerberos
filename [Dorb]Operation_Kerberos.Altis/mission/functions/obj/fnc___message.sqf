 /*
 *  Author: iJesuz
 *
 *  Description:
 *      Display message
 *
 *  Parameter(s):
 *      0 : STRING  - type
 *      1 : STRING  - mission type
 *      1 : STRING  - (optional) color
 *      2 : [ANY]   - (optional) parameter
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_messageType","",[""]], ["_missionType","",[""]], ["_color","blue",[""]], ["_parameter", []]];

if !(hasInterface) exitWith { -1 };

private _message = toUpper(format ["%1_%2_%3", QUOTE(DOUBLES(STR,ADDON)), _missionType, _messageType]);
private _title = toUpper(format ["%1_%2_%3", QUOTE(DOUBLES(STR,ADDON)), _missionType, "TITLE"]);

// localize
// _title = localize _title;
_message = localize _message;
{ _message = format [_message, _x]; } forEach _parameter;

// create message
TRACEV_3(_title,_message,_color);
[_title, _message, _color] call EFUNC(gui,message);
