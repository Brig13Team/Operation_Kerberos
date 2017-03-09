/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

PREP(getSignal);

PREPS(babbel,addLanguageLocal);
PREPS(babbel,canAddLanguage);
PREPS(babbel,removeLanguageLocal);

PREPS(jammer,add);
PREPS(jammer,getSignalOutput);
PREPS(jammer,getArray);
PREPS(jammer,getSignal);
PREPS(jammer,getSignalSimple);
PREPS(jammer,handleReturn);
PREPS(jammer,isActive);
PREPS(jammer,remoteStopSpeaking);
PREPS(jammer,remove);
PREPS(jammer,selectBest);

ADDON = true;

If (isNil QGVAR(jammer)) then {
    GVAR(jammer) = [];
};
GVAR(advancedjammer) = true;
GVAR(jammer_lastCheck) = HASH_CREATE;
