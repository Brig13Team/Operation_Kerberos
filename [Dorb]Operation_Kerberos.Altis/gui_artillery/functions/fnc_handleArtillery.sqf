/*
 *  Author: [Name of Author(s)]
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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_args",["_handle",-1]];
_args params ["_vehicle","_player","_gunner"];

//TRACEV_3(_vehicle,_player,_gunner);


if ((!(player in (crew _vehicle)))||{(_vehicle getVariable [QGVAR(state),0])<1}) exitWith {
    GVAR(artilleryHandle) = nil;
    GVAR(curArtillery) setFuel (GVAR(curArtillery) getVariable [QGVAR(fuelsave),1]);
    GVAR(curArtillery) lockTurret [[0],false];
    [_handle] call CBA_fnc_removePerFrameHandler;
    [_gunner] spawn FUNC(drivePos);
};


private _reloadtime = 14; //TODO evaluate this time
private _lastShot = GVAR(curArtillery) getVariable [QGVAR(lastShot),-100];
private _state = GVAR(curArtillery) getVariable [QGVAR(state),0];

If ((_state == 1)&&{(_lastShot + _reloadtime)<CBA_missiontime}) then {
    GVAR(curArtillery) setVariable [QGVAR(state),2];
};

private _dummyPos = GVAR(curArtillery) getVariable [QGVAR(cur_dummyPos),[100,100,100]];
private _posASL = getPosASL GVAR(curArtillery);
private _watchpos = ASLtoAGL (_dummyPos vectorAdd _posASL);
_gunner doWatch _watchpos;
TRACEV_3(_dummyPos,_posASL,_watchpos);
