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
    class clientpostinit {server=0;};
    class init {};
    class inventoryclosed {};
    class postinit {};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common"};
    };
};
#include "config\logistics.hpp"
#include "config\dialog.hpp"
