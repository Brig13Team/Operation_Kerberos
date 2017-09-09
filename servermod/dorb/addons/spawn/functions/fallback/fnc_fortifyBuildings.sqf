/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn statics and patrol Groups inside buldings
 *
 *  Parameter(s):
 *      0 : ARRAY - Centerposition
 *      1 : SCALAR - radius
 *      2 : SCALAR - Amount of houses
 *      3 : SCALAR - amount of cars in garages
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    ["_centerPosition",0,[0]],
    ["_radius",200,[0]],
    ["_amountDefHouses",0,[0]],
    ["_civilianCars",-1,[0]]
];

private _allHouses = _centerPosition nearObjects ["House", _radius];
_allHouses = _allHouses - (missionNamespace getVariable [QEGVAR(composition,targetHouses),[]]);
_allHouses = _allHouses - (missionNamespace getVariable [QEGVAR(composition,usedHouses),[]]);

_allGarages = _allHouses select {(typeOf _x) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]};
_allHouses = _allHouses - _allGarages;

If (_civilianCars < 0) then {
    _civilianCars = floor(((count _garages)-1)/3);
};

_allGarages = _allGarages call BIS_fnc_arrayShuffle;
while {(_civilianCars > 0)&&(count _allGarages > 0)} do {
    private _curGarage = _allGarages deleteAt 0;
    private _unittype = ["civcar"] call FUNC(getUnit);
    private _spawndir = getDir _curGarage;
    private _spawnpos = getPosATL _curGarage;
    _spawnpos set [2,(_spawnpos select 2) + 0.5];
    private _veh = createVehicle [_unittype,[0,0,0],[],0,"CAN_COLLIDE"];
    _veh setPosATL _spawnpos;
    #ifdef DEBUG_MODE_FULL
        [_spawnpos,"Garage","ColorCivilian"] call EFUNC(common,debug_marker_create);
    #endif
    DEC(_civilianCars);
};

_allHouses = _allHouses call BIS_fnc_arrayShuffle;


while {(_amountDefHouses > 0)&&(count _allHouses > 0)} do {
    private _curHouse = _allHouses deleteAt 0;
    private _curType = typeOf _curHouse;
    private _housePos = getPos _curHouse;
    If (isClass(ConfigFile >> "CfgKerberos" >> "CfgCompositions" >> "housepositions" >> _curType)) then {
        private _soldierPositions = getArray(ConfigFile >> "CfgKerberos" >> "CfgCompositions" >> "housepositions" >> _curType >> "soldierpos");
        if (count _soldierPositions > 3) then {
            _soldierPositions = _soldierPositions call BIS_fnc_arrayShuffle;
            _soldierPositions resize 3;
        };
        private _tempStaticPos = [];
        private _tempSoldierPos = [];
        {
            _x params ["_xpos","_ypos","_zpos","_rad1","_rad2","_type"];
            private _spawnpos = _housePos vectorAdd [_xpos,_ypos,_zpos];
            private _dir = random(360);
            If (_rad2 >0) then {
                private _dir = random(_rad2 - _rad1) + _rad1;
            }else{
                If (_rad1>0) then {_dir = _rad1;};
            };
            _spawnpos pushBack _dir;
            If ((_type == 1)||(_type == 3)) then {
                _tempStaticPos pushBack _spawnpos;
            }else{
                _tempStaticPos pushBack _spawnpos;
            };
        } forEach _soldierPositions;
        EGVAR(composition,usedHouses) pushBack _curHouse;
        [_tempStaticPos] call FUNC(fallback_spawnStatic);
        [_tempSoldierPos] call FUNC(fallback_spawnUnit);
        DEC(_amountDefHouses);
    };
};
