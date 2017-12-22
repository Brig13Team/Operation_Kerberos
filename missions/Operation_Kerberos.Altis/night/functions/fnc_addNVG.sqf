/**
 *  Author: Dorbedo
 *
 *  Description:
 *      adds NVG
 *
 *  Parameter(s):
 *      0 : OBJECT - unit
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_unit"];
CHECK(isPlayer _unit)
switch (side _unit) do {
    case east : {
        CHECK("NVGoggles_OPFOR" in (items _unit))
        _unit additem "NVGoggles_OPFOR";
        CHECK(!("NVGoggles_OPFOR" in (items _unit)))
        _unit assignItem "NVGoggles_OPFOR";
    };
    case resistance : {
        CHECK("NVGoggles_INDEP" in (items _unit))
        _unit additem "NVGoggles_INDEP";
        CHECK(!("NVGoggles_INDEP" in (items _unit)))
        _unit assignItem "NVGoggles_INDEP";
    };
    case west : {
        CHECK("NVGoggles" in (items _unit))
        _unit additem "NVGoggles";
        CHECK(!("NVGoggles" in (items _unit)))
        _unit assignItem "NVGoggles";
    };
};
