#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

ISNIL(arsenal_boxes,[]);
ISNIL(allowedPositions,[]);
ISNIL(level,2);
ISNIL(allowedradius,25);

#include "CBA_Settings_initialize.sqf"
