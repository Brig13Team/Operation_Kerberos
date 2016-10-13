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
    class serverpostinit {client = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {};
    };
};

#include "config\define.hpp"
#include "config\menu.hpp"
#include "config\definitions_new.hpp"
#include "config\rscTitles_new.hpp"
