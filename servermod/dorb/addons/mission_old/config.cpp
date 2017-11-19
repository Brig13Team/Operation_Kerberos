#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dorb_worlds","dorb_spawn"};
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"

class CfgKerberos {
    #include "config\CfgDebriefing.hpp"
    #include "config\CfgTaskTypes.hpp"
    #include "config\CfgTaskEnhancements.hpp"
    #include "config\CfgTaskDescriptions.hpp"
    #include "config\missionconfig.hpp"
    #include "config\statemachine.hpp"
};
