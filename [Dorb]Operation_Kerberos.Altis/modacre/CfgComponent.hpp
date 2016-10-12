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
    Events[] = {"postinit"};
    class dependecies {
        CfgPatches = {'acre_main'};
        CfgComponent = {};
    };
};
