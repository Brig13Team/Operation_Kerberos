#include "script_component.hpp"

ADDON = false;

PREP(_EventExec);
PREP(globalExec);
PREP(targetExec);
PREP(targetExecFast);

PREP(addEventHandler);
PREP(globalEvent);
PREP(serverEvent);
PREP(localEvent);
PREP(removeAllEventHandler);
PREP(removeEventHandler);

ADDON = true;


DOUBLES(PREFIX,l)=[];
DOUBLES(PREFIX,e)=[];

if (!hasInterface) then {
    QUOTE(DOUBLES(PREFIX,l)) addpublicVariableEventHandler {(_this select 1) spawn FUNC(targetExec);};
    QUOTE(DOUBLES(PREFIX,e)) addpublicVariableEventHandler {(_this select 1) spawn FUNC(_EventExec);};
}else{
    [] spawn {
        waitUntil {alive player};
        QUOTE(DOUBLES(PREFIX,e)) addpublicVariableEventHandler {(_this select 1) spawn FUNC(_EventExec);};
    };
};
