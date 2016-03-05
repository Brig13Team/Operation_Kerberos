#define CBA_OFF
#include "script_component.hpp"
class strategy {
    //// _tankGroups,_infanterieGroups,_helicoptersGroups
    //// [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];
    
    /// simple attack
    class infanterie {
        condition = QUOTE(((count _infanterieGroups) > 0)&&([] call EFUNC(spawn,unit_limit)));
        probability = 0.5;
        parameter = "[_currentLocation,_infanterieGroups]";
    };
    class tankattack : infanterie {
       condition = QUOTE(((count _tankGroups) > 0)&&([] call EFUNC(spawn,unit_limit))); 
        parameter = "[_currentLocation,_tankGroups]";
    };
    class helicopter : infanterie {
        condition = QUOTE(((count _helicoptersGroups) > 0)&&([] call EFUNC(spawn,unit_limit)));
        parameter = "[_currentLocation,_helicoptersGroups]";
    };
    
    /// simple support
    class airborne : infanterie {
        condition = QUOTE(((GVAR(callIn_airborne)) > 0)&&([] call EFUNC(spawn,unit_limit))); 
        parameter = "[_currentLocation,_currenttroopsNeeded]";
    };
    class airinterception : airborne {
        condition = QUOTE(((GVAR(callIn_airinterception)) > 0)&&([] call EFUNC(spawn,unit_limit)));
    };
    class armored : airborne {
        condition = QUOTE(((GVAR(callIn_armored)) > 0)&&([] call EFUNC(spawn,unit_limit)));
    };
    class cas : airborne {
        condition = QUOTE((GVAR(callIn_cas)) > 0);
    };
    class motorized : airborne {
        condition = QUOTE(((GVAR(callIn_motorized)) > 0)&&([] call EFUNC(spawn,unit_limit)));
    };
    class drones : airborne {
        condition = QUOTE((GVAR(callIn_drones)) > 0);
    };
    class artillery : airborne {
        condition = QUOTE('artillery' call EFUNC(headquarter,fdc_ready));
    };
    class rocket : airborne {
        condition = QUOTE('rocket' call EFUNC(headquarter,fdc_ready));
    };
    class mortar : airborne {
        condition = QUOTE('mortar' call EFUNC(headquarter,fdc_ready));
    };
    
    /// combined shit
    
};