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
    Events[] = {"hit","init","preinit"};
    class dependecies {
        CfgPatches = {"rhsafrf","rhsusaf"};
        CfgComponent = {"common","mission","interface"};
    };
};
