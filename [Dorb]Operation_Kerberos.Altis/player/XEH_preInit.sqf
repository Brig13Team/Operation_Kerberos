#include "script_component.hpp"

ADDON = false;

PREP(addArsenal);
PREP(addbriefing);
PREP(grouptracker);
PREP(halo);
PREP(halo_addaction);
PREP(onlyPilots);
PREP(playeraddaction);

PREP(EH_fired);
PREP(EH_hit);
PREP(EH_hitPart);
PREP(EH_respawn);
PREP(EH_getIn);
PREP(EH_seatswitched);

PREPS(backpack,change);
PREPS(backpack,handle);
PREPS(backpack,init);

PREPS(supression,EH_fired);
PREPS(handle_effect);
PREPS(handle_fired);
PREPS(init);



ADDON = true;