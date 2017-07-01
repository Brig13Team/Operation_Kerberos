/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

If (!isServer) exitWith {};

GVAR(initialized) = false;

call FUNC(connectToDB);
["constructTablePlayers"] call FUNC(sendNoReturn);
