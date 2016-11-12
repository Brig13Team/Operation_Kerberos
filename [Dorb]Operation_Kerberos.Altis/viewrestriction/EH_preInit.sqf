#include "script_component.hpp"

ADDON = false;

PREP(canChangeCamera);
PREP(onCameraChanged);

ADDON = true;

GVAR(active) = true;
GVAR(forcealwaysFirst) = false;
GVAR(forcefoot) = true;
GVAR(forcevehicle) = false;
GVAR(forceair) = false;
GVAR(forceship) = false;
