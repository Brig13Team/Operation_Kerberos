#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dorb_common"};
        author = ECSTRING(main,BrigTeam);
        authors[] = {"Dorbedo"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

class CfgKerberos {
    #include "config\unitlists.hpp"
    #include "config\gear.hpp"
};
