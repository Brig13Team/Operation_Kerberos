#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dorb_common","dorb_mission","dorb_spawn","ace_rearm"};
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"

class CfgKerberos {
    class headquarter {
        #include "config\drones.hpp"
        #include "config\strategy.hpp"
        #include "config\costs.hpp"
        #include "config\statemachines.hpp"
    };
};
