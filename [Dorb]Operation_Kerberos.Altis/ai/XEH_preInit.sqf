#include "script_component.hpp"

ADDON = false;

PREP(EH_killed);

PREPS(commander,init);
PREPS(commander,ai);
PREPS(commander,search);
PREPS(commander,callArty);

PREPS(drones,attack);
PREPS(drones,createWaypoint);
PREPS(drones,doAirstrike);
PREPS(drones,doReconnaissance);
PREPS(drones,init);
PREPS(drones,requestAirstrike);
PREPS(drones,requestReconnaissance);
PREPS(drones,scan);

ADDON = true;
