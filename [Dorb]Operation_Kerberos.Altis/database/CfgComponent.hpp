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
    class dependencies {
        CfgPatches[] = {"extDB3"};
        CfgComponents[] = {"main"};
    };
};
