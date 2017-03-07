/*
    Author: Dorbedo

    called via:
        [(getPos player),25,(getDir player)] execVM "fnc_export_obj_sqf.sqf";
        [player,25] execVM "fnc_export_obj_sqf.sqf";
        [cursorTarget,25] execVM "fnc_export_obj_sqf.sqf";


    class map {
        class 11_12 {
            surface = 0; // (0:water ; 1:land ; 2:road);
            XP = 0;
            XM = 0;
            YP = 0;
            YM = 0;
            XPYP = 0;
            XMYP = 0;
            XPYM = 0;
            XMYM = 0;
        };
    };
*/
hint "Export in progess....";

#define RASTER 300
#define RASTER_2 floor(RASTER/2)
#define ROADDISTANCE floor(RASTER/3)
#define TERRAINDISTANCE floor(RASTER/3)

private ["_positions"];
_positions = [];

for "_i" from 0 to (worldsize - RASTER_2) step RASTER do {
    private "_temp";
    for "_j" from 0 to (worldsize - RASTER_2) step RASTER do {
        private ["_nearestRoad","_nearestPos","_surface"];
        _temp = [_j + RASTER_2, _i + RASTER_2, 0];
        _surface = 0;
        //if !(surfaceisWater _temp) then {
            _nearestRoad = [_temp,ROADDISTANCE,[]] call BIS_fnc_nearestRoad;
            If (!isNull _nearestRoad) then {
                _temp = getPosATL _nearestRoad;
                _surface = 2;
            }else{
                _nearestPos = _temp isFlatEmpty [15,TERRAINDISTANCE,0.7,30,0,false];
                If !(_nearestPos isEqualTo []) then {
                    _temp = _nearestPos;
                    _surface = 1;
                };
                /*_nearestPos = selectBestPlaces [_temp,TERRAINDISTANCE,"meadow",30,1];
                If (((_nearestPos select 0) isEqualType [])&&{!(((_nearestPos select 0)select 0) isEqualTo [])}) then {
                    _temp = ((_nearestPos select 0)select 0);
                    _temp pushBack 0;
                };
                */

            };
        //};
        //[_temp,"","ColorBlue"] call dorb_common_fnc_debug_marker_create;
        _positions pushBack [format["%1_%2",floor(_j/10),floor(_i/10)],_temp,_surface, -1,-1,-1,-1, -1,-1,-1,-1];
    };
    [_temp,"","ColorBlue"] call dorb_common_fnc_debug_marker_create;
};

hint "valuing";

#define RoadDistanceFaktor -15
#define correctionMulti 10
private ["_count","_side"];

_count = count _positions;
_side = sqrt(_count);

{
    _x params ["_key","_pos","_surface","_XP","_XM","_YP","_YM","_XPYP","_XMYP","_XPYM","_XMYM"];
    private ["_differenz","_keyArray","_keyX","_keyY","_temp","_parameter","_distance"];
    _keyArray = _key splitString "_";
    _differenz = floor(RASTER/10);
    _keyX = parseNumber (_keyArray select 0);
    _keyY = parseNumber (_keyArray select 1);
    If (_XP < 0) then {
        _XP = 0;
        _temp = _forEachIndex + 1;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXM = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXM = 0;
            }else{
                If (_surface == 2) then {_XP = RoadDistanceFaktor;};
                If (_tsurface == 2) then {_tXM = RoadDistanceFaktor;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XP = floor((_XP + _distance + _height + _tXM)*correctionMulti);
                _tXM = _XP;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_XM < 0) then {
        _XM = 0;
        _temp = _forEachIndex - 1;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXP = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXP = 0;
            }else{
                If (_surface == 2) then {_XM = RoadDistanceFaktor;};
                If (_tsurface == 2) then {_tXP = RoadDistanceFaktor;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XM = floor((_XM + _distance + _height + _tXP)*correctionMulti);
                _tXP = _XM;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_YP < 0) then {
        _YP = 0;
        _temp = _forEachIndex + _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tYM = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tYM = 0;
            }else{
                If (_surface == 2) then {_YP = RoadDistanceFaktor;};
                If (_tsurface == 2) then {_tYM = RoadDistanceFaktor;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _YP = floor((_YP + _distance + _height + _tYM)*correctionMulti);
                _tYM = _YP;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_YM < 0) then {
        _YM = 0;
        _temp = _forEachIndex - _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tYP = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tYP = 0;
            }else{
                If (_surface == 2) then {_YM = RoadDistanceFaktor;};
                If (_tsurface == 2) then {_tYP = RoadDistanceFaktor;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _YM = floor((_YM + _distance + _height + _tYP)*correctionMulti);
                _tYP = _YM;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };


    If (_XPYP < 0) then {
        _XPYP = 0;
        _temp = _forEachIndex + 1 + _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXMYM = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXMYM = 0;
            }else{
                If (_surface == 2) then {_XPYP = RoadDistanceFaktor * 1.4;};
                If (_tsurface == 2) then {_tXMYM = RoadDistanceFaktor * 1.4;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XPYP = floor((_XPYP + _distance + _height + _tXMYM)*correctionMulti);
                _tXMYM = _XPYP;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_XPYM < 0) then {
        _XPYM = 0;
        _temp = _forEachIndex + 1 - _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXMYP = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXMYP = 0;
            }else{
                If (_surface == 2) then {_XPYM = RoadDistanceFaktor * 1.4;};
                If (_tsurface == 2) then {_tXMYP = RoadDistanceFaktor * 1.4;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XPYM = floor((_XPYM + _distance + _height + _tXMYP)*correctionMulti);
                _tXMYP = _XPYM;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_XMYP < 0) then {
        _XMYP = 0;
        _temp = _forEachIndex - 1 + _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXPYM = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXPYM = 0;
            }else{
                If (_surface == 2) then {_XMYP = RoadDistanceFaktor * 1.4;};
                If (_tsurface == 2) then {_tXPYM = RoadDistanceFaktor * 1.4;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XMYP = floor((_XMYP + _distance + _height + _tXPYM)*correctionMulti);
                _tXPYM = _XMYP;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    If (_XMYM < 0) then {
        _XMYM = 0;
        //_temp = [format["%1_%2",_keyX-_differenz,_keyY-_differenz]]call _getpos;
        _temp = _forEachIndex - 1 - _side;
        if ((_temp >= 0)&&(_temp < _count)) then {
            _parameter = _positions select _temp;
            _parameter params ["_tkey","_tpos","_tsurface","_tXP","_tXM","_tYP","_tYM","_tXPYP","_tXMYP","_tXPYM","_tXMYM"];
            _tXPYP = 0;
            if ((_surface == 0)||(_tsurface == 0)) then {
                _tXPYP = 0;
            }else{
                If (_surface == 2) then {_XMYM = RoadDistanceFaktor * 1.4;};
                If (_tsurface == 2) then {_tXPYP = RoadDistanceFaktor * 1.4;};
                _distance = _tpos distance2D _pos;
                _height = 1.5 * abs(((ATLtoASL _tpos) select 2) - ((ATLtoASL _pos) select 2));
                _XMYM = floor((_XMYM + _distance + _height + _tXPYP)*correctionMulti);
                _tXPYP = _XMYM;
            };
            _positions set [_temp,[_tkey,_tpos,_tsurface,_tXP,_tXM,_tYP,_tYM,_tXPYP,_tXMYP,_tXPYM,_tXMYM]];
        };
    };
    _positions set [_forEachIndex,[_key,_pos,_surface,_XP,_XM,_YP,_YM,_XPYP,_XMYP,_XPYM,_XMYM]];
} forEach _positions;


hint "copying.....";

_br = toString [0x0D, 0x0A];
_tab = "    "; // changed into spaces - toString[0x09];
_tab2 = _tab + _tab;

private _amount = count _positions;

_output = (format["class %1 {",worldname] + _br + format["raster=%1;",RASTER] + _br);
"ace_clipboard" callExtension _output;
{
    _output = format["class %1 {",_x select 0] +
    format["pos[]={%1,%2,%3};",(_x select 1)select 0,(_x select 1)select 1,(_x select 1)select 2] +
    (If ((_x select 3) == 0) then {""}else{format["S=%1;",_x select 2]}) +
    (If ((_x select 3) == 0) then {""}else{format["XP=%1;",_x select 3]}) +
    (If ((_x select 4) == 0) then {""}else{format["XM=%1;",_x select 4]}) +
    (If ((_x select 5) == 0) then {""}else{format["YP=%1;",_x select 5]}) +
    (If ((_x select 6) == 0) then {""}else{format["YM=%1;",_x select 6]}) +
    (If ((_x select 7) == 0) then {""}else{format["XPYP=%1;",_x select 7]}) +
    (If ((_x select 8) == 0) then {""}else{format["XMYP=%1;",_x select 8]}) +
    (If ((_x select 9) == 0) then {""}else{format["XPYM=%1;",_x select 9]}) +
    (If ((_x select 10) == 0) then {""}else{format["XMYM=%1;",_x select 10]}) +
    "};" + _br;
    "ace_clipboard" callExtension _output;
    hintsilent format["%1/%2",_forEachIndex,_amount];
}forEach _positions;
"ace_clipboard" callExtension "}; ";
uisleep 0.5;
"ace_clipboard" callExtension "--COMPLETE--";

hint "copied to clipboard";
/*
_output = format["class %1 {",worldname] + _br
+ _tab + format["raster = %1;",RASTER] + _br;
{
    _output = _output
    + _tab + format["class %1 {",_x select 0] + _br
    + _tab2 + format["position[] = {%1,%2,%3};",(_x select 1)select 0,(_x select 1)select 1,(_x select 1)select 2] + _br
    + _tab2 + format["surface = %1;",_x select 2] + _br
    + _tab2 + format["XP = %1;",_x select 3] + _br
    + _tab2 + format["XM = %1;",_x select 4] + _br
    + _tab2 + format["YP = %1;",_x select 5] + _br
    + _tab2 + format["YM = %1;",_x select 6] + _br
    + _tab2 + format["XPYP = %1;",_x select 7] + _br
    + _tab2 + format["XMYP = %1;",_x select 8] + _br
    + _tab2 + format["XPYM = %1;",_x select 9] + _br
    + _tab2 + format["XMYM = %1;",_x select 10] + _br
    + _tab + "};" + _br;
}forEach _positions;
_output = _output + "};";


copyToClipboard _output;
uisleep 3;
hint "copied to clipboard";
*/
