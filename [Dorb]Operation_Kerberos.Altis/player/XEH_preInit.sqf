#include "script_component.hpp"

ADDON = false;

PREP(addArsenal);
PREP(addArsenalAction);
PREP(addRestrictedArsenal);
PREP(addSideRestrictedArsenal);
PREP(getRestrictedArsenal);
PREP(getSideRestrictedArsenal);
PREP(checkContainerRestrictions);

PREP(addbriefing);
PREP(addColorActions);
PREP(grouptracker);
PREP(halo);
PREP(assignCurator);
PREP(halo_addaction);
PREP(setLoadout);

PREP(EH_fired);
PREP(EH_hit);
PREP(EH_respawn);
PREP(EH_killed);
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
