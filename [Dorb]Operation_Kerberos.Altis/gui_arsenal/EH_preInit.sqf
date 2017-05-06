#include "script_component.hpp"

ADDON = false;

PREP(canOpenMenu);
PREP(OpenMenu);

PREP(addArsenal);
PREP(addArsenalArea);
PREP(addRestrictedArsenal);
PREP(addSideRestrictedArsenal);
PREP(createLocalArsenal);
PREP(debugTemplate);
PREP(getRestrictedArsenal);
PREP(getSideRestrictedArsenal);
PREP(removeArsenal);

PREP(isRestrictedArray);
PREP(Open);
PREP(cleanPlayer);
PREP(getFastArsenalList);
PREP(OnLoad);
PREP(onRespawn);
PREP(loadFast);

ADDON = true;

ISNIL(arsenal_boxes,[]);
ISNIL(allowedPositions,[]);
