/*

    Author: Dorbedo, iJesuz

*/

#define CBA_OFF
#include "script_component.hpp"

class CfgRemoteExec {
    class Functions {
        mode = 1;
        class EFUNC(player,eh_getin) {
            allowedTargets = 1;
        };
        #include "events\CfgRemoteExecFnc.hpp"
    };
};