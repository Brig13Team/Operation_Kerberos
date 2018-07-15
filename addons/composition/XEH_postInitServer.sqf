#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(compositions) = [] call FUNC(getPossibleCompositions);
GVAR(houses) = [] call FUNC(getPossibleHouseCompositions);

GVAR(missioncompositions) = [true] call FUNC(getPossibleCompositions);
GVAR(missionhouses) = [true] call FUNC(getPossibleHouseCompositions);

GVAR(housecache) = HASH_CREATE;

{
    private _curClass = configName _x;
    If ((!(_curClass isEqualTo "")) && {_curClass isKindOf "House"}) then {
        private _keyName = getText(_x >> "model");
        _keyName = _keyName splitString "/\";
        _keyName = (_keyName select [0, (count _keyName - 1)]) joinString "/";
        //TRACEV_3(_x,_curClass,_keyName);
        If !(_keyName isEqualTo "") then {
            If (HASH_HASKEY(GVAR(housecache),_keyName)) then {
                HASH_GET(GVAR(housecache),_keyName) pushBack _curClass;
            } else {
                HASH_SET(GVAR(housecache),_keyName,[_curClass]);
            };
        };
    };
} forEach (configProperties[configFile >> "CfgVehicles", "(isClass _x)", true]);
