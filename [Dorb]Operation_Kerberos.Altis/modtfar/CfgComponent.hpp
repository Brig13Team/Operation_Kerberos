/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class ADDON {
    Events[] = {"preinit","postinit"};
    class dependencies {
        CfgPatches = {"task_force_radio"};
        CfgComponent = {};
    };
};
