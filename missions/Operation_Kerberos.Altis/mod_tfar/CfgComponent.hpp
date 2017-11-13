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
    class PreInit {};
    class dependencies {
        CfgPatches[] = {"task_force_radio"};
        CfgComponents[] = {};
    };
};
