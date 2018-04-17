#include "script_component.hpp"

GVAR(compositions) = [] call FUNC(getPossibleCompositions);
GVAR(houses) = [] call FUNC(getPossibleHouseCompositions);

GVAR(mission) = [true] call FUNC(getPossibleCompositions);
GVAR(missionhouses) = [true] call FUNC(getPossibleHouseCompositions);

GVAR(housecache) = HASH_CREATE;

{
    private _curClass = configName _x;
    private _keyName = getText(_x >> "model");
    private _keyName = _keyName splitString "/";
    _keyName = (_keyName select [0, (count _keyName - 2)]) joinString "/";

    If (HASH_HASKEY(GVAR(housecache),_keyName)) then {
        HASH_GET(GVAR(housecache),_keyName) pushBack _curClass;
    } else {
        HASH_SET(GVAR(housecache),_keyName,[_curClass]);
    };
} forEach (configProperties[configFile >> "CfgVehicles", "(configName _x) isKindOf 'House'", true]);
