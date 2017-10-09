/**
 * Author: Dorbedo
 * Component config
 *
 */
//#define DEBUG_MODE_FULL
#define CBA_OFF
#include "script_component.hpp"

class DOUBLES(CfgComponent,ADDON) {
    class clientpostinit {server = 0;};
    class ServerPostInit {client = 0;};
    class preinit {};
    class dependencies {
        CfgPatches[] = {};
        CfgComponents[] = {"common","main"};
    };
};

#include "script_gui.hpp"
#include "config\rsc_base.hpp"
#include "config\rsc_titles.hpp"
#include "config\dialog.hpp"
