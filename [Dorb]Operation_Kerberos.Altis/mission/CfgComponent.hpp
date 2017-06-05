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
    class clientinitpost {server = 0;};
    class serverpostinit {client = 0;};
    class postInit {};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"spawn","worlds"};
    };
    class config {
        #include "config\CfgComponent.hpp"
    };
};

#include "config\CfgDebriefing.hpp"
#include "config\CfgTaskTypes.hpp"
#include "config\CfgTaskEnhancements.hpp"
#include "config\CfgTaskDescriptions.hpp"
#include "config\mission.hpp"
#include "config\statemachine.hpp"
