#include "script_component.hpp"

ADDON = false;

PREP(addbeLoadedActions);
PREP(addLoadActions);
PREP(canbeLoad);
PREP(canbeLoaded);
PREP(candrop);
PREP(canload);
PREP(canunload);
PREP(disp_cargo);
PREP(doload);
PREP(dounload);
PREP(getCargoCfg);
PREP(load);
PREP(unload);

PREP(setContainerWeight);
PREP(updateSeats);

PREP(canChangeCargo);
PREP(ChangeCargo);

PREPS(simpletowing,canTow);
PREPS(simpletowing,canUnTow);
PREPS(simpletowing,doTow);
PREPS(simpletowing,doUnTow);

PREPS(helper,init);
PREPS(helper,cargo);
PREPS(helper,cargo_export);
PREPS(helper,vehicle);
PREPS(helper,vehicle_export);
PREPS(helper,passenger);

ADDON = true;
