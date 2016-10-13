/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class ADDON {
    Events[] = {"postinit"};
    class dependecies {
        CfgPatches = {"rhsafrf","CBA_main"};
        CfgComponent = {"common","mission","interface"};
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = "call compile preProcessFileLineNumbers 'main\EH_postinit.sqf';";
    };
};
