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
    class seatSwitched {};
    class getIn {};
    class serverpostInit_whitelist {
        client = 0;
    };
    class dependencies {
        CfgPatches[] = {"cba_events"};
        CfgComponents[] = {"main"};
    };
};
