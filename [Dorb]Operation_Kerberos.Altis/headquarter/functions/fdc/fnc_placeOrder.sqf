/*
    Author: Dorbedo

    Description:
        places an artillery order

    Parameter(s):
        0 : ARRAY   - Position / Start Position
        1 : SCALAR  - Type AUTO=-1 , ARTY = 0 , MORTAR = 1 , ROCKET = 2
        2 : SCALAR  - Amount (might be overwritten by MODE)
        (optional)
        3 : ARRAY   - ["MODE",[Parameter]]
                    * ["creeping",direction,range,size in m (200m Standard)]
                    * ["smoke"]
                    * ["flare"]
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_attackpos",[],[[]],[2,3]],["_type",-1,[0]],["_amount",-1,[0]],["_modearray",[],[[]]]];
//TRACEV_4(_attackpos,_type,_amount,_modearray);
If (_attackpos isEqualTo []) exitWith {false};
private _cancel = false;

If ((count _attackpos)<2) then {
    _attackpos pushBack 0;
};

If (!(_modearray isEqualTo [])) then {
    _cancel=true;
    _modearray params [["_mode","",[""]],["_direction",-1,[2]],["_range",100,[0]],["_size",200,[0]]];
    TRACEV_4(_mode,_direction,_range,_size);
    switch (_mode) do {
        case "creeping" : {
                            CHECK(_direction < 0)
                            private ["_side_shots","_direction_shots","_temp_center","_positions_array"];
                            _side_shots = (floor((_size/2)/CREEPING_DISTANCE))min 2;
                            _direction_shots = (floor((_range)/CREEPING_DISTANCE))min 6;
                            _positions_array = [];
                            _temp_center = _attackpos;
                            //TRACEV_4(_side_shots,_direction_shots,_positions_array,_temp_center);
                            for "_i" from 0 to _direction_shots do {
                                _positions_array pushBack _temp_center;
                                for "_j" from 1 to _side_shots do {
                                    _positions_array pushBack ([_temp_center,CREEPING_DISTANCE*_j,(_direction+90)] call BIS_fnc_relPos);
                                    _positions_array pushBack ([_temp_center,CREEPING_DISTANCE*_j,(_direction+270)] call BIS_fnc_relPos);
                                };
                                _temp_center = [_attackpos,CREEPING_DISTANCE*(_i+1),_direction] call BIS_fnc_relPos;
                            };
                            //TRACEV_1(_positions_array);
                            {
                                [_x,_type,1] call FUNC(fdc_placeOrder);
                            }forEach _positions_array;
                        };
        case "smoke" : {
                            HASH_GET(GVAR(FDC),"firemissions") pushBack [_attackpos,_type,"Smoke_120mm_AMOS_White",_amount];
                        };
        case "flare" : {
                            HASH_GET(GVAR(FDC),"firemissions") pushBack [_attackpos,1,"Flare_82mm_AMOS_White",_amount];
                        };
    };
};
private ["_shelltype","_unit"];
if(_cancel) exitWith {false};
_cancel = switch (_type) do {
    default {true;};
    case -1 : {
                _type = [];
                If !(HASH_GET(GVAR(FDC),"artilleries") isEqualTo []) then {_type pushBack 0;};
                If !(HASH_GET(GVAR(FDC),"mortars") isEqualTo []) then {_type pushBack 1;};
                If !(HASH_GET(GVAR(FDC),"rockets") isEqualTo []) then {_type pushBack 2;};
                If (_type isEqualTo []) exitWith {true};
                [_attackpos,selectRandom _type,-1] call FUNC(fdc_placeOrder);
                true;
            };
    case 0 : {
                If (HASH_GET(GVAR(FDC),"artilleries") isEqualTo []) exitWith {true};
                _unit = selectRandom (HASH_GET(GVAR(FDC),"artilleries"));
                private _shellArray = getArtilleryAmmo [_unit];
                If (_shellArray isEqualTo []) exitWith {_cancel = true;};
                _shelltype = (_shellArray select 0);
                If (_amount < 0) then {_amount = 6;};
                false;
            };
    case 1 : {
                If (HASH_GET(GVAR(FDC),"mortars") isEqualTo []) exitWith {true};
                _unit = selectRandom (HASH_GET(GVAR(FDC),"mortars"));
                private _shellArray = getArtilleryAmmo [_unit];
                If (_shellArray isEqualTo []) exitWith {_cancel = true;};
                _shelltype = (_shellArray select 0);
                If (_amount < 0) then {_amount = 3;};
                false;
            };
    case 2 : {
                If (HASH_GET(GVAR(FDC),"rockets") isEqualTo []) exitWith {true};
                _unit = selectRandom (HASH_GET(GVAR(FDC),"rockets"));
                private _shellArray = getArtilleryAmmo [_unit];
                If (_shellArray isEqualTo []) exitWith {_cancel = true;};
                _shelltype = (_shellArray select 0);
                If (_amount < 1) then {
                    private _ammo = getText(configFile>>"CfgMagazines">> _shelltype >> "ammo");
                    private _submun = getText(configFile>>"CfgAmmo">>_ammo>>"submunitionAmmo");
                    private _strength = getNumber(configFile>>"CfgAmmo">>_submun>>"hit");
                    _amount = floor(3000/(_strength)) min 1;
                };
                false;
            };
};

TRACEV_5(_cancel,_attackpos,_type,_shelltype,_amount);
if (_cancel) exitWith {false};
HASH_GET(GVAR(FDC),"firemissions") pushBack [_attackpos,_type,_shelltype,_amount];
true
