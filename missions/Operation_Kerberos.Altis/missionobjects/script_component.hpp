#define COMPONENT missionobjects
#define COMPONENT_BEAUTIFIED Mission_Objects
#include "..\main\script_mission.hpp"

#define DEBUG_MODE_MINIMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_missionobjects
    #define DEBUG_MODE_FULL
#endif

#include "..\main\script_macros.hpp"


// Carry-Action
#define ANIM_TIME 1.1
#define ATTACH_POINT [0,0,-0.1]

// download distance
#define DOWNLOAD_MAX_DISTANCE 12
