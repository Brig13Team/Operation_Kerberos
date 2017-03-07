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
    class clientpostinit {server=0;};
    class init {};
    class inventoryclosed {};
    class postinit {};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common"};
    };
    class features {
        loading = CSTRING(FEATURES_LOADING);
        stacks = CSTRING(FEATURES_STACKS);
        drop = CSTRING(FEATURES_DROP);
        weight = CSTRING(FEATURES_WEIGHT);
    };
};
#include "config\logistics.hpp"
