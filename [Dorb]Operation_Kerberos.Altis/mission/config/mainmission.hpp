#include "script_component.hpp"

class main {
    /*
     *  abstact missions
     */
    class __base {
        class location {
            areas[] = {QGVAR(town), QGVAR(industrie), QGVAR(military), QGVAR(other)};
        };

        class object {};

        probability = 1;
        armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"specops",1}, {"droneoperations",1}, {"guards",1}};
    };

    class __oneCounter : __base {
        armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"guards",1}};
    };

    class __twoCounter : __oneCounter {};

    /*
     *  special missions
     */
    class _rtb : __base {
        class object : object {
            radius   = 100;
            position = "respawn_west";
        };
    };

    /*
     *  playable missions
     */
    class capture : __twoCounter {
        class location : location {
            areas[] = {QGVAR(town)};
        };

        class object : object {
            min = 1;
            max = 3;
            radius = 200;
        };
    };
    class device : __oneCounter {
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(other)};
        };

        class object : object {
            radius = 250;
        };
    };

    class emp : device {};

    class hostage : capture {
        class object : object {
            min = 1;
            max = 5;
        };
    };

    class intel : hostage {
        class object : object {
            min = 2;
            max = 10;
            radius = 250;
        };
    };

    class radiotower : __oneCounter {
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        };

        class object : object {
            min = 1;
            max = 3;
            radius = 1000;
        };
    };

    class scarab : radiotower {
        class object : object {
            radius = 100;
        };
    };

    class weaponcache : hostage {
        class location : location {
            areas[] = {QGVAR(town), QGVAR(military)};
        };

        class object : object {
            min = 5;
            max = 10;
        };
    };
};
