#include "script_component.hpp"

ADDON = false;

PREP(canChangeCamera);
PREP(onCameraChanged);

ADDON = true;

ISNIL(active,true);
ISNIL(forcealwaysFirst,false);
ISNIL(forcefoot,true);
ISNIL(forcevehicle,true);
ISNIL(forceair,false);
ISNIL(forceship,true);
