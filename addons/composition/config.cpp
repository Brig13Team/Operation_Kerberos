#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dorb_common","dorb_spawn"};
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"

class CfgKerberos {
    class CfgComposition {
        class compositions {
            #include "config\compositions_missions1.hpp"
            #include "config\compositions1.hpp"
            #include "config\compositions2.hpp"
        };
        class houses {
            #include "config\houses_missions1.hpp"
            #include "config\houses_missions2.hpp"
            #include "config\houses1.hpp"
            #include "config\houses2.hpp"
            #include "config\houses3.hpp"
            #include "config\houses4.hpp"
        };
    };
};
