#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "CBA_main",
            "CBA_common",
            "dorb_mission",
            "dorb_spawn",
            "ace_rearm"
        };
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};


class Intercept {
    class Operation_Kerberos {
        class headquarter {
            pluginName = "headquarter";
        };
    };
};
