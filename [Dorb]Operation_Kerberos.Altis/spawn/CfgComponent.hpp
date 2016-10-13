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
    class dependencies {
        CfgPatches = {"rhsafrf","rhsusaf"};
        CfgComponent = {"common","mission","interface"};
    };
    #include "config\city_defence.hpp"
    #include "config\unitlists.hpp"
    #include "config\gear.hpp"
    #include "config\defence_positions.hpp"
};
