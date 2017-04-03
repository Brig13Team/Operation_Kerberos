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
    class clientpostinit {
        server = 0;
    };
    class preinit {};
    class serverpostinit {
        client = 0;
    };
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"main"};
    };
};
