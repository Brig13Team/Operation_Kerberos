/*
    Author: Dorbedo

    Description:
    Spawns Water Patrols

    Parameter(s):
        0 : ARRAY   - Spawnposition
        1 : SCALAR  - Radius
        2 : SCALAR  - number of boats (-1 = automatic)
        3 : SCALAR  - nuber of divers (-1 = automatic)


    Returns:
        Array - Array of spawned objects

*/
#include "script_component.hpp"
SCRIPT(water);
private ["_amountOfWater","_patrol","_vehicles", "_objects"];
params["_position",["_radius",1200,[0]],["_anzahl_boats",0,[0]],["_anzahl_diver",0,[0]]];
_objects = [];
_amountOfWater = 0;
//If  ((_anzahl_boats<0)||(_anzahl_diver<0)) then {
    private["_searchposarray","_searchrad","_step","_s"];
    _searchposarray = [_position];
    _searchrad = 1;
    _step = 50;
    _s = 0;
    while {_searchrad < _radius} do {
        private["_umfang","_theta"];
        _umfang = 2 * pi * _searchrad;
        _theta = ((_s*360)/(2*_searchrad*pi));
        _searchposarray pushBack ([_position, _searchrad, _theta] call BIS_fnc_relPos);
        _s=_s+_step;
        If (_s > _umfang) then {
            _searchrad = _searchrad + _step;
            _s=0;
        };
    };
    _amountOfWater = {surfaceIsWater _x}count _searchposarray;
//};
/// exit if there is only a small amount of water
CHECK(_amountOfWater<301)

If (_anzahl_boats < 0) then {
    _anzahl_boats = floor((_amountOfWater - 300)/200);
};
If (_anzahl_diver < 0) then {
    _anzahl_diver = floor((_amountOfWater - 300)/350);
};

LOG_2(_anzahl_boats,_anzahl_diver);

_patrol = {
    Private["_wp_behavior","_wp_competionradius","_wp_formation","_wp_speed","_wp_type"];
    _wp_behavior = "RED";
    _wp_competionradius = 40;
    _wp_formation = "STAG COLUMN";
    _wp_speed = "LIMITED";
    _wp_type = "MOVE";

    private ["_prevPos"];
    params["_grp","_pos","_maxDist",["_depth",0,[0]]];
    _grp setBehaviour _wp_behavior;

    _prevPos = _pos;
    for "_i" from 0 to (2 + (floor (random 3))) do
    {
        private ["_wp", "_newPos"];
        //_newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
        _newPos = [_prevPos,_maxDist,3] call EFUNC(common,pos_random);

        _bestpos = (selectBestPlaces [_newPos, 15, "waterdepth", 2, 5]);
        _newPos = (_bestpos select 0) select 0;
        _newPos set [2,_depth];


        if (dorb_debug) then {
            private "_mrkr";
            _mrkr = createMarker [format["veh-%1-%2",_i,_newPos],_newPos];
            _mrkr setMarkerShape "ICON";
            _mrkr setMarkerColor "ColorBlue";
            _mrkr setMarkerType "hd_dot";
        };



        //_newPos = _newPos isFlatEmpty [7.5,10,0.7,14,2,true];

        _prevPos = _newPos;

        _wp = _grp addWaypoint [_newPos, 0];
        _wp setWaypointType _wp_type;
        _wp setWaypointCompletionRadius _wp_competionradius;

        if (_i == 0) then
        {
            _wp setWaypointSpeed _wp_speed;
            _wp setWaypointFormation _wp_formation;
        };
    };

    private ["_wp"];
    _wp = _grp addWaypoint [_pos, 0];
    _wp setWaypointType "CYCLE";
    _wp setWaypointCompletionRadius 20;

    true

};

_vehicles=[];

for "_i" from 0 to _anzahl_boats do {
    private["_rad","_spawnpos","_einheit"];
    _rad = ((random 200) + 500);
    _spawnpos = [_position,_radius,3] call EFUNC(common,pos_random);
    _einheit = dorb_patrolboatlist SELRND;
    If (!(_spawnpos isEqualTo [])) then {
        private["_gruppe","_bestpos","_boat"];
        _bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
        CHECK(_bestpos isEqualTo [])
        _spawnpos = (_bestpos select 0) select 0;
        if (dorb_debug) then {
            private "_mrkr";
            _mrkr = createMarker [format["naval-%1",_spawnpos],_spawnpos];
            _mrkr setMarkerShape "ICON";
            _mrkr setMarkerColor "ColorRed";
            _mrkr setMarkerType "n_naval";
        };
        _spawnpos set[2,0];
        _gruppe = createGroup GVARMAIN(side);
        _boat = createVehicle[_einheit,_spawnpos,[], 0, "NONE"];
        _objects pushBack _boat;
        { _objects pushBack _x; } forEach (crew _boat);
        [_boat,_gruppe] call FUNC(crew);
        _vehicles pushBack _boat;
        [_gruppe, _spawnpos, _rad] call _patrol;
        
        //_return = [_spawnpos,(random(360)),_einheit,GVARMAIN(side)] call BIS_fnc_spawnVehicle;
        //_vehicles pushBack (_return select 0);
        //[(_return select 2), _spawnpos, _rad] call _patrol;
    };
};
for "_i" from 0 to _anzahl_diver do {
    Private["_rad","_spawnpos"];
    _rad = ((random 200) + 100);
    _spawnpos = [_position,_radius,3] call EFUNC(common,pos_random);
    LOG_1(_spawnpos);
    If (!(_spawnpos isEqualTo [])) then {
        private["_einheiten","_bestpos","_return"];
        _einheiten = [];
        for "_j" from 0 to 3 do {
            _einheiten pushBack (dorb_diverlist SELRND)
        };
        _bestpos = (selectBestPlaces [_spawnpos, 15, "waterdepth", 2, 5]);
        LOG_1(_bestpos);
        CHECK(_bestpos isEqualTo [])
        _spawnpos = (_bestpos select 0) select 0;
        _spawnpos set[2,0];
        LOG_1(_spawnpos);
        if (dorb_debug) then {
            private "_mrkr";
            _mrkr = createMarker [format["navald-%1",_spawnpos],_spawnpos];
            _mrkr setMarkerShape "ICON";
            _mrkr setMarkerColor "ColorRed";
            _mrkr setMarkerType "n_inf";
        };
        _return = [_spawnpos,GVARMAIN(side),_einheiten] call BIS_fnc_spawnGroup;
        { _objects pushBack _x; } forEach (units _return);
        _vehicles pushBack (units _return);
        [_return, _spawnpos, _rad,-10] call _patrol;
        {_x swimInDepth -10} forEach (units _return);
        
    };
};

_objects
