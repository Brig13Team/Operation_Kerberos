#include "script_component.hpp"

ADDON = false;

PREP(addArsenal);
PREP(addbriefing);
PREP(grouptracker);
PREP(halo);
PREP(halo_addaction);

PREP(EH_fired);
PREP(EH_hit);
PREP(EH_respawn);
PREP(EH_getIn);
PREP(EH_seatswitched);

PREPS(backpack,change);
PREPS(backpack,handle);
PREPS(backpack,init);

PREPS(suppression,EH_fired);
PREPS(suppression,handle_effect);
PREPS(suppression,handle_fired);
PREPS(suppression,init);



ADDON = true;