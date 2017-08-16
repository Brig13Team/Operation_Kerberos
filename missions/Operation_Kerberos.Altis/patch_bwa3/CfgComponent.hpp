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
    class hitpart {};
    class dependencies {
        CfgPatches[] = {"BWA3_Tracked","rhs_main"};
        CfgComponents[] = {};
    };
};
