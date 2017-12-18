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
    class preInit {};
    class clientPostInit {
        server=0;
    };
    class dependencies {
        CfgPatches[] = {"ace_main","ace_medical"};
        CfgComponents[] = {};
    };
};
