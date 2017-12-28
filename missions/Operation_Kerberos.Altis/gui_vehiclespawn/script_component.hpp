#define COMPONENT gui_vehiclespawn
#define COMPONENT_BEAUTIFIED GUI_Vehicle_Spawn
#include "..\main\script_mission.hpp"

#define DEBUG_MODE_MINIMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_gui_vehiclespawn
    #define DEBUG_MODE_FULL
#endif

#include "..\main\script_macros.hpp"
#include "..\gui\script_gui.hpp"

#define CHECK_RADIUS_MIN 5
#define CHECK_RADIUS_MAX 15
#define CLEAR_RADIUS ((CHECK_RADIUS_MAX + CHECK_RADIUS_MIN)/2)
