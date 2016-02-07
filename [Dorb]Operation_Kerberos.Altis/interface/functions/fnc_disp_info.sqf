/*
    Author: Dorbedo
    
    Description:
        Displays an Info text
         - Picture with or without background
         - title
         - up to 7 rows of content
    
    
    Parameter(s):
        0 : STRING    - Example
        1 : ARRAY/ ARRAY OF STRINGS    - Content
        2 : STRING    - Picturepath
        3 : BOOL        - Bakcground for Picture
    

*/
#include "script_component.hpp"
CHECK(!hasInterface)
#define DISP_LAYER 700106
#define FONT_CORRECTION_CAPITAL 17
#define FONT_CORRECTION_LOWER 5.7
_this params[["_title","",[""]],["_content","",["",[]]],["_icon","",[""]],["_body",true,[false]]];

If(IS_STRING(_content)) then {_content = [_content];};
DISP_LAYER cutRsc [QGVAR(disp_info),"PLAIN"];
disableSerialization;
Private _disp = uiNamespace getvariable QGVAR(disp_info);
CHECK(isnil "_disp");

Private _iconCtrl = _disp displayCtrl 700108;
Private _iconbodyCtrl = _disp displayCtrl 700107;
if (_icon != "") then {
    _iconCtrl ctrlSetText _icon;
    _iconCtrl ctrlCommit 0;
}else{
    _iconCtrl ctrlSetPosition [0,0,0,0];
    _iconCtrl ctrlCommit 0;
    _body = false;
};

if (!(_body)) then {
    _iconbodyCtrl ctrlSetPosition [0,0,0,0];
    _iconbodyCtrl ctrlCommit 0;
};

Private _contentArray = [_title];

For "_i" from 0 to 7 do {
    private "_temp";
    If (_i > (count _content)) then {
        _contentArray pushBack "";
    }else{
        _contentArray pushBack (_content select _i);
    };
};

{
    If (islocalized _x) then {_text = localize _x;}else{_text = _x;};
    Private _ctrl = _disp displayCtrl (700109+_forEachIndex);
    _ctrl ctrlSetText _text;
    Private _chars = count(_text);
    Private _size = 0;
    If (_chars>0) then {
        private["_chars_capital","_chars_array"];
        _chars_array = toArray _text;
        _chars_capital = {If ((_x>=65)&&(_x<=90)) then {true}else{false};} count _chars_array;
        _size = ((((safeZoneW min safeZoneH)*0.9)*((ctrlTextHeight _ctrl)/FONT_CORRECTION_CAPITAL))*_chars_capital + 0.012)+((((safeZoneW min safeZoneH)*0.9)*((ctrlTextHeight _ctrl)/FONT_CORRECTION_LOWER))*_chars + 0.012);
    };
    Private _pos = ctrlPosition _ctrl;
    _pos set [2, _size];
    _ctrl ctrlSetPosition _pos;
    _ctrl ctrlCommit 0;
}forEach _contentArray;