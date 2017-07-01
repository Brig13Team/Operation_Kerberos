
#include "script_component.hpp"

#define CONFIG_TASK(VAR) class VAR { \
    icon = \A3\ui_f\data\igui\cfg\simpleTasks\types\##VAR##_ca.paa; \
}

class CfgTaskTypes {
    CONFIG_TASK(armor);
    CONFIG_TASK(attack);
    CONFIG_TASK(Default);
    CONFIG_TASK(defend);
    CONFIG_TASK(destroy);
    CONFIG_TASK(download);
    CONFIG_TASK(exit);
    CONFIG_TASK(heal);
    CONFIG_TASK(interact);
    CONFIG_TASK(intel);
    CONFIG_TASK(kill);
    CONFIG_TASK(map);
    CONFIG_TASK(meet);
    CONFIG_TASK(move);
    CONFIG_TASK(move1);
    CONFIG_TASK(move2);
    CONFIG_TASK(move3);
    CONFIG_TASK(move4);
    CONFIG_TASK(move5);
    CONFIG_TASK(navigate);
    CONFIG_TASK(radio);
    CONFIG_TASK(rearm);
    CONFIG_TASK(refuel);
    CONFIG_TASK(repair);
    CONFIG_TASK(rifle);
    CONFIG_TASK(run);
    CONFIG_TASK(scout);
    CONFIG_TASK(search);
    CONFIG_TASK(talk);
    CONFIG_TASK(talk1);
    CONFIG_TASK(talk2);
    CONFIG_TASK(talk3);
    CONFIG_TASK(talk4);
    CONFIG_TASK(talk5);
    CONFIG_TASK(target);
    CONFIG_TASK(upload);
    CONFIG_TASK(walk);
    CONFIG_TASK(whiteboard);
};
