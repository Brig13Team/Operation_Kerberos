/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _fnc_addRadioVal = {
    _this params ["_missionHash"];
    _radioType = HASH_GET(_missionHash,"radioType");
    private _radioname = getText(configfile >> "CfgWeapons" >> _radioType >> "displayName");
    HASH_SET(_missionHash,"radioName",_radioname);
    private _pic = getText(configfile >> "CfgWeapons" >> _radioType >> "picture");
    //HASH_SET(_missionHash,"presetChannel",_channel);
    HASH_SET(_missionHash,"picture",_pic);
};

private _radio = ["ACRE_PRC148",1] call EFUNC(gui_acre,setFilteredPresetChannel);
[_radio] call _fnc_addRadioVal;
private _radio2 = ["ACRE_PRC343",1] call EFUNC(gui_acre,setFilteredPresetChannel);
[_radio2] call _fnc_addRadioVal;
private _radio3 = ["ACRE_SEM52SL",1] call EFUNC(gui_acre,setFilteredPresetChannel);
[_radio3] call _fnc_addRadioVal;
private _radios = [_radio,_radio2,_radio3];
private _group = (group player);
HASH_SET(_group,QEGVAR(gui_acre,radios),_radios);

private _radio = ["ACRE_PRC152",2] call EFUNC(gui_acre,setFilteredPresetChannel);
[_radio] call _fnc_addRadioVal;
private _radio2 = ["ACRE_PRC117F",3] call EFUNC(gui_acre,setFilteredPresetChannel);
[_radio2] call _fnc_addRadioVal;
HASH_SET(_radio2,"frequencyrx",95);
private _radios = [_radio,_radio2];
HASH_SET(player,QEGVAR(gui_acre,radios),_radios);
