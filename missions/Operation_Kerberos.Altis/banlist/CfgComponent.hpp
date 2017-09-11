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
    class Clientpostinit {server = 0;};
    class serverpostInit {client = 0;};
    class dependencies {
        CfgPatches[] = {"cba_events"};
        CfgComponents[] = {"main"};
    };
};
