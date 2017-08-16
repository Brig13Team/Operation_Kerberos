#define COMPONENT headquarter
#define COMPONENT_BEAUTIFIED Headquarter
#include "\x\dorb\addons\main\script_mod.hpp"

#define DEBUG_MODE_MINIMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_Headquarter
    #define DEBUG_MODE_FULL
#endif


// handler max. Intervall for FULL-CHECK
#define DEF_PLAYERGROUPCHECKINTERVALL 300
// handler Intervall
#define INTERVALL_PLAYERGROUPS 60
// handler anti-air
#define INTERVALL_AA 60
// handler ressources
#define INTERVALL_RESSOURCES 60


#define ATTACKPOS_DISTANCE 300
#define HQ_DANGERMOD 0.333
#define INTERVALL_HQ 40
#define INTERVALL_RADARS 20
#define INTERVALL_BUFFER 2

#define INTERVALL_FDC 45
#define INTERVALL_SEARCH 400

//#define DZVALUEMOD(DZVALUE) (((1.5*(log((DZVALUE/100000) max 1)/log(0.001))+1.5) * 100000) * DZVALUE)
#define DZVALUEMOD(DZVALUE) (DZVALUE)


#include "\x\dorb\addons\main\script_macros.hpp"
