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
        CfgComponents[] = {"mission","spawn"};
    };
};
#include "config\drones.hpp"
#include "config\maps.hpp"
#include "config\strategy.hpp"
