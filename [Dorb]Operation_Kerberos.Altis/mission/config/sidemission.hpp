#define CBA_OFF
#include "script_component.hpp"

class side {
    /*
     *  abstact missions
     */
    class __base {
    	class location {};
        class object {};

        probability = 1.0;
    };

    /*
     *  playable missions
     */
    class radar : __base {
        class location : location {
            radius = 500;
        };
    };

/*
    class wreck : __base {
        class location : location {
            radius = 3000;
        };
    };
*/
};
