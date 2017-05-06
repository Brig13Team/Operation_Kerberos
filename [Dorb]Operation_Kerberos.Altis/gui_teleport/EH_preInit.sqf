#include "script_component.hpp"

ADDON = false;

PREP(canOpenMenu);
PREP(lead);
PREP(onLoad);
PREP(teleport);

PREP(animBttn);
PREP(openMap);
PREP(registerTeleportPosition);
PREP(registerTeleportTarget);


ADDON = true;

ISNIL(ship,[]);
ISNIL(default,[]);
ISNIL(air,[]);
ISNIL(infanterie,[]);
ISNIL(pos_ship,[]);
ISNIL(pos_default,[]);
ISNIL(pos_air,[]);
ISNIL(pos_infanterie,[]);
ISNIL(teleport_lead_active,false);
