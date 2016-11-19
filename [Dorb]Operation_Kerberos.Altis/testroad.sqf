_this params ["_center"];

_list = (getPos _center) nearRoads 500;
dorb_debug = true;

_fnc_road_array = {

    private _road=_this SELECT 0;
    private _roadConnectedTo = roadsConnectedTo _road;
    if (_roadConnectedTo isEqualTo [])exitWith{[]};

    private _connectedRoad = _roadConnectedTo select 0;

    private _vector= (getPos _road) vectorFromTo (getPos _connectedRoad);

    private _rotateVector = [_vector,90] call BIS_fnc_rotateVector2D;
    private _normVector = vectorNormalized _rotateVector;
    private ["_checkpos","_c"];
    for [{_i = 1},{_i < 6},{_i = _i + 1}] do {
        private _multiplyVector = _rotateVector vectorMultiply ((2*_i));
        _checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0.1];
        _c=_i;
        if (!(isOnRoad _checkpos)) exitWith {};
    };

    private _mrkr = createMarker [format ["Test_%1",_road],(getPos _road)];
    _mrkr setMarkerShape "ICON";
    _mrkr setMarkerType "hd_dot";
    _mrkr setMarkerColor "ColorWhite";
    _mrkr setMarkerText format["%1",_checkpos distance2d (getPos _road)];

    _dir = [_road,_roadConnectedTo select 0] call BIS_fnc_dirTo;
    If (_c<=1) exitWith {[];}; //No road
    If (_c<3) exitWith {_mrkr setMarkerColor "ColorYellow";[getPosASL _road,_dir,0];}; // tiny road
    If (_c<4) exitWith {_mrkr setMarkerColor "ColorOrange";[getPosASL _road,_dir,1];}; // small road
    _mrkr setMarkerColor "ColorRed";
    [getPosASL _road,_dir,2]; // big road
};



{
	[_x] call _fnc_road_array;
}forEach _list;
