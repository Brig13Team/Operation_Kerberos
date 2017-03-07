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
    class preinit {};
    class postInitServer {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"main"};
        Condition = "false"; /// deaktivated for now
    };
    class features {
        caching = CSTRING(FEATURES_CACHING);
    };
};
