/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#include "script_component.hpp"

class DOUBLES(CfgComponent,ADDON) {
    class PostInit {};
    class Preinit {};
    class dependencies {
        CfgPatches[] = {"CBA_common"};
        CfgComponents[] = {"common","gui"};
    };
};

#include "config\dialog.hpp"
