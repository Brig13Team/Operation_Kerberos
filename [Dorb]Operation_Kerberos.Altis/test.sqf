#define INCLUDE_GUI
#include "script_component.hpp"

/*
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",2] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",3] call EFUNC(gui_tablet,addApp);

["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",2] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",3] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",2] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",3] call EFUNC(gui_tablet,addApp);

["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",3] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
["Test",{hint "test";},{true},"",1] call EFUNC(gui_tablet,addApp);
*/

private _id1 = ["Arsenal"] call EFUNC(gui,startLoadingScreen);
private _id2 = ["TEst"] call EFUNC(gui,startLoadingScreen);

_id1 spawn {
    for "_i" from 0 to 10 do {
        [_this,(_i/10)] call EFUNC(gui,progressLoadingScreen);
        uisleep 3;
        [_this] call EFUNC(gui,endLoadingScreen);
    };
};

for "_i" from 0 to 10 do {
    [_id2,(_i/10)] call EFUNC(gui,progressLoadingScreen);
    uisleep 1;
};


uisleep 20;
[_id2] call EFUNC(gui,endLoadingScreen);
uisleep 60;

endLoadingScreen;
