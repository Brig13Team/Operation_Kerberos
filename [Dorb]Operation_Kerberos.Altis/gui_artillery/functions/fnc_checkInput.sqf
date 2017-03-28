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
#define INCLUDE_GUI
#include "script_component.hpp"

private _return = true;

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];

private _isModified = _display getVariable ["ismodified",true];

private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_LOCATION;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_EAST;
private _value = ctrlText _ctrl;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};

private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_LOCATION_EAST;
If ((parseNumber _value) isEqualTo 0) then {
    _ctrlText ctrlSetTextColor [RAL3024,1];
    _return = false;
}else{
    _ctrlText ctrlSetTextColor [RAL9010,1];
};

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_NORTH;
private _value = ctrlText _ctrl;
private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_LOCATION_NORTH;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
If ((parseNumber _value) isEqualTo 0) then {
    _ctrlText ctrlSetTextColor [RAL3024,1];
    _return = false;
}else{
    _ctrlText ctrlSetTextColor [RAL9010,1];
};

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_LOCATION_ALT;
private _value = ctrlText _ctrl;
private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_LOCATION_ALT;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
If ((parseNumber _value) isEqualTo 0) then {
    _ctrlText ctrlSetTextColor [RAL3024,1];
    _return = false;
}else{
    _ctrlText ctrlSetTextColor [RAL9010,1];
};



private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_PARAMS;
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_MILS;
private _value = ctrlText _ctrl;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_PARAMS_MILS;
private _number = parseNumber _value;
If ((_number isEqualTo 0)||{_number < 0}||{_number > 6400}) then {
    _ctrlText ctrlSetTextColor [RAL3024,1];
    _return = false;
}else{
    _ctrlText ctrlSetTextColor [RAL9010,1];
};

private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_ELEVATION;
private _value = ctrlText _ctrl;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_PARAMS_ELEVATION;
private _number = parseNumber _value;
If !((_number > 0)&&{_number <= 80}) then {
    _ctrlText ctrlSetTextColor [RAL3024,1];
    _return = false;
}else{
    _ctrlText ctrlSetTextColor [RAL9010,1];
};



private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_TTS;
private _value = ctrlText _ctrl;
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
private _ctrlText = _ctrlGrp controlsGroupCtrl -IDC_ARTILLERY_PARAMS_TTS;
//TRACEV_2(_ctrl,_value);
If (_value isEqualTo "") then {
    _ctrlText ctrlSetTextColor [RAL9010,1];
}else{
    private _valArray = _value splitString "-";
    private _number1 = (toArray(_valArray select 0));
    private _number2 = parseNumber (_valArray select 1);
    //TRACEV_3(_valArray,_number1,_number2);
    switch (true) do {
        // not 0000-00
        case (!((count _valArray) isEqualTo 2));
        // not 0000
        case (isNil "_number2");
        case (!((count _number1) isEqualTo 4)) : {
            _ctrlText ctrlSetTextColor [RAL3024,1];
            _return = false;
        };
        // *000
        case (((_number1 select 0)<48)||((_number1 select 0)>50));
        // 0*00
        case (((_number1 select 1)<48)||((_number1 select 1)>57));
        // **00
        case (((_number1 select 0) isEqualTo 50)&&{(_number1 select 1)>51});
        // 00*0
        case (((_number1 select 2)<48)||((_number1 select 2)>53));
        // 000*
        case (((_number1 select 3)<48)||((_number1 select 3)>57));
        // 0000-**
        case !(((_number2 > 0)&&{_number2 < 60})||{((_valArray select 1) isEqualTo "00")}) : {
            _ctrlText ctrlSetTextColor [RAL3024,1];
            _return = false;
        };
        default {_ctrlText ctrlSetTextColor [RAL9010,1];};
    };
};



private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
private _value = _ctrl lbData (lbCurSel _ctrl);
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
private _value = _ctrl lbValue (lbCurSel _ctrl);
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};
private _ctrl = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_FUZE;
private _value = _ctrl lbValue (lbCurSel _ctrl);
If !(_value isEqualTo (_ctrl getVariable ["lastValue",""])) then {
    _ctrl setVariable ["lastValue",_value];
    _isModified = true;
};



If (_isModified) then {
    TRACE("Modified");
    _display setVariable ["ismodified",true];
}else{
    TRACE("NOT Modified");
};

_return;
