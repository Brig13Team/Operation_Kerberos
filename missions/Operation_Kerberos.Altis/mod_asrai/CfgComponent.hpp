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
    class preInit {};
    class dependencies {
        CfgPatches[] = {"asr_ai3_main"};
        CfgComponents[] = {};
    };
};
