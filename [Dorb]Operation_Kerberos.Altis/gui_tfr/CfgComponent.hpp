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
        CfgPatches[] = {"task_force_radio"};
        CfgComponents[] = {"common","gui"};
    };
    class features {
        list = CSTRING(FEATURES_LIST);
    };
};

#include "config\dialog.hpp"
