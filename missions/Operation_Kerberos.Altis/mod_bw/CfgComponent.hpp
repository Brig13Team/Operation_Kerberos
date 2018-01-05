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
    class Preinit {};
    class dependencies {
        CfgPatches[] = {"BWA3_Comp_ACE"};
        CfgComponents[] = {};
    };
};

#include "dialog.hpp"
