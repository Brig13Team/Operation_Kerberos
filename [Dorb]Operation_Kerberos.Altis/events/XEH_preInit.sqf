#include "script_component.hpp"

ADDON = false;

PREP(_raiseEvent);
PREP(addEventHandler);
PREP(clientEvent);
PREP(globalEvent);
PREP(globalExec);
PREP(localEvent);
PREP(remoteExec);
PREP(removeAllEventHandler);
PREP(removeEventHandler);
PREP(serverEvent);
PREP(targetEvent);

ADDON = true;