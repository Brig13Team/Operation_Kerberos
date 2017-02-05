#include "script_component.hpp"

ADDON = false;

PREP(addJammer);
PREP(getJammedSignal);
PREP(getSignal);
PREP(handleJammerReturn);
PREP(handleSignalReturn);
PREP(isJammerActive);
PREP(removeJammer);
PREP(setJammer);

ADDON = true;

If (isNil QGVAR(jammer)) then {
    GVAR(jammer) = [];
};
