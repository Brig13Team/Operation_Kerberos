#define COMPONENT mission
#define COMPONENT_BEAUTIFIED Mission
#include "\x\dorb\addons\main\script_mod.hpp"

#define DEBUG_MODE_MINIMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_Mission
    #define DEBUG_MODE_FULL
#endif

// Carry-Action
#define ANIM_TIME 1.1
#define ATTACH_POINT [0,0,-0.1]

// download distance
#define DOWNLOAD_MAX_DISTANCE 12


#include "\x\dorb\addons\main\script_macros.hpp"
