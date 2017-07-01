/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "Return to Base"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];
private _type = HASH_GET(_mission, "type");

HASH_SET(_mission, "condition", QFUNC(mainmission__rtb_condition));

private _marker = getText(ConfigFile >> "CfgKerberos" >> "mission" >> "main" >> _type >> "object" >> "position");
private _radius = getNumber(ConfigFile >> "CfgKerberos" >> "mission" >> "main" >> _type >> "object" >> "radius");
//private _location =  ["Base", getMarkerPos _marker];
private _location =  ["Base", getMarkerPos GVARMAIN(respawnmarker)];

[QEGVAR(gui,message),[LSTRING(RTB_TITLE),LSTRING(RTB_DESC),"blue"]] spawn CBA_fnc_globalEvent;

HASH_SET(_mission, "location", _location);
HASH_SET(_mission, "radius", _radius);
