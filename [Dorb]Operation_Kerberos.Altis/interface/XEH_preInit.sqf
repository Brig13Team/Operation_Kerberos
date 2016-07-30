#include "script_component.hpp"

ADDON = false;

PREP(disp_blur);
PREP(disp_info_global);
PREP(disp_message_global);
PREP(disp_progressbar);
PREP(disp_timer);
PREP(message_global);
PREP(message);

PREPS(crate,add);
PREPS(crate,createlists);
PREPS(crate,filter);
PREPS(crate,getMod);
PREPS(crate,init);
PREPS(crate,keyEvent);
PREPS(crate,mass);
PREPS(crate,OnLoad);
PREPS(crate,OpenMenu);
PREPS(crate,save);
PREPS(crate,spawn);

PREPS(save,delete);
PREPS(save,load);
PREPS(save,OnOpen);
PREPS(save,OpenMenu);
PREPS(save,save);
PREPS(save,select);

PREPS(spawn,create);
PREPS(spawn,createlist);
PREPS(spawn,createlist_east);
PREPS(spawn,init);
PREPS(spawn,Open);
PREPS(spawn,select);


PREPS(teleport,init);
PREPS(teleport,lead);
PREPS(teleport,onLoad);


PREPS(tfr,onOpen);
PREPS(tfr,OpenMenu);
PREPS(tfr,setFreq);
PREPS(tfr,setGroup);

ADDON = true;

/// init variables
GVAR(msg_cur) = [];
GVAR(msg_cur_ID) = 0;
GVAR(msg_waiting) = [];
