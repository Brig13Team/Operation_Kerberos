/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"


/*
    Module Difficulty settings
*/
private _signalLoss = true; // Default true
private _fullDuplex = true; // Default False
private _interference = true; // Default true
private _ignoreAntennaDirection = false; // Default false

/*
    Module basic mission settings
*/
private _setupRadios = false; // Default False
private _setupBabel = 0; // 0=No Babel ; 1=Per-Side; 2=Per-Side w/Common
private _defaultRadios = [
    "ACRE_PRC343",
    "",
    "",
    ""
];


/*
    Channel Names
*/
["ACRE_PRC148", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC152", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;
["ACRE_PRC117F", "default", QGVAR(COOP)] call acre_api_fnc_copyPreset;

["ACRE_PRC152", QGVAR(COOP), 1, "description", "TRUPP 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 2, "description", "TRUPP 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 3, "description", "TRUPP 3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 4, "description", "TRUPP 4"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 5, "description", "TRUPP 5"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 6, "description", "OPZ"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 7, "description", "CAS 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 8, "description", "CAS 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 9, "description", "ARTILLERIE"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", QGVAR(COOP), 10, "description", "LOGISTIK"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC148", QGVAR(COOP), 1, "label", "TRUPP 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 2, "label", "TRUPP 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 3, "label", "TRUPP 3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 4, "label", "TRUPP 4"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 5, "label", "TRUPP 5"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 6, "label", "OPZ"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 7, "label", "CAS 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 8, "label", "CAS 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 9, "label", "ARTILLERIE"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", QGVAR(COOP), 10, "label", "LOGISTIK"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", QGVAR(COOP), 1, "name", "TRUPP 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 2, "name", "TRUPP 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 3, "name", "TRUPP 3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 4, "name", "TRUPP 4"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 5, "name", "TRUPP 5"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 6, "name", "OPZ"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 7, "name", "CAS 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 8, "name", "CAS 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 9, "name", "ARTILLERIE"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", QGVAR(COOP), 10, "name", "LOGISTIK"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC152", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC148", QGVAR(COOP)] call acre_api_fnc_setPreset;
["ACRE_PRC117F", QGVAR(COOP)] call acre_api_fnc_setPreset;






/*
    Translate Variables to ACRE
*/
if(!_signalLoss) then {
	[0.0] call acre_api_fnc_setLossModelScale;
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
        [_unit, "ItemRadio"] call EFUNC(lib,removeGear);
        [_unit, "ACRE_PRC343"] call EFUNC(lib,removeGear);
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
        TRACE_1("", _radioType);

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
