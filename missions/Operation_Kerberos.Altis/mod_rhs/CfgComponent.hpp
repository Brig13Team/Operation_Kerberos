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
    class PostInit {};
    class dependencies {
        CfgPatches[] = {"rhs_main"};
        CfgComponents[] = {};
    };
};
