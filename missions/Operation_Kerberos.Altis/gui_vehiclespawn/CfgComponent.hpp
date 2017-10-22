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
    class PostInitClient {server = 0;};
    class Preinit {};
    class dependencies {
        CfgPatches[] = {"CBA_common"};
        CfgComponents[] = {"common","gui","gui_main"};
    };
};

#include "config\dialog.hpp"
