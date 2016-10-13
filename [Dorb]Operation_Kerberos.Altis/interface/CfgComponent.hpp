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
    Events[] = {"clientpostinit","serverpostinit","preinit"};
    class dependencies {
        CfgPatches = {};
        CfgComponent = {};
    };
    #include "config\define.hpp"
    #include "config\menu.hpp"
    #include "config\definitions_new.hpp"
    #include "config\rscTitles_new.hpp"
};
