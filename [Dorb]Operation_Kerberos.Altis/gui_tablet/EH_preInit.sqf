#include "script_component.hpp"

ADDON = false;

PREP(clock);
PREP(addMessage);

ADDON = true;

GVAR(allMessages) = [];
GVAR(lastNotification) = 1;
GVAR(notifications) = HASH_CREATE;
