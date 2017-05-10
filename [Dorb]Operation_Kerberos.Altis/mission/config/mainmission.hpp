#define CBA_OFF
#include "script_component.hpp"

class main {
    /*
     *  abstact missions
     */
    class __base {
        class location {
            areas[] = {QGVAR(town), QGVAR(industrie), QGVAR(military), QGVAR(other)};
        };

        class defence {
            target = ""; // "house", "composition" or ""
            armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"specops",1}, {"droneoperations",1}, {"guards",1}};

            composition_types[] = {"isObjective"};
            house_types[] = {"hasmissiontarget"};
        };

        class object {};

        class side {
            min = 1;
            max = 1;
            types[] = {"__base"};
        };

        probability = 1.0;
    };

    class __oneCounter : __base {
        conditiontype = "oneCounter";
        class defence : defence {
            target = "composition";
            armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"guards",1}};
        };
    };

    class __twoCounter : __oneCounter {
        conditiontype = "twoCounter";
        class defence : defence {
            target = "house";
        };
    };

    /*
     *  playable missions
     */
    class capture : __twoCounter {
        class location : location {
            areas[] = {QGVAR(town)};
            radius = 200;
        };

        class object : object {
            min = 1;
            max = 3;
        };
    };

    class device : __oneCounter {
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(other)};
            radius = 250;
        };
    };

    class dronecommando : __oneCounter {
        class location : location {
            radius = 500;
        };

        class defence : defence {
            armys[] = {{"droneoperations",1}, {"specops",1}};
        };
    };

    class emp : device {};

/*
    class hold : __oneCounter {
        class location : location {
            radius = 250;
        };

        class object : object {
            tickets = 135000; // 25 player for 30 minutes
            multiplier = 0.01;
            min = 0;
            max = 0;
        };

        class defence : defence {
            target = "";
        };

        class side : side {
            types[] = {};
        };
    };
*/

    class hostage : capture {
        class object : object {
            min = 1;
            max = 5;
        };
    };

    class prototype : __oneCounter {
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
            radius = 500;
        };
    };

    class intel : hostage {
        class location : location {
            radius = 250;
        };

        class object : object {
            min = 2;
            max = 6;
        };
    };

    class jammer : __oneCounter {
        class location : location {
            radius = 1500;
        };

        class object : object {
            min = 1;
            max = 3;
        };
    };

    class radiotower : __oneCounter {
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
            radius = 1000;
        };

        class object : object {
            min = 1;
            max = 3;
        };
    };

/*
    // internal rhs script produces too much script errors
    class scarab : radiotower {
        class object : object {
            radius = 100;
        };
    };
*/

    class upload : device {
        class location : location {
            areas[] = {QGVAR(military)};
            radius = 200;
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
