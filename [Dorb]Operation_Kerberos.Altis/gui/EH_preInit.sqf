#include "script_component.hpp"

ADDON = false;

PREP(blur);
PREP(globalmessage);
PREP(message);
PREP(progressbar);
PREP(timer);

PREP(onLoadLoadingscreen);
PREP(progressLoadingScreen);
PREP(startLoadingScreen);
PREP(endLoadingScreen);
PREP(noise);
PREP(noise_square);

PREP(addNotification);
PREP(handleNotifications);
PREP(removeAllNotifications);
PREP(removeNotification);


ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
GVAR(notifications) = HASH_CREATE;
