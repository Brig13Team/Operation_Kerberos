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
    class postinit {
        server = 1; // always turned on, if not set
        client = 1; // to turn off, set the paramter to 0
        class dependencies {  // adds aditional restrictions if not set, no dependecies are checked
            CfgPatches[] = {};
            CfgComponents[] = {};
            Condition = "true"; // can be used to add some aditional conditions
        };
    };
    class dependencies {
        CfgPatches[] = {"CBA_main","CBA_XEH","CBA_Events","CBA_common"};
        CfgComponents[] = {};
    };
};

#include "system.hpp"
#include "missionsettings.hpp"

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = "call compile preProcessFileLineNumbers 'main\EH_preinit.sqf';";
    };
};
