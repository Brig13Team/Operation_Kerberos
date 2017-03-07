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
    class ClientPostInit {server=0;};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common","gui","gui_echidna"};
    };
    /*
    class features {
        save = CSTRING(FEATURES_SAVE);
    };
    */
};

#include "config\dialog.hpp"
