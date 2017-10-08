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
