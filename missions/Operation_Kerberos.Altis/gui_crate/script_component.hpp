#define COMPONENT gui_crate
#define COMPONENT_BEAUTIFIED GUI_Crate
#include "..\script_mission.hpp"

#define DEBUG_MODE_MINIMAL
#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_gui_crate
    #define DEBUG_MODE_FULL
#endif

#include "..\main\script_macros.hpp"
#include "..\gui\script_gui.hpp"


#define CHECK_RADIUS 8

#define ID_RIFLE 0
#define ID_AUTOMATIC 1
#define ID_SNIPER 2
#define ID_LAUNCHER 3
#define ID_HANDGUN 4
#define ID_OPTICS 5
#define ID_GRANADES 6
#define ID_MINES 7
#define ID_UNIFORM 8
#define ID_VEST 9
#define ID_HEADGEAR 10
#define ID_BACKPACK 11
#define ID_RADIO 12
#define ID_NAVIGATION 13
#define ID_MEDIC 14
#define ID_OTHER 15
