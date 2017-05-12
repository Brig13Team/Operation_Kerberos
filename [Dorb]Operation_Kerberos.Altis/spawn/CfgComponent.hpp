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
    class serverpostInit {
        client=0;
        class dependencies {
            CfgPatches[] = {};
            CfgComponents[] = {"mission"};
        };
    };
    class hit {};
    class preinit {};
    class init {};
    class initPostServer {client = 0;};
    class initACE {
        class dependencies {
            CfgPatches[] = {};
            CfgComponents[] = {"mod_ace"};
        };
    };
    class dependencies {
        CfgPatches[] = {"rhs_main","rhsusf_main","CBA_ai"};
        CfgComponents[] = {"common"};
    };
};
#include "config\unitlists.hpp"
#include "config\gear.hpp"

class CfgCompositions {
    class houses {
        #include "config\compositions_houses.hpp"
    };
    #include "config\positions.hpp"
    #include "config\compositions_housepositions.hpp"
};
