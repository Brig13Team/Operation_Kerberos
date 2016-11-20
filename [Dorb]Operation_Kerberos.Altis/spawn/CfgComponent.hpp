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
    class serverpostInit {client=0;};
    class hit {};
    class preinit {};
    class init {};
    class initTFAR {
        class dependencies {
            CfgPatches[] = {};
            CfgComponents[] = {"mod_tfar"};
        };
    };
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
#include "config\city_defence.hpp"
#include "config\unitlists.hpp"
#include "config\gear.hpp"
#include "config\defence_positions.hpp"

class CfgCompositions {
    class houses {
        #include "config\compositions_houses.hpp"
    };
    class positions {
        #include "config\compositions_positions.hpp"
    };
};
