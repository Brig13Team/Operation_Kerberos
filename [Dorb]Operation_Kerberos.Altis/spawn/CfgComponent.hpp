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
    class hit {};
    class preinit {};
    class init {};
    class dependencies {
        CfgPatches[] = {"rhs_main","rhsusf_main"};
        CfgComponents[] = {"common","mission","interface"};
    };
};
#include "config\city_defence.hpp"
#include "config\unitlists.hpp"
#include "config\gear.hpp"
#include "config\defence_positions.hpp"
