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
    class dependencies {
        CfgPatches[] = {'ace_main'};
        CfgComponents[] = {};
    };
};

#include "ace_settings.hpp"
