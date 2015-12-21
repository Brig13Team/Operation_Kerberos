/*
    Author: Dorbedo

    Description:
        spawns predefines defence-Makros

    Parameter(s):
        0 :    ARRAY    - Centerpos
        1 : SCALAR     - Radius
        2 : SCALAR    - Number of spawned positions


    Returns:
    ARRAY : Array with Positions

    
    
    Limitations: it can happen that the direction of the makro is turned onto a hill, if the gradient of the terrain behind the hill is high.
    
    
    
*/
#include "script_component.hpp"
SCRIPT(defence_macros);
_this params[["_position",[],[[]],[2,3]],["_radius",1000,[0]],["_anzahl_spawnpos",3,[0]],["_isTown",false,[true]]];


private _searchrad = 150 min (_radius/4);


//// Random Positions -> moved to open Area
//// If not enaugh positions are found, the amount of spawned macros is reduced
private _all_spawnpos = [];
private _errorcounter = 0;

while {(count _all_spawnpos)<_anzahl_spawnpos} do {
    private ["_currentPosition"];
    If (_isTown) then {
        _currentPosition = [_position,( ( floor(random( abs(_radius - 300) )) ) + 300),parseNumber _isTown] call EFUNC(common,pos_random);
    }else{
        _currentPosition = [_position,_radius,parseNumber _isTown] call EFUNC(common,pos_random);
    };
    
    private _spawnpos = [_currentPosition,15,_searchrad,15,0.18] call EFUNC(common,pos_flatempty);
    
    If (_spawnpos isEqualTo []) then {
        _spawnpos = [_currentPosition,15,_searchrad,15,0.3] call EFUNC(common,pos_flatempty);
    };
    
    If (!(_spawnpos isEqualTo [])) then {
        private _addpos = true;
        for "_j" from 0 to ((count _all_spawnpos)-1) do {
            if (((_all_spawnpos select _j)distance2D _spawnpos)<30) then {
                _addpos = false;
            };
        };
        if (_addpos) then {
            _all_spawnpos pushBack _spawnpos;
        };
    };
    INC(_errorcounter);
    CHECK(_errorcounter>(100 + _anzahl_spawnpos))
};


//// Get the macros
private _config = (missionconfigfile>>"defence_positions">>str GVARMAIN(side)>>"terrain");
private _makros = [];
for "_i" from 0 to (count _config)-1 do {
    _makros pushBack [configname (_config select _i),getNumber((_config select _i)>>"probability")];
};

///// spawns makros in the best direction
{
    /// Get gooddirs -> good sight from the defined pos
    private _gooddirs = [];
    private "_i";
    for [{_i= 1},{_i <= 360},{_i = _i + 10}] do {
        private _defencepos = _x;
        _defencepos set [2,((_defencepos select 2)+0.9)];
        private _aimpos = [_x, 450, 50] call BIS_fnc_relPos;
        //_aimpos set[2,(_defencepos select 2)];
        private _isgooddir = terrainIntersect[_defencepos,_aimpos];
        If (!_isgooddir) then {
            _gooddirs pushBack _i;
        };
    };
    
    /// choose the best dir
    
    private _bestdir = -1;
    private _bestdir_level = 0;
    private _defencepos = ATLtoASL _x;
    for "_j" from 0 to ((count _gooddirs)-1) do {
        private _templevel = 0;
        for [{_k= 1},{_k <= 450},{_k = _k + 20}] do {
            _aimpos = [_x, _k, (_gooddirs select _j)] call BIS_fnc_relPos;
            _aimpos = ATLtoASL _aimpos;
            private _differenz = ((_defencepos select 2)-(_aimpos select 2));
            _currentlevel = _differenz * ((floor((23-(_k/20))/3))max 0.2);
            _templevel = _templevel + _currentlevel;
        };
        If (_templevel > _bestdir_level) then {
            _bestdir = (_gooddirs select _j);
            _bestdir_level = _templevel;
        };
    };
    
    
    // If there is no bestdir (because of terrain) -> randomize
    
    If (_bestdir < 0) then {_bestdir = random 360;};
    
    
    /// debug
    #ifdef DEBUG_MODE_FULL
        [_x,format["defencepos-%1",_x],"ColorBlue","mil_arrow2",_bestdir] call EFUNC(common,debug_marker_create);
    #endif

    ///// spawn defence
    private _currentmakro = (([_makros,1] call EFUNC(common,sel_array_weighted))select 0);
	TRACEV_2(_makros,_currentmakro);
    private _configarray = ["missionConfigFile","defence_positions",str GVARMAIN(side),"terrain",format["%1",_currentmakro]];
    
    [_x,_configarray,_bestdir] call FUNC(macro_exec3d);
    
}forEach  _all_spawnpos;

true
