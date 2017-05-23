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

If (isClass(missionConfigFile >> DOUBLES(CfgComponent,ADDON) >> "config" >> worldName)) then {
    EGVAR(mission,town) = [];
    EGVAR(mission,industrie) = [];
    EGVAR(mission,military) = [];
    EGVAR(mission,water) = [];
    EGVAR(mission,other) = [];
    private _configs = configProperties [missionConfigFile >> TRIPLES(CfgComponent,PREFIX,worlds) >> "config" >> worldName, "true",true];
    {
        private _type = getText(_x >> "classification");
        private _configName = configName _x;
        private _cfg = configFile >> "CfgWorlds" >> worldName >> "Names" >> _configName;
        private _temp = [getText(_cfg >> "text"),getArray(_cfg >> "position")];
        switch (_type) do {
            case "city" : {
                EGVAR(mission,town) pushBack _temp;
            };
            case "water" : {
                EGVAR(mission,water) pushBack _temp;
            };
            case "military" : {
                EGVAR(mission,military) pushBack _temp;
            };
            case "industry" : {
                EGVAR(mission,industrie) pushBack _temp;
            };
            case "other" : {
                EGVAR(mission,other) pushBack _temp;
            };
        };
    } forEach _configs;
}else{
    [] call FUNC(setCfgLocations);
};
