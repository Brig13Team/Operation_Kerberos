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
    /// main components
    common = 1;
    headless = 1;
    logistics = 1;
    grouptracker = 1;
    player = 1;
    spawn = 1;
    teamkilling = 1;
    viewrestriction = 1;
    database = 1;
    doorbreach = 1;
    /// mission specific components
    headquarter = 1;
    mission = 1;
    advertisements = 1;
    /// mod specific components
    mod_ace = 1;
    mod_acre = 1;
    mod_acre_jammer = 1;
    mod_asrai = 1;
    mod_tfar = 0;
    patch_acre = 1;
    patch_bw = 1;
    /// gui
    gui = 1;
    gui_spawn = 1;
    gui_teleport = 1;
    gui_crate = 1;
    gui_save = 1;
    gui_tfr = 0;
    gui_tablet = 1;
    gui_arsenal = 1;
};

#include "main\CfgComponent.hpp"
#include "common\CfgComponent.hpp"
#include "advertisements\CfgComponent.hpp"
#include "grouptracker\CfgComponent.hpp"
#include "headless\CfgComponent.hpp"
#include "headquarter\CfgComponent.hpp"
#include "logistics\CfgComponent.hpp"
#include "mission\CfgComponent.hpp"
#include "mod_ace\CfgComponent.hpp"
#include "mod_acre\CfgComponent.hpp"
#include "mod_acre_jammer\CfgComponent.hpp"
#include "mod_asrai\CfgComponent.hpp"
#include "mod_tfar\CfgComponent.hpp"
#include "patch_acre\CfgComponent.hpp"
#include "patch_bw\CfgComponent.hpp"
#include "player\CfgComponent.hpp"
#include "spawn\CfgComponent.hpp"
#include "teamkilling\CfgComponent.hpp"
#include "viewrestriction\CfgComponent.hpp"
#include "database\CfgComponent.hpp"
#include "doorbreach\CfgComponent.hpp"

#include "gui\CfgComponent.hpp"
#include "gui_tablet\CfgComponent.hpp"
#include "gui_spawn\CfgComponent.hpp"
#include "gui_teleport\CfgComponent.hpp"
#include "gui_crate\CfgComponent.hpp"
#include "gui_save\CfgComponent.hpp"
#include "gui_tfr\CfgComponent.hpp"
#include "gui_arsenal\CfgComponent.hpp"
