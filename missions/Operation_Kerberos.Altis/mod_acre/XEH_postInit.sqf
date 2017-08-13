/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Postinit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"



// setting up the jammer
[LINKFUNC(getSignal)] call acre_api_fnc_setCustomSignalFunc;

// adding the possibility to stop the
["remoteStopSpeaking", {
    _this call FUNC(jammer_remoteStopSpeaking);
    _this call acre_sys_core_fnc_remoteStopSpeaking;
}] call acre_sys_rpc_fnc_addProcedure;
