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
    Events[] = {"clientpostinit","postinit","preinit","serverpostinit"};
    class dependecies {
        CfgPatches = {};
        CfgComponent = {};
    };
};
