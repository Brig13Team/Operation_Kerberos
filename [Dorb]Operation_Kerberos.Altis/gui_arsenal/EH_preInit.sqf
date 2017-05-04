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

ADDON = true;

ISNIL(arsenal_boxes,[]);
ISNIL(allowedPositions,[]);
