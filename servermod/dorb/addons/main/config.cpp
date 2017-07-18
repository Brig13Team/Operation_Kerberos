#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "CBA_main",
            "CBA_common"
        };
        author = CSTRING(Author);
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"
