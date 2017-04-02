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
    version = "2017.03.30"; // used for the lib of vehicles should only be touched if the gui has changed
    class clientpostinit {server = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {"CBA_common"};
        CfgComponents[] = {"common","gui"};
    };
    class features {
        vehicles = CSTRING(FEATURES_VEHICLESPAWN);
        side = CSTRING(FEATURES_SIDE);
    };
};

#include "config\dialog.hpp"
