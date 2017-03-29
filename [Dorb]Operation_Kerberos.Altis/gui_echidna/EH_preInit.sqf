#include "script_component.hpp"

ADDON = false;

PREP(addApp);
PREP(addMessage);
PREP(canOpenApps);
PREP(canOpenMenu);
PREP(close);
PREP(clock);
PREP(clockPFH);
PREP(hideMetro);
PREP(initHeader);
PREP(MetroBttn);
PREP(onLoad);
PREP(onUnLoad);
PREP(open);
PREP(registerApp);
PREP(setBackground);
PREP(showMetro);

ADDON = true;

GVAR(newMessage) = false;
GVAR(allMessages) = [];
GVAR(lastNotification) = 1;
GVAR(notifications) = HASH_CREATE;

GVAR(Applications) = HASH_CREATE;
HASH_SET(GVAR(Applications),"index",1);
{
    HASH_SET(GVAR(Applications),_x,[]);
} forEach ["0","1","2","3","4","5","6","7","8","9","10"];
