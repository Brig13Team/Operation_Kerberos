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
    class clientpostinit {server = 0;};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common","gui"};
    };
    class features {
        tablet = CSTRING(FEATURES_TABLET);
    };
};

#include "config\dialog.hpp"
