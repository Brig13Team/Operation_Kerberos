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
        CfgPatches = {'asr_ai3_main','asr_ai3_cfgammo','asr_ai3_cfgvehicles','asr_ai3_cfgweapons'};
        CfgComponent = {};
    };
};
