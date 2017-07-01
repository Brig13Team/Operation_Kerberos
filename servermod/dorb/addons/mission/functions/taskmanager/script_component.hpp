#include "\x\dorb\addons\mission\script_component.hpp"

#define CHECK_INTERVALL     (If (isMultiplayer) then {30}else{5})

#define __THIS              GVAR(master)
#define THIS_GET(key)       HASH_GET(__THIS,key)
#define THIS_SET(key,value) HASH_SET(__THIS,key,value)
#define THIS_HASKEY(key)    HASH_HASKEY(__THIS,key)
#define THIS_REM(key)       HASH_REM(__THIS,key)
