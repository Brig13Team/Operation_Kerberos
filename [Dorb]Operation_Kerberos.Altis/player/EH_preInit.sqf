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
PREP(grouptracker);
PREP(halo);
PREP(assignCurator);
PREP(halo_addaction);
PREP(setLoadout);

PREP(onfired);
PREP(onrespawn);
PREP(onkilled);
PREP(ongetIn);
PREP(onseatswitched);

PREPS(backpack,change);
PREPS(backpack,handle);
PREPS(backpack,init);

PREPS(suppression,onfired);
PREPS(suppression,handle_effect);
PREPS(suppression,handle_fired);
PREPS(suppression,init);



ADDON = true;
