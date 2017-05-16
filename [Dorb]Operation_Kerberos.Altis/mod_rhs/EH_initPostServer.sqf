/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the initPost Eventhandler
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


CHECK(!(missionNamespace getVariable [QGVARMAIN(isKerberos),false]))

// disable tire prssure
profilenamespace setvariable ['rhs_activeTirePressure',0];
profilenamespace setvariable ['rhs_voiceAnnouncer',0];


saveProfileNamespace;
