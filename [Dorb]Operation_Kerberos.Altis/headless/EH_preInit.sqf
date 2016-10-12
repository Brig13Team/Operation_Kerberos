#include "script_component.hpp"
ADDON = false;

PREP(HCconnect);
PREP(HCdisconnect);
PREP(initPost);
PREP(transfer);

ADDON = true;

If (isNil QGVARMAIN(HC_enabled)) then {GVARMAIN(HC_enabled)=true;};

GVAR(istransfering) = false;
GVAR(HeadlessClients) = [];