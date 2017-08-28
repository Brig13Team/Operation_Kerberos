#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

if (isServer) then {
    ["AllVehicles", "init", {
        _this spawn FUNC(onInit);
    },true,[],true] call CBA_fnc_addClassEventHandler;
};
