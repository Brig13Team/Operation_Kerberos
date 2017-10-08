#define COMPONENT logistics
#define COMPONENT_BEAUTIFIED Logistics
#include "..\script_mission.hpp"

#define DEBUG_MODE_MINIMAL
#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_gui_logistics
    #define DEBUG_MODE_FULL
#endif

#include "..\main\script_macros.hpp"
#include "..\gui\script_gui.hpp"
