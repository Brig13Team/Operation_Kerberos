/*
 *  Author: Dorbedo
 *
 *  Description:
 *      configures the active components, to set a component active: set it to 1
 *      the evaluation starts at the beginning of the the preInit
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class CfgComponents {
    common = 1;
    headless = 1;
    headquarter = 1;
    interface = 1;
    logistics = 1;
    mission = 1;
    modace = 1;
    modacre = 1;
    modasrai = 1;
    modtfar = 0;
    patchacre = 1;
    patchbw = 1;
    player = 1;
    spawn = 1;
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
