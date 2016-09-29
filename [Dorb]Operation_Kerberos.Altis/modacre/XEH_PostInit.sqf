/*
 * Author: Dorbedo
 *
 */
#include "script_component.hpp"

/*
    Module Difficulty settings
*/
private _signalLoss = true; // Default true
private _signalLoss_Value = 0.5; // Default 1 -> no effect if signalloss = false
private _fullDuplex = true; // Default False
private _interference = true; // Default true
private _ignoreAntennaDirection = true; // Default false

/*
    Module basic mission settings
*/
private _setupRadios = false; // Default False
private _setupBabel = 0; // 0=No Babel ; 1=Per-Side; 2=Per-Side w/Common
private _defaultRadios = [
    "",
    "",
    "",
    ""
];


/*
    Channel Names
*/

private _channelnamen = [
    "BODEN",
    "OPZ",
    "LOGISTIK",
    "CAS/FDC",
    "TRUPP 1",
    "TRUPP 2",
    "TRUPP 3",
    "TRUPP 4",
    "TRUPP 5",
    "TRUPP 6"
];

["ACRE_PRC148", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC152", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC117F", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;

{
    private _name = If (isLocalized _x) then {localize _x}else{format ["%1",_x]};
    ["ACRE_PRC152", QGVAR(COOP), (_forEachIndex + 1), "description",_name] call acre_api_fnc_setPresetChannelField;
    ["ACRE_PRC148", QGVAR(COOP), (_forEachIndex + 1), "label",_name] call acre_api_fnc_setPresetChannelField;
    ["ACRE_PRC117F", QGVAR(COOP), (_forEachIndex + 1), "name",_name] call acre_api_fnc_setPresetChannelField;
} forEach _channelnamen;

["ACRE_PRC152", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC148", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC117F", QGVAR(COOP)] call acre_api_fnc_setPreset;




/*
    Translate Variables to ACRE
*/
if(!_signalLoss) then {
	[0.0] call acre_api_fnc_setLossModelScale;
}else{
    [_signalLoss_Value] call acre_api_fnc_setLossModelScale;
};
if(_fullDuplex) then {
	[true] call acre_api_fnc_setFullDuplex;
};
if(!_interference) then {
	[false] call acre_api_fnc_setInterference;
};
if(_ignoreAntennaDirection) then {
	[true] call acre_api_fnc_ignoreAntennaDirection;
};


/*
    Mission Modules
*/
switch (_setupBabel) do {
	//We don't want the babel system
    case 0: {
    	[false, _setupRadios] call acre_api_fnc_setupMission;
    };
    //We want the babel system to be set to one language per side
    case 1: {
    	[true, _setupRadios] call acre_api_fnc_setupMission;
    };
    //We need to handle the babel setup via an array, so the bool is set to false
    //Zeus gets ALL Languages, including "Common"
    case 2: {
    	[false, _setupRadios] call acre_api_fnc_setupMission;
    	[
    		[east, "Opfor", "Common"],
    		[west, "Blufor", "Common"],
    		[independent, "Indepedent", "Common"],
    		[civilian, "Civilian", "Common"],
    		[sideLogic, "Opfor", "Blufor", "Indepedent", "Civilian", "Common"]
    	] call acre_api_fnc_babelSetupMission;
    };
    //This shouldn't be reached.
    default {
		[false, _setupRadios] call acre_api_fnc_setupMission;
    };
};
FUNC(ACRE_fnc_addRadios) = {
    private _unit = acre_player;
    private _cleanRadioList = [];
    if(!("ACRE_PRC343" in _this) ) then {
        [_unit, "ItemRadio"] call acre_lib_fnc_removeGear;
        [_unit, "ACRE_PRC343"] call acre_lib_fnc_removeGear;
        _cleanRadioList = _this;
    } else {
        private _countDefaultRadios = 0;
        {
            if(_x == "ACRE_PRC343") then {
                _countDefaultRadios = _countDefaultRadios + 1;
                if(_countDefaultRadios > 1) then {
                    _cleanRadioList pushBack _x;
                };
            } else {
                _cleanRadioList pushBack _x;
            };
        } forEach _this;

    };
    if( ("ACRE_PRC77" in _cleanRadioList) || ("ACRE_PRC117F" in _cleanRadioList) ) then {
        if( (backpack _unit) == "") then {
            _unit addBackpack "B_AssaultPack_khk";
        };
    };
    {
        private _radioType = _x;

        if(!isNil "_radioType") then {
            if(_radioType != "") then {
                _unit addItem _radioType;
            };
        };
    } forEach _cleanRadioList;
};



if(hasInterface) then {
	if(isNull acre_player) then {
		_defaultRadios spawn {
			waituntil { !isNull acre_player };
			_this call FUNC(ACRE_fnc_addRadios);
		};
	} else {
		_defaultRadios call FUNC(ACRE_fnc_addRadios);
	};
};
