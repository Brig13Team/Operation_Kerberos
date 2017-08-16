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
    class killedClient {server = 0;};
    class HitClient {server = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {"ace_common"};
        CfgComponents[] = {"main"};
    };
};
