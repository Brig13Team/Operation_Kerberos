#include "script_component.hpp"
CHECK(!isServer)
[] call FUNC(connectToDB);
["constructTablePlayers"] call FUNC(sendNoReturn);
