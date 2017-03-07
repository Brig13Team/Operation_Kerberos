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
    class initpost {client = 0;};
    class serverpostinit {client = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {"CBA_xeh","CBA_Events"};
        CfgComponents[] = {"common"};
    };
    class features {
        HEADLESSCLIENTS = CSTRING(FEATURES_HEADLESSCLIENTS);
    };
};
