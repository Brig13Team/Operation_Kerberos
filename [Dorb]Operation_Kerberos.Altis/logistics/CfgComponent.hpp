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
    Events[] = {"clientpostinit","init","inventoryclosed","postinit","preinit"};
    class dependecies {
        CfgPatches = {};
        CfgComponent = {};
    };
    #include "config\logistics.hpp"
};
