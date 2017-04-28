/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Adds Supplies
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!(GVAR(active)))

private _value = 0;

// average player kills units per hour
#define KILLS_PER_HOUR 12
#define KILLS_PER_MINUTE (KILLS_PER_HOUR/60)
#define PLAYERAMOUNT (count ([] call EFUNC(common,players)))
// average cost of a killed unit
#define COST_PER_KILL 300
// ressource handler intervall
#define HANDLER_TIMEFACTOR (INTERVALL_RESSOURCES/60)
// the mission has a targettime of 2 hours
#define MAINMISSION_TARGETTIME (60*60*2)
// the timefactor to prevent endless spawning of units
#define TIMEFACTOR (1 - ((CBA_missiontime - GVAR(missionStartTime))/MAINMISSION_TARGETTIME))


_value = (TIMEFACTOR * HANDLER_TIMEFACTOR * KILLS_PER_MINUTE * COST_PER_KILL * PLAYERAMOUNT + HASH_GET_DEF(GVAR(ressources),"amount",0)) max 0;

HASH_SET(GVAR(ressources),"amount",_value);
