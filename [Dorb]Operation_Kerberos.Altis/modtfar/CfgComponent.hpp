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
    class dependecies {
        CfgPatches = {"task_force_radio"};
        CfgComponent = {};
    };
};
