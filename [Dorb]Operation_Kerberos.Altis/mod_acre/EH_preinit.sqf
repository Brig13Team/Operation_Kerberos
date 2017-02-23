#include "script_component.hpp"

ADDON = false;

PREP(addJammer);
PREP(babbel_addLanguageLocal);
PREP(babbel_canAddLanguage);
PREP(babbel_removeLanguageLocal);
PREP(getJammedSignal);
PREP(getJammerArray);
PREP(getJammerSignal);
PREP(getJammerSignalSimple);
PREP(getSignal);
PREP(handleJammerReturn);
PREP(isJammerActive);
PREP(remoteStopSpeaking);
PREP(removeJammer);
PREP(selectBestJammer);

ADDON = true;

If (isNil QGVAR(jammer)) then {
    GVAR(jammer) = [];
};

GVAR(jammer_lastCheck) = HASH_CREATE;
