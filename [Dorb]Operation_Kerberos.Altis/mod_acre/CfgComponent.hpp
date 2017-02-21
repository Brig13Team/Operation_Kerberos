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
    class postInit_babel {};
    class postInit_Basic {};
    class postInitServer_settings {client = 0;};
    class postInitClient_babbel_achilles {
        server = 0;
        class dependencies {
            CfgPatches[] = {"acre_main","achilles_functions_f_ares"};
            CfgComponents[] = {};
        };
    };
    class dependencies {
        CfgPatches[] = {"acre_main"};
        CfgComponents[] = {};
    };
};
