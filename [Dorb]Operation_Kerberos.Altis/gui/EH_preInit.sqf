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

PREP(getGradient);
PREP(endLoadingBar);
PREP(progressLoadingBar);
PREP(startLoadingBar);

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
