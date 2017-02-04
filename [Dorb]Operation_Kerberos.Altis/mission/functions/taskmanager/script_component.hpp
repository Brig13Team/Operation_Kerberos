#include "..\script_component.hpp"

#define CHECK_INTERVALL     30

#define THIS                GVAR(state)
#define THIS_GET(key)       HASH_GET(THIS,key)
#define THIS_SET(key,value) HASH_SET(THIS,key,value)
#define THIS_HASKEY(key)    HASH_HASKEY(THIS,key)
#define THIS_REM(key)       HASH_REM(THIS,key)
