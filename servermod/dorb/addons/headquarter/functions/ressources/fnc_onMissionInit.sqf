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

private _supportTimer = 15*60;
If ((count([] call CBA_fnc_players))<30) then {
    _supportTimer = 35*60;
};
If ((count([] call CBA_fnc_players))>30) then {
    _supportTimer = 9*60;
};

private _curResHash = HASH_GET(GVAR(ressources),"cas");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"replenish",_supportTimer);
private _isactive = 0 < (
    getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "cas_cluster")+
    getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "cas_gun")+
    getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "cas_missiles")
);
HASH_SET(_curResHash,"isActive",_isactive);


private _curResHash = HASH_GET(GVAR(ressources),"helicopter");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"replenish",_supportTimer);
private _isactive = 0 < (getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "cas_helicopter"));
HASH_SET(_curResHash,"isActive",_isactive);

private _curResHash = HASH_GET(GVAR(ressources),"airinterception");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"replenish",_supportTimer);
private _isactive = 0 < (getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "ai"));
HASH_SET(_curResHash,"isActive",_isactive);

private _curResHash = HASH_GET(GVAR(ressources),"drones");
HASH_SET(_curResHash,"nextexecution",-1);
HASH_SET(_curResHash,"replenish",_supportTimer);
private _isactive = 0 < (getNumber(ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn" >> "cas_drones"));
HASH_SET(_curResHash,"isActive",_isactive);
