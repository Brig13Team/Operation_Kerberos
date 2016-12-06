/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Connect to Kerberos DB
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - is Connected
 *
 */
#include "script_component.hpp"


private _result = "extdb3" callExtension "9:VERSION";
If (_result isEqualTo "") exitWith {
    ERROR("No extDB3 extension loaded");
    false;
};


_result = call compile ("extdb3" callExtension "9:LOCK_STATUS");
If ((_result select 0) == 1) exitWith {
    ERROR("Database is locked");
    false;
};

// reset the connection
"extdb3" callExtension "9:RESET";

_result = call compile ("extdb3" callExtension "9:ADD_DATABASE:KerberosDB");
If ((_result select 0) isEqualTo 0) exitWith {
    ERROR("Can not connect to Database");
    false;
};

private _time = (call compile ("extDB2" callExtension "9:LOCAL_TIME")) select 1;
LOG(Format[ARR_2("Connected to Database: %1",_time)]);

// Security
GVAR(sessionID) = str(round(random(999999)));
If !(isMultiplayer) then {
    GVAR(sessionID) = QUOTE(PREFIX);
};
_result = call compile ("extdb3" callExtension (format["9:ADD_DATABASE_PROTOCOL:KerberosDB:SQL_CUSTOM:%1:kerberos.ini",GVAR(sessionID)]));

If !((_result select 0) isEqualTo 1) exitWith {
    ERROR("Protocols not loaded");
    false;
};
LOG("Protocols loaded");

GVAR(initialized) = true;
true;
