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
    class postInit {};
    class preInit {};
    class preInitServer {};

    class postInitClient_Antenna {server = 0;};

    class settings_postInit_Basic {};
    class settings_postInitServer {client = 0;};
    class settings_postInit_ChannelNames {};

    class settings_postInit_babel {};
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

#include "config\acre_antennaObjects.hpp"
