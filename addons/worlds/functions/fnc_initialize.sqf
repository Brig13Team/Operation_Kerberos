/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the map
 *
 *  Parameter(s):
 *      0 : STRING - worldName
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isClass(configfile >> "CfgKerberos" >> "worlds" >> (toLower worldName) >> "locations")) then {
    EGVAR(mission,town) = [];
    EGVAR(mission,industrie) = [];
    EGVAR(mission,military) = [];
    EGVAR(mission,water) = [];
    EGVAR(mission,other) = [];
    private _respawnPos = [GVARMAIN(playerside)] call EFUNC(common,getRespawnPos);
    TRACEV_2(_respawnPos,GVARMAIN(playerside));
    private _configs = configProperties [configfile >> "CfgKerberos" >> "worlds" >> (toLower worldName) >> "locations", "true",true];
    EGVAR(spawn,camouflage) = getNumber(configFile >> "CfgKerberos" >> "worlds" >> (toLower worldName) >> "camouflage");
    {
        private _missionCfg = _x;
        private _type = getText(_missionCfg >> "classification");
        private _configName = configName _missionCfg;
        private _cfg = configFile >> "CfgWorlds" >> worldName >> "Names" >> _configName;

        private _position = If (isArray(_missionCfg >> "position")) then {
            getArray(_cfg >> "position")
        } else {
            getArray(_cfg >> "position")
        };
        private _name = If (isText(_missionCfg >> "name")) then {
            getText(_missionCfg >> "name")
        } else {
            getText(_cfg >> "name")
        };
        If !(({(_position distance2D _x)<2000} count _respawnPos) > 0) then {
            switch (_type) do {
                case "city" : {
                    EGVAR(mission,town) pushBack [_name,_position];
                };
                case "water" : {
                    EGVAR(mission,water) pushBack [_name,_position];
                };
                case "military" : {
                    EGVAR(mission,military) pushBack [_name,_position];
                };
                case "industry" : {
                    EGVAR(mission,industrie) pushBack [_name,_position];
                };
                case "other" : {
                    EGVAR(mission,other) pushBack [_name,_position];
                };
            };
        };
    } forEach _configs;
    GVAR(isInitialized) = true;
}else{
    ERROR("Map not initialized, using fallback");
    [] call FUNC(setCfgLocations);
    EGVAR(spawn,camouflage) = 0;
    GVAR(isInitialized) = true;
};
