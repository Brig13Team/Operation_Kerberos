/*
 *  Author: Dorbedo
 *
 *  Description:
 *      configures the active components, to set a component active: set it to 1
 *      the evaluation starts at the beginning of the the preInit
 *      some components can have additional parameters, which are evaluated in addition.
 *          e.g. if a component requires a mod, the component won't be compiled even if the parameter is set to 1
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class CfgComponents {
    #include "main\system.hpp"
    /// main components
    common = 1;
    logistics = 1;
    grouptracker = 1;
    player = 1;
    teamkilling = 1;
    viewrestriction = 1;
    doorbreach = 1;
    whitelist = 1;
    ai_skill = 1;
    night = 1;
    groundactions = 1;
    // kerberos specific
    missionobjects = 1;
    headquarter = 1;
    /// mod specific components
    mod_ace = 1;
    mod_acre = 1;
    mod_asrai = 1;
    mod_rhs = 1;
    mod_tfar = 1;
    patch_acre = 1;
    patch_bwa3 = 1;
    mod_bw = 1;

    gui = 1;
    gui_main = 1;
    gui_vehiclespawn = 1;
    gui_arsenal = 1;
    gui_teleport = 1;
    gui_crate = 1;
    gui_save = 1;
    gui_acre = 1;
    gui_tfar = 1;
};

#include "main\CfgComponent.hpp"
#include "gui\CfgComponent.hpp"

#include "common\CfgComponent.hpp"
#include "grouptracker\CfgComponent.hpp"
#include "logistics\CfgComponent.hpp"
#include "mod_ace\CfgComponent.hpp"
#include "mod_acre\CfgComponent.hpp"
#include "mod_asrai\CfgComponent.hpp"
#include "mod_rhs\CfgComponent.hpp"
#include "mod_tfar\CfgComponent.hpp"
#include "patch_acre\CfgComponent.hpp"
#include "patch_bwa3\CfgComponent.hpp"
#include "player\CfgComponent.hpp"
#include "teamkilling\CfgComponent.hpp"
#include "viewrestriction\CfgComponent.hpp"
#include "whitelist\CfgComponent.hpp"
#include "doorbreach\CfgComponent.hpp"
#include "ai_skill\CfgComponent.hpp"
#include "night\CfgComponent.hpp"
#include "groundactions\CfgComponent.hpp"

#include "missionobjects\CfgComponent.hpp"
#include "headquarter\CfgComponent.hpp"

#include "gui_main\CfgComponent.hpp"
#include "gui_vehiclespawn\CfgComponent.hpp"
#include "gui_teleport\CfgComponent.hpp"
#include "gui_arsenal\CfgComponent.hpp"
#include "gui_crate\CfgComponent.hpp"
#include "gui_save\CfgComponent.hpp"
#include "gui_acre\CfgComponent.hpp"
#include "gui_tfar\CfgComponent.hpp"

#include "mod_bw\CfgComponent.hpp"
