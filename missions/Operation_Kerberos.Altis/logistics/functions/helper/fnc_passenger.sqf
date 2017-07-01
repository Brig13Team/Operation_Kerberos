/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows the cargopositions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;

private _display = (findDisplay 10000);
private _table = _display displayCtrl 11001;

{deleteVehicle _x} forEach GVAR(helper_passenger);


for "_i" from 0 to (ctRowCount _table) do {
    (_table ctRowControls _i) params ["_background","_number","_checkbox"];
    TRACEV_2(_i,cbChecked _checkbox);

    private _unit = GVAR(helper_passenger_grp) createUnit ["C_Soldier_VR_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    GVAR(helper_passenger) pushBack _unit;
    _unit disableAI "ALL";
    _unit moveInCargo [GVAR(helper_vehicle), _i];
    private _pos = GVAR(helper_vehicle) worldToModel (getPos _unit);

    if (cbChecked _checkbox) then {
        GVAR(helper_passenger_pos) set [_i,_pos];
    }else{
        GVAR(helper_passenger_pos) set [_i,[]];
    };
};
/*
    Because Arma.... always strange
*/
{
    If ((GVAR(helper_passenger_pos) select (GVAR(helper_vehicle) getCargoIndex _x))isEqualTo []) then {
        deleteVehicle _x;
    };
} forEach (crew GVAR(helper_vehicle));
