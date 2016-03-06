#include "script_component.hpp"
ADDON = false;

PREP(connect);
PREP(disconnect);
PREP(initPost);
PREP(move);

ADDON = true;

GVAR(transfering) = false;
GVAR(HeadlessClients) = [];