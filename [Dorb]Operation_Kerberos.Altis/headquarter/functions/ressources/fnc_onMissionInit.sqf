/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sets the values after the mission has started
 *
 *  Parameter(s):
 *      0 : LOCATION - the missionhash
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

//if (HASH_HASKEY(_mission, "side")) exitWith { -1 };

{
    private _curRes = _x;
    private _curResHash = HASH_GET(GVAR(ressources),_curRes);
    HASH_SET(_curResHash,"nextexecution",-1);
    HASH_SET(_curResHash,"units",[]);
    private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountCAS");
    HASH_SET(_curResHash,"amount",_amount);
    private _timer = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "replenishCAS");
    If (_timer <= 0) then {_timer = 15*60;};
    HASH_SET(_curResHash,"replenish",_timer);
} forEach ["cas","helicopter","airinterception"];
