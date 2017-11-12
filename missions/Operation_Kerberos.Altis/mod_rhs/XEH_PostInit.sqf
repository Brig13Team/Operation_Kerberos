/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the initPost Eventhandler
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

missionNamespace setVariable ['RHS_ENGINE_STARTUP_OFF',true];
missionNameSpace setvariable ['rhs_vehicleRadioChatter',0];
missionNameSpace setvariable ['RHSDecalsOff',true];

// disable tire prssure
profilenamespace setvariable ['rhs_activeTirePressure',0];
profilenamespace setvariable ['rhs_voiceAnnouncer',0];

saveProfileNamespace;
