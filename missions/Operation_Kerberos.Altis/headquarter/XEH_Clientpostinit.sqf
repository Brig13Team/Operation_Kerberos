/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!((getMissionConfigValue ["isKerberos", 0]) > 0))

// DEBUG
GVAR(debugMarkerActive) = false;
#ifdef DEBUG_MODE_FULL
    GVAR(debugMarkerActive) = true;
    [LINKFUNC(handleDebugMarker),60,[]] call CBA_fnc_addPerFrameHandler;
#endif
