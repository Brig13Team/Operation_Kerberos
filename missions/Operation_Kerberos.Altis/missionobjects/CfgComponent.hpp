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
    class clientpostinit {server = 0;};
    class clientinitpost {server = 0;};
    class serverPostInit {
        client = 0;
        CfgPatches[] = {"dorb_mission"};
        CfgComponents[] = {};
    };
    class postInit {};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {};
    };
};
