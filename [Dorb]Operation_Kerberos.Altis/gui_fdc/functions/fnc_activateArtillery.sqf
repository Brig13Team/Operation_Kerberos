/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"


_this params [["_vehicle",objNull,[objNull]],["_side",nil,[west]]];

CHECK((isNull _vehicle)||{isNil "_side"})

_vehicle lockTurret [[0,0],true];

private _group = createGroup _side;
private _unit = _group createUnit["B_UAV_AI",[0,0,0],[],0,"NONE"];

_unit moveInGunner _vehicle;

_unit allowFleeing 0;

_vehicle setVariable [QGVAR(isActivated),true];

If !(isNil QGVAR(handleArtilleryComputer)) then {
    [QGVAR(handleArtilleryComputer)] call CBA_fnc_removePerFrameHandler;
    _vehicle removeEventHandler ["fired",GVAR(firedHandle)];
};

[LINKFUNC(handleArtilleryComputer),0,[_vehicle,player]] call CBA_fnc_addPerFrameHandler;
_vehicle addEventhandler ["fired",LINKFUNC(handleFired)];
_vehicle setVariable [QGVAR(ready),true];
