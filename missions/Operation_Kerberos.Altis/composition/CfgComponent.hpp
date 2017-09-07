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
    class postinitServer {client = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common"};
    };
};

class CfgKerberos {
    class CfgComposition {
        class compositions {
            #include "config\compositions.hpp"
        };
        class houses {
            #include "config\houses.hpp"
        };
    };
};
