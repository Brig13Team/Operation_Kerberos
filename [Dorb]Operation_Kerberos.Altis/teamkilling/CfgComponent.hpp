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
    class postinit {};
    class dependencies {
        CfgPatches[] = {"ace_common"};
        CfgComponents[] = {"main"};
    };
    class features {
        logging = CSTRING(FEATURES_LOGGING);
    };
};
