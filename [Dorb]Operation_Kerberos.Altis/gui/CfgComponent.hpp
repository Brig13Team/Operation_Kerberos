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
    class clientpostinit {server = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common","main"};
    };
    class features {
        messages = CSTRING(FEATURES_MESSAGES);
        loadingscreen = CSTRING(FEATURES_LOADING);
        timer = CSTRING(FEATURES_TIMER);
    };
};

#include "rsc_base.hpp"
#include "config\RscSpecific.hpp"
