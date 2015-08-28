#define PREFIX dorb

#define DORB_PILOT_WHITELIST_ENABLED
#define DORB_ERROR
#define DORB_LOG
#define DEBUGMODUS

#define DEBUG_MODE_NORMAL
#ifdef DEBUG_ENABLED_TEST
    #define DEBUG_MODE_FULL
#endif

#include "main\script_macros.hpp"
#include "main\script_debug.hpp"
