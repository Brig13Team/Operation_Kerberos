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


private _curResHash = HASH_GET(GVAR(ressources),"cas");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"units",[]);
private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountCAS");
HASH_SET(_curResHash,"amount",_amount);
private _timer = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "replenishCAS");
If (_timer <= 0) then {_timer = 15*60;};
HASH_SET(_curResHash,"replenish",_timer);


private _curResHash = HASH_GET(GVAR(ressources),"helicopter");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"units",[]);
private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountAI");
HASH_SET(_curResHash,"amount",_amount);
private _timer = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "replenishAI");
If (_timer <= 0) then {_timer = 15*60;};
HASH_SET(_curResHash,"replenish",_timer);


private _curResHash = HASH_GET(GVAR(ressources),"airinterception");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"units",[]);
private _amount = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "amountHeli");
HASH_SET(_curResHash,"amount",_amount);
private _timer = getNumber(missionConfigFile >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "replenishHeli");
If (_timer <= 0) then {_timer = 15*60;};
HASH_SET(_curResHash,"replenish",_timer);
