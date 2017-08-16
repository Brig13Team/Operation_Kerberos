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
    class preinit {};
    class clientpostinit {server = 0;};
    class postinit {
        class dependencies {
            CfgPatches[] = {};
            CfgComponents[] = {};
            Condition = "false";
            // diable the Loadout-Cleaning
        };
    };
    class dependencies {
        CfgPatches[] = {"acre_main"};
        CfgComponents[] = {};
    };
};
