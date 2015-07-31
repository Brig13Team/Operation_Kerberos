/*
    Author: Dorbedo

    Description:
        adds Action to spawn
*/
#include "script_component.hpp"
SCRIPT(ui_spawn_addaction);
CHECK(!hasInterface)

//////FAHRZEUGSPAWNS
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"   +localize "STR_DORB_SPAWN_VEHICLE_DESC" +"</t>",    {_this call FM(ui_spawn_Open);}, [localize "STR_DORB_SPAWN_VEHICLE",    fahrzeuge       ], 5, false, true, "","alive _target and (getposatl player distance getposatl fahrzeuge) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"   +localize "STR_DORB_SPAWN_DRONES_DESC"  +"</t>",    {_this call FM(ui_spawn_Open);}, [localize "STR_DORB_SPAWN_DRONES",     drohnen         ], 5, false, true, "","alive _target and (getposatl player distance getposatl drohnen) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"   +localize "STR_DORB_SPAWN_AIR_DESC"     +"</t>",    {_this call FM(ui_spawn_Open);}, [localize "STR_DORB_SPAWN_AIR",        luftfahrzeuge   ], 5, false, true, "","alive _target and (getposatl player distance getposatl luftfahrzeuge) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"   +localize "STR_DORB_SPAWN_WATER_DESC"   +"</t>",    {_this call FM(ui_spawn_Open);}, [localize "STR_DORB_SPAWN_WATER",      marine          ], 5, false, true, "","alive _target and (getposatl player distance getposatl marine) < 4"];
player addAction ["<t size='1.5' shadow='2' color='#FF860F'>"   +localize "STR_DORB_SPAWN_LOGISTIC_DESC"+"</t>",    {_this call FM(ui_spawn_Open);}, [localize "STR_DORB_SPAWN_LOGISTIC",   logistik        ], 5, false, true, "","alive _target and (getposatl player distance getposatl logistik) < 4"];
