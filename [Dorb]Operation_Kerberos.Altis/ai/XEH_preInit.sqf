#include "script_component.hpp"

ADDON = false;

PREP(EH_killed);

PREPS(commander,init);
PREPS(commander,ai);
PREPS(commander,search);
PREPS(commander,callArty);

ADDON = true;