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
    interface = 1;
    logistics = 1;
    player = 1;
    /// mission specific components
    spawn = 1;
    headquarter = 1;
    mission = 1;
    /// mod specific components
    modace = 1;
    modacre = 1;
    modasrai = 1;
    modtfar = 0;
    patchacre = 1;
    patchbw = 1;
    /// gui
    gui = 1;
    gui_spawn = 1;
    gui_teleport = 1;
};

#include "main\CfgComponent.hpp"
#include "common\CfgComponent.hpp"
#include "headless\CfgComponent.hpp"
#include "headquarter\CfgComponent.hpp"
#include "interface\CfgComponent.hpp"
#include "logistics\CfgComponent.hpp"
#include "mission\CfgComponent.hpp"
#include "modace\CfgComponent.hpp"
#include "modacre\CfgComponent.hpp"
#include "modasrai\CfgComponent.hpp"
#include "modtfar\CfgComponent.hpp"
#include "patchacre\CfgComponent.hpp"
#include "patchbw\CfgComponent.hpp"
#include "player\CfgComponent.hpp"
#include "spawn\CfgComponent.hpp"

#include "gui\CfgComponent.hpp"
#include "gui_spawn\CfgComponent.hpp"
#include "gui_teleport\CfgComponent.hpp"
