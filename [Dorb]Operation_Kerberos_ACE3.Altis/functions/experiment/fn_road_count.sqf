_road=_this select 0;
_roadConnectedTo = roadsConnectedTo _road;
_anzahl=count _roadConnectedTo;

_mrkr = createMarker [format ["Testzahl_%1",_road],(getPos _road)];
_mrkr setMarkerShape "ICON";
_mrkr setMarkerType "hd_dot";
_mrkr setMarkerColor "ColorWhite";
_mrkr setMarkerText format["%1:%2",_anzahl,_road];