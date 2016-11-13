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
    class postinit {};
    class dependencies {
        CfgPatches[] = {"task_force_radio","CBA_xeh"};
        CfgComponents[] = {};
    };
};
