/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

If (!isServer) exitWith {};

GVAR(initialized) = false;

if !(isClass (configFile >> "CfgPatches" >> "extDB3")) exitWith {
    ERROR("ExtDB3 Mod is not loaded");
};

call FUNC(connectToDB);
["constructTablePlayers"] call FUNC(sendNoReturn);
