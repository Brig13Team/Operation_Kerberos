/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates water patrols
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : SCALAR - Radius
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_position",[],[[]],[2,3]],["_radius",1200,[0]]];

private _searchposarray = [_position];
private _searchrad = 1;
private _step = 50;
private _s = 0;
while {_searchrad < _radius} do {
    private _circumference = 2 * pi * _searchrad;
    private _theta = ((_s*360)/(2*_searchrad*pi));
    _searchposarray pushBack ([_position, _searchrad, _theta] call BIS_fnc_relPos);
    _s=_s+_step;
    If (_s > _circumference) then {
        _searchrad = _searchrad + _step;
        _s=0;
    };
};
private _amountOfWater = {surfaceIsWater _x}count _searchposarray;
// exit if there is only a small amount of water
CHECK(_amountOfWater<301)


private _amount_boats = floor((_amountOfWater - 300)/200);
private _amount_diver = floor((_amountOfWater - 300)/350);



for "_i" from 0 to _amount_boats do {
    private _rad = ((random 200) + 500);
    private _spawnpos = [_position,_radius,3] call EFUNC(common,random_pos);
    private _bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
    private _unit = ["boat"] call FUNC(getUnit);
    If (!(_bestpos isEqualTo [])) then {
        _spawnpos = (_bestpos select 0) select 0;
        #ifdef DEBUG_MODE_FULL
            [_spawnpos,"Boat","ColorRed","n_naval"] call EFUNC(common,debug_marker_create);
        #endif
        _spawnpos set[2,0];
        private _group = createGroup GVARMAIN(side);
        private _boat = createVehicle[_einheit,_spawnpos,[], 0, "NONE"];
        [_boat,_group] call FUNC(crew);
        [_group,_spawnpos,_rad] call FUNC(water_patrol);
    };
};
for "_i" from 0 to _amount_diver do {
    private _rad = ((random 200) + 500);
    private _spawnpos = [_position,_radius,3] call EFUNC(common,random_pos);
    private _bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
    If (!(_bestpos isEqualTo [])) then {
        private _units = [];
        for "_j" from 0 to 3 do {
            _units pushBack (["diver"] call FUNC(getUnit));
        };
        _spawnpos = (_bestpos select 0) select 0;
        _spawnpos set[2,0];
        LOG_1(_spawnpos);
        #ifdef DEBUG_MODE_FULL
            [_spawnpos,"Boat","ColorRed","n_inf"] call EFUNC(common,debug_marker_create);
        #endif
        private _return = [_spawnpos,GVARMAIN(side),_einheiten] call BIS_fnc_spawnGroup;
        [_return, _spawnpos, _rad,-10] call FUNC(water_patrol);
        {_x swimInDepth -10} forEach (units _return);
    };
};
