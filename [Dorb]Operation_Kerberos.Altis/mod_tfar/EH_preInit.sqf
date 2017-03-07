#include "script_component.hpp"
ADDON = false;

PREP(addRadio);
PREP(disableTFR);
PREP(disableTFRArea);
PREP(enableTFR);
PREP(enableTFRtime);
PREP(isSpeaking);
PREP(setAreaWhispering);
PREP(setWhispering);

ADDON = true;

tf_no_auto_long_range_radio = true;
