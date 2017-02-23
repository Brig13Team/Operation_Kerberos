/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// setting up the jammer
[LINKFUNC(getSignal)] call acre_api_fnc_setCustomSignalFunc;

// adding the possibility to stop the
["remoteStopSpeaking", {
    _this call FUNC(remoteStopSpeaking);
    _this call acre_sys_core_fnc_remoteStopSpeaking;
}] call acre_sys_rpc_fnc_addProcedure;
