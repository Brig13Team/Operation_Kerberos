#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;

#include "XEH_PREP.sqf"

RECOMPILE_END;

ADDON = true;

#include "CBA_Settings_initialize.sqf"

ISNIL(ship,[]);
ISNIL(default,[]);
ISNIL(air,[]);
ISNIL(infanterie,[]);
ISNIL(pos_ship,[]);
ISNIL(pos_default,[]);
ISNIL(pos_air,[]);
ISNIL(pos_infanterie,[]);
ISNIL(to_lead_active,true);
