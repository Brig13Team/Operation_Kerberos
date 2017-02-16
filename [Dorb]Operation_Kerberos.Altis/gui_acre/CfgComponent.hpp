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
        CfgPatches[] = {};
        CfgComponents[] = {"common","gui","gui_echidna"};
    };
    /*
    class features {
        tablet = CSTRING(FEATURES_TABLET);
    };
    */
};

#include "config\dialog.hpp"
