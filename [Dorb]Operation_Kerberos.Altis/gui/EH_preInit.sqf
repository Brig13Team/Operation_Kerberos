#include "script_component.hpp"

ADDON = false;

PREP(blur);
PREP(globalmessage);
PREP(message);

PREP(bttn);

PREP(onLoadLoadingscreen);
PREP(progressLoadingScreen);
PREP(startLoadingScreen);
PREP(endLoadingScreen);
PREP(noise);
PREP(noise_square);

PREP(handleTimer);
PREP(setTimer);
PREP(setTimerGlobal);
PREP(stopTimer);
PREP(stopTimerGlobal);

PREP(addNotification);
PREP(handleNotifications);
PREP(removeAllNotifications);
PREP(removeNotification);

PREP(getGradient);
PREP(isLoadingBarShown);
PREP(endLoadingBar);
PREP(progressLoadingBar);
PREP(startLoadingBar);

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
GVAR(notifications) = HASH_CREATE;
