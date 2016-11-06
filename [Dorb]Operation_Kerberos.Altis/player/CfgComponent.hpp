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
    class clientpostinit {
        server = 0;
    };
    class fired {server = 0;};
    class getIn {server = 0;};
    class killed {server = 0;};
    class seatSwitched {server = 0;};
    class postinit {};
    class preinit {};
    class serverpostinit {client = 0;};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common"};
    };
};
#include "config\arsenal.hpp"