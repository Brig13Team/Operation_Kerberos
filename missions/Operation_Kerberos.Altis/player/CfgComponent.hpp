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
    class clientpostinit {server = 0;};
    class killed {};
    class postinit {};
    class preinit {};
    class respawn {};
    class serverpostinit {client = 0;};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common"};
    };
};
