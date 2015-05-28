
_road=_this select 0;



_roadConnectedTo = roadsConnectedTo _road;
_connectedRoad = _roadConnectedTo select 0;
//_direction = [_road, _connectedRoad] call BIS_fnc_DirTo;

_vector= (getPos _road)vectorFromTo(getPos _connectedRoad);
_rotateVector = [_vector,90] call BIS_fnc_rotateVector2D;
_normVector = vectorNormalized _rotateVector;


_mrkr = createMarker [format ["Test_%1",_road],(getPos _road)];
_mrkr setMarkerShape "ICON";
_mrkr setMarkerType "hd_dot";
_mrkr setMarkerColor "ColorWhite";
c=0;
b=true;
 for [{_i = 0},{_i < 150 && b},{_i = _i + 1}] do {
	_multiplyVector = _rotateVector vectorMultiply ((0.1*_i));
	_checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0];
	if ((surfaceType _checkpos)!="#GdtSoil") then {_mrkr setMarkerText format["%1",(0.1*_i)];b=false;c=_i;};
};

if (((c*0.1)) > 5) exitWith {_mrkr setMarkerColor "ColorRed";};
if (((c*0.1)) > 3) exitWith {_mrkr setMarkerColor "ColorOrange";};
if (c > 0) exitWith {_mrkr setMarkerColor "ColorYellow";};
/*
if (((c*0.1)) > 8) exitWith {_mrkr setMarkerColor "ColorRed";};
if (((c*0.1)) > 7) exitWith {_mrkr setMarkerColor "ColorPink";};
if (((c*0.1)) > 6) exitWith {_mrkr setMarkerColor "ColorOrange";};
if (((c*0.1)) > 5) exitWith {_mrkr setMarkerColor "ColorYellow";};
if (((c*0.1)) > 4) exitWith {_mrkr setMarkerColor "ColorGreen";};
if (((c*0.1)) > 3) exitWith {_mrkr setMarkerColor "ColorGUER";};
if (c > 0) exitWith {_mrkr setMarkerColor "ColorWhite";};
*/
//_text = surfaceType (getPos _road);
//_mrkr setMarkerText format["%1",_text];

/*

_multiplyVector = _rotateVector vectorMultiply (6.5);
_checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0];
if ((surfaceType _checkpos)=="#GdtSoil") exitWith {_mrkr setMarkerColor "ColorRed";};

_multiplyVector = _rotateVector vectorMultiply (4);
_checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0];
if ((surfaceType _checkpos)=="#GdtSoil") exitWith {_mrkr setMarkerColor "ColorYellow";};

if ((surfaceType _checkpos)!="#GdtSoil") exitWith {_mrkr setMarkerColor "ColorGreen";};

*/



if (true) exitWith {};

for "_i" from 0 to 100 do {
_multiplyVector = _rotateVector vectorMultiply (2+(0.1*_i));
_markerpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0];
_text = surfaceType _markerpos;


if (dorb_debug) then {
		
		if (_text == "#GdtSoil") then {
		
		_mrkr = createMarker [format ["Test1_%1_%2",_road,_i],_markerpos];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerType "hd_dot";
		
		_mrkr setMarkerColor "ColorWhite";
		_mrkr setMarkerText format["%1",_i];
		
		};
		/*
		if (_text == "#GdtSoil") then {
			_mrkr setMarkerColor "ColorPink";
		}else{
			if (_text == "#GdtDirt") then {
				_mrkr setMarkerColor "ColorBrown";		
			}else {
				_mrkr setMarkerColor "ColorWhite";
				_mrkr setMarkerText format["%1",_text];
			};
		};
		*/
		/*
		_mrkr = createMarker [format ["Test2",_road],(getPos _road)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorGreen";
		_mrkr setMarkerType "hd_dot";	
		
		_mrkr = createMarker [format ["Test3",_road],(getPos _connectedRoad)];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorOrange";
		_mrkr setMarkerType "hd_dot";	
		*/
};

};