#include "script_component.hpp"

ADDON = false;

PREP(blur);
PREP(globalmessage);
PREP(message);
PREP(progressbar);
PREP(timer);

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
