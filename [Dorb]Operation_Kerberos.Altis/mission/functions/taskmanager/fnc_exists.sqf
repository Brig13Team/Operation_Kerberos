/*
    Author: iJesuz

    Description:
        Checks if Task exists

    Parameter(s):
       NUMBER    - TaskNumber

    Return:
       BOOL
*/
#include "script_component.hpp"

if ((missionNamespace getVariable [format["@%1_%2.0",QGVAR(task),_number],""]) isEqualTo "") then {
    true
} else {
    false
}
