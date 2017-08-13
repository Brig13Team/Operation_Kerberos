/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

If (isNil QGVAR(jammer)) then {
    GVAR(jammer) = [];
};
GVAR(advancedjammer) = true;
GVAR(jammer_lastCheck) = HASH_CREATE;
