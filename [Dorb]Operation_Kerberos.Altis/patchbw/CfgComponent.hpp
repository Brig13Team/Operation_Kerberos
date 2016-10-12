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
    Events[] = {"hitpart"};
    class dependecies {
        CfgPatches = {"BWA3_Tracked"};
        CfgComponent = {};
    };
};
