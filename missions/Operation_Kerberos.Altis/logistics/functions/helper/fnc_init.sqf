/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the interaction for the cargo-helper
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(isNil QGVAR(helper_security)) exitWith {};
GVAR(helper_security) = true;

GVAR(helper_vehicle) = objNull;
GVAR(helper_arrows) = [objNull];
GVAR(helper_passenger) = [];
GVAR(helper_passenger_grp) = createGroup civilian;
GVAR(helper_passenger_pos) = [];


GVAR(helper_cargo_w) = 0;
GVAR(helper_cargo_h) = 0;
GVAR(helper_cargo_l) = 0;
GVAR(helper_cargo_x) = 0;
GVAR(helper_cargo_y) = 0;
GVAR(helper_cargo_z) = 0;

GVAR(helper_veh_w) = 0;
GVAR(helper_veh_h) = 0;
GVAR(helper_veh_l) = 0;
GVAR(helper_veh_x) = 0;
GVAR(helper_veh_y) = 0;
GVAR(helper_veh_z) = 0;
GVAR(helper_veh_load_x) = 0;
GVAR(helper_veh_load_y) = 0;
GVAR(helper_veh_load_z) = 0;


player addAction [
    "Cargo-Helper",
    {_this call FUNC(helper_cargo);}
];

player addAction [
    "Vehicle-Helper",
    {_this call FUNC(helper_vehicle);}
];
