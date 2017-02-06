#include "script_component.hpp"

ADDON = false;

PREP(addJammer);
PREP(getJammer);
PREP(getSignal);
PREP(handleJammerReturn);
PREP(handleSignalReturn);
PREP(isJammerActive);
PREP(removeJammer);

ADDON = true;

If (isNil QGVAR(jammer)) then {
    GVAR(jammer) = [];
};

GVAR(jammer_lastCheck) = HASH_CREATE;
