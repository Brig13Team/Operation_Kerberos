#define CBA_OFF
#include "script_component.hpp"
class strategy {
    //// _tankGroups,_infanterieGroups,_helicoptersGroups
    //// [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];
    
    /// simple attack
    class infanterie {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((count _infanterieGroups) > 0);
        };
        parameter = "[_currentLocation,_infanterieGroups]";
    };
    class tankattack {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((count _tankGroups) > 0);
        };
        parameter = "[_currentLocation,_tankGroups]";
    };
    class helicopter {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((count _helicoptersGroups) > 0);
        };
        parameter = "[_currentLocation,_helicoptersGroups]";
    };
    
    /// simple support
    class airborne {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_airborne)) > 0)
            c3 = Quote([] call EFUNC(spawn,unit_limit));
        };
        parameter = "[_currentLocation,_currenttroopsNeeded]";
    };
    class airinterception {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_airinterception)) > 0);
        };
    };
    class armored {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_armored)) > 0);
            c3 = Quote([] call EFUNC(spawn,unit_limit));
        };
    };
    class cas {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_cas)) > 0);
        };
    };
    class motorized {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_motorized)) > 0);
            c3 = Quote([] call EFUNC(spawn,unit_limit));
        };
    };
    class drones {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE((GVAR(callIn_drones)) > 0);
        };
    };
    class artillery {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE('artillery' call EFUNC(headquarter,fdc_ready));
        };
    };
    class rocket {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE('rocket' call EFUNC(headquarter,fdc_ready));
        };
    };
    class mortar {
        class conditions {
            c1 = "(random 1) > 0.5";
            c2 = QUOTE('mortar' call EFUNC(headquarter,fdc_ready));
        };
    };
    
    /// combined shit
    
};