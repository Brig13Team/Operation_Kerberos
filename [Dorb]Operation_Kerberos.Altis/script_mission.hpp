#define PREFIX dorb

#define DORB_PILOT_WHITELIST_ENABLED

#ifdef DEBUGMODUS_FULL
    #define DEBUG_MODE_FULL
	#define DEBUGMODUS
#endif

#ifdef DEBUGMODUS
	#define DORB_ERROR
	#define DORB_LOG
	#define DEBUG_MODE_NORMAL
#endif

#include "main\script_macros.hpp"
#include "main\script_debug.hpp"
