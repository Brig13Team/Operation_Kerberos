#include "script_component.hpp"

ADDON = false;

PREP(checkContainerRestrictions);

PREP(initKnockKnock);
PREP(canCopyLoadout);
PREP(getLoadout);
PREP(halo);
PREP(assignCurator);
PREP(halo_addaction);
PREP(setLoadout);

PREP(onrespawn);
PREP(onkilled);
PREP(ongetIn);
PREP(onseatswitched);

PREPS(backpack,change);
PREPS(backpack,handle);
PREPS(backpack,init);

ADDON = true;
