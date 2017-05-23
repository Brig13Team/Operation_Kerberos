/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a hash with all locations
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      LOCATION - the locationhash with classification
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _exportHash = HASH_CREATE;
private _configs = configProperties [configFile >> "CfgWorlds" >> worldName >> "Names", "true", true];

private _blacklist = switch (toLower worldName) do {
    case "altis" : {
        [
            "sagonisi","edessa","fournos","monisi","pyrgi","atsalis","bomos","savri","makrynisi","cap drakontas"
        ]
    };
    default {[]};
};


{
    private _cur = _x;
    private _key = configName _x;
    private _name = toLower (getText(_cur >> "name"));
    private _position = getArray(_cur >> "position");
    private _type = toLower (getText(_cur >> "type"));
    switch (true) do {
    case (_name in _blacklist) : {/*nothing*/};
        case (_type in [LOCATIONS_CITY]) : {
            private _temp = HASH_CREATE;
            HASH_SET(_temp,"classification","city");
            HASH_SET(_exportHash,_key,_temp);
        };
        case (surfaceIsWater _position) : {
            private _temp = HASH_CREATE;
            HASH_SET(_temp,"classification","water");
            HASH_SET(_exportHash,_key,_temp);
        };
        case (_name in [LOCATIONS_MILITARY]) : {
            private _temp = HASH_CREATE;
            HASH_SET(_temp,"classification","military");
            HASH_SET(_exportHash,_key,_temp);
        };
        case (_name in [LOCATIONS_FACTORY]);
        case (_name in [LOCATIONS_QUARRY]);
        case (_name in [LOCATIONS_POWERPLANT]) : {
            private _temp = HASH_CREATE;
            HASH_SET(_temp,"classification","industry");
            HASH_SET(_exportHash,_key,_temp);
        };
        default {
            private _temp = HASH_CREATE;
            HASH_SET(_temp,"classification","other");
            HASH_SET(_exportHash,_key,_temp);
        };
    };
} forEach _configs;
_exportHash;
