#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dorb_common", "dorb_spawn", "dorb_composition"};
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

class CfgKerberos;
class CfgKerberos : CfgKerberos {
    class CfgComposition : CfgComposition {
        class compositions : compositions {
            #include "config\compositions_missions.hpp"
        };
    };
};
