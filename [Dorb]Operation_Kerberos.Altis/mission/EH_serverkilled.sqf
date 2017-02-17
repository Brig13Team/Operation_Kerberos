/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the killed Eventhandler
 *
 */
#include "script_component.hpp"

CHECK(!isServer)

["CAManBase", "killed", LINKFUNC(onKilled),true,[],true] call CBA_fnc_addClassEventHandler;
