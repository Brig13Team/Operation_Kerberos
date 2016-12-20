#include "script_component.hpp"

ADDON = false;

PREP(canChangeCamera);
PREP(onCameraChanged);

ADDON = true;

GVAR(active) = true;
GVAR(forcealwaysFirst) = false;
GVAR(forcefoot) = true;
GVAR(forcevehicle) = true;
GVAR(forceair) = false;
GVAR(forceship) = true;
