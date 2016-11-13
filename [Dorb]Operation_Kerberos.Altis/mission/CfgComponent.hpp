/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class DOUBLES(CfgComponent,ADDON) {
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"spawn"};
    };
};
#include "config\CfgTaskTypes.hpp"
#include "config\CfgTaskEnhancements.hpp"
#include "config\missions_config.hpp"
#include "config\sideby_config.hpp"
#include "CfgDebriefing.hpp"
