#include "script_component.hpp"
ADDON = false;

PREP(HCconnect);
PREP(HCdisconnect);
PREP(onInit);
PREP(transfer);

ADDON = true;

GVAR(HC_enabled)=true;

GVAR(istransfering) = false;
GVAR(HeadlessClients) = [];
