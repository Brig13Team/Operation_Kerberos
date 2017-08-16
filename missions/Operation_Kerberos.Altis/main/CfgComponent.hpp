/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class DOUBLES(CfgComponent,ADDON) {
    class postinitServer { // Name can be anything -> include postinit or preinit or prestart into any of these to use a specific init-point
        server = 1; // always turned on, if not set
        client = 0; // to turn off, set the paramter to 0
        class dependencies {  // adds aditional restrictions if not set, no dependecies are checked
            CfgPatches[] = {};
            CfgComponents[] = {}; // missioncomponents -> the COMPONENT name - e.g. "main"
            Condition = "true"; // can be used to add some aditional conditions
        };
    };
    class postInit {};
    class dependencies {
        CfgPatches[] = {"CBA_main","CBA_XEH","CBA_Events","CBA_common"};
        CfgComponents[] = {};
    };
};

// COMPONENT specific configs can be added here -> they are directly integrated as a class into the missionConfigFile

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = "call compile preProcessFileLineNumbers 'main\XEH_preinit.sqf';";
    };
};
