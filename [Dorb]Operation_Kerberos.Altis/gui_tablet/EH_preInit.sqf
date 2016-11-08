#include "script_component.hpp"

ADDON = false;

PREP(addApp);
PREP(addMessage);
PREP(addNotification);
PREP(canOpenMenu);
PREP(clock);
PREP(onLoad);
PREP(removeNotification);
PREP(showNotification);

ADDON = true;

GVAR(newMessage) = false;
GVAR(allMessages) = [];
GVAR(lastNotification) = 1;
GVAR(notifications) = HASH_CREATE;

GVAR(Applications) = HASH_CREATE;
HASH_SET(GVAR(Applications),"index",1);
{
    HASH_SET(GVAR(Applications),_x,[]);
} forEach ["0","1","-1","2","-2"];
