#define CBA_OFF
#include "script_component.hpp"

class side {
    /*
     *  abstact missions
     */
    class __base {
        class object {};

        probability = 1;
    };

    /*
     *  playable missions
     */
    class radar : __base {
        class object : object {
            radius = 500;
        };
    };
};
