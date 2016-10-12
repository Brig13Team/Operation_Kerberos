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
    Events[] = {"clientpostinit","fired","getIn","hit","killed","postinit","preinit","seatSwitched","serverpostinit"};
    class dependecies {
        CfgPatches = {};
        CfgComponent = {"common"};
    };
};
