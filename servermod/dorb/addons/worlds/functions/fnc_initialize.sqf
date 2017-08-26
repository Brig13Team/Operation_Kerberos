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
    private _respawnPos = getMarkerPos GVARMAIN(respawnmarker);
    private _configs = configProperties [configfile >> "CfgKerberos" >> "worlds" >> (toLower worldName) >> "locations", "true",true];
    EGVAR(spawn,camouflage) = getNumber(configFile >> "CfgKerberos" >> "worlds" >> (toLower worldName) >> "camouflage");
    {
        private _type = getText(_x >> "classification");
        private _configName = configName _x;
        private _cfg = configFile >> "CfgWorlds" >> worldName >> "Names" >> _configName;

        private _position = If (isArray(_x >> "position")) then {
            getArray(_x >> "position")
        } else {
            getArray(_cfg >> "position")
        };
        private _name = If (isText(_x >> "name")) then {
            getText(_x >> "name")
        } else {
            getText(_cfg >> "name")
        };
        If ((_position distance2D _respawnPos)>2000) then {
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
}else{
    ERROR("Map not initialized, using fallback");
    [] call FUNC(setCfgLocations);
    EGVAR(spawn,camouflage) = 0;
};
