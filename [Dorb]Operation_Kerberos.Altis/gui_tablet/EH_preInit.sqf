#include "script_component.hpp"

ADDON = false;

PREP(addApp);
PREP(addMessage);
PREP(addNotification);
PREP(canOpenApps);
PREP(canOpenMenu);
PREP(close);
PREP(clock);
PREP(clockPFH);
PREP(displayPage);
PREP(initHeader);
PREP(onLoad);
PREP(onUnLoad);
PREP(open);
PREP(registerAppToDisplay);
PREP(removeNotification);
PREP(showNotifications);

ADDON = true;

GVAR(newMessage) = false;
GVAR(allMessages) = [];
GVAR(lastNotification) = 1;
GVAR(notifications) = HASH_CREATE;

GVAR(Applications) = HASH_CREATE;
HASH_SET(GVAR(Applications),"index",1);
{
    HASH_SET(GVAR(Applications),_x,[]);
} forEach ["0","1","2","3","4"];
