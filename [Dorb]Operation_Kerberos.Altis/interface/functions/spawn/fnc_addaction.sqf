/*
    Author: Dorbedo

    Description:
        adds Action to spawn
*/
#include "script_component.hpp"
SCRIPT(spawn_addaction);
CHECK(!hasInterface)

//////FAHRZEUGSPAWNS
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_VEHICLE_DESC) +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_VEHICLE),    fahrzeuge       ], 5, false, true, "","alive _target and (getposatl player distance getposatl fahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_DRONES_DESC)  +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_DRONES),     drohnen         ], 5, false, true, "","alive _target and (getposatl player distance getposatl drohnen) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_AIR_DESC)     +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_AIR),        luftfahrzeuge   ], 5, false, true, "","alive _target and (getposatl player distance getposatl luftfahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_WATER_DESC)   +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_WATER),      marine          ], 5, false, true, "","alive _target and (getposatl player distance getposatl marine) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_LOGISTIC_DESC)+"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_LOGISTIC),   logistik        ], 5, false, true, "","alive _target and (getposatl player distance getposatl logistik) < 4"]] call CBA_fnc_addPlayerAction;
