#define CBA_OFF
#include "script_component.hpp"
class CfgTaskEnhancements {
    enable       = 1;            //0: disable new task features (default), 1: enable new task features & add new task markers and task widgets into the map
    3d           = 0;            //0: do not use new 3D markers (default), 1: replace task waypoints with new 3D markers
    3dDrawDist   = 50;            //3d marker draw distance (default: 2000)
    share        = 1;            //0: do not count assigned players (default), 1: count how many players have the task assigned
    propagate    = 1;            //0: do not propagate (default), 1: propagate shared tasks to subordinates
};
