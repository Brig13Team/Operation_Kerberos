/*
    Author: Dorbedo

    Description:
        revon

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params ["_currentLocation"];
TRACEV_1(_currentLocation);
private _currentPos = getPos _currentLocation;
private _spawnpos = [_currentPos,4000,4000,10000] call FUNC(ressources_getsavespawnposair);
TRACEV_2(_currentPos,_spawnpos);
CHECKRET((_spawnpos isEqualTo []),0);

GVAR(callIn_cas) = GVAR(callIn_cas) - 1;


private _casVehType = ["plane_cas"] call EFUNC(spawn,getUnit);
_spawnpos set [2,1500];
_dir = [_spawnpos, _currentPos] call BIS_fnc_dirTo;
TRACEV_3(_casVehType,_spawnpos,_dir);
([_spawnpos,GVARMAIN(side),_casVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_casGroup","_casVeh"];

_casVeh flyInHeight 400;

[_casGroup, _currentPos, 0, "SAD", "COMBAT", "RED", "FULL", "NO CHANGE", _statement, [180,260,380], 80] call FUNC(waypoints_add);

_casGroup addWaypoint [_spawnpos, 0];
TRACEV_1(_casVeh);
[_casVeh,_spawnpos] spawn {
    SCRIPTIN(strategy_airinterception_reset);
    params ["_casVeh","_spawnpos"];
    uisleep 60;
    while {(alive _casVeh) && ((_casVeh distance2D _spawnpos)<100)} do {
        uisleep 5;
    };
    If (alive _casVeh) then {
        GVAR(callIn_cas) = GVAR(callIn_cas) + 1;
    };
};
([_casGroup] call FUNC(strength_ai)) params ["_type","_cost","_threat"];
