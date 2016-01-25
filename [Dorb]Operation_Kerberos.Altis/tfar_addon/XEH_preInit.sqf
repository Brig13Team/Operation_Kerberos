#include "script_component.hpp"
SCRIPT(XEH_PREINIT);
ADDON = false;

PREP(disableTFR);
PREP(disableTFRArea);
PREP(enableTFR);
PREP(enableTFRtime);
PREP(isSpeaking);
PREP(setAreaWhispering);
PREP(setWhispering);

ADDON = true;