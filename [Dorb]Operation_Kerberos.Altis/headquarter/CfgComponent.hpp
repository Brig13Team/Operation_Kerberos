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
    class clientpostinit {server = 0;};
    class initpostServer {client = 0;};
    class killed {};
    class preinit {};
    class serverpostinit {client = 0;};
    class dependencies {
        CfgPatches[] = {"ace_rearm"};
        CfgComponents[] = {"mission","spawn"};
    };
};
#include "config\drones.hpp"
#include "config\strategy.hpp"
#include "config\costs.hpp"
#include "config\statemachines.hpp"
