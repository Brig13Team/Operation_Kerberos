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
    class preinit {};
    class dependencies {
        CfgPatches[] = {"ace_common","cba_events"};
        CfgComponents[] = {"main"};
    };
};
