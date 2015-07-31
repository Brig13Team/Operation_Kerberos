/*
    Author: Dorbedo

    Description:
        Diagnosefunktion um Performance-Probleme zu analysieren

*/
scriptname "dorb\kerberos\debug_diag";
params[["_Scripte",true,[true]],["_Variablen",false,[true]]];
private["_tickzeit","_sekunden","_stunden","_minuten","_zeitstempel","_fps","_fps_min","_Ausgabe"];
_Ausgabe = [];

_tickzeit = diag_tickTime;
_stunden = floor (_tickzeit / 3600);
_sekunden = _tickzeit - (_stunden * 3600);
_minuten = floor (_sekunden / 60);
_sekunden = _sekunden - (_minuten * 60);
_zeitstempel = format["%1:%2:%3",_stunden,_minuten,_sekunden];
_Ausgabe pushBack format["DIAGNOSEPROTOKOLL ANFANG - %1 (%2)",_zeitstempel,_tickzeit];

_fps = diag_fps;
_fps_min = diag_fpsmin;
_Ausgabe pushBack format["    FPS    = %1  (Durchschnitt über die letzten 16 Frames)",_fps];
_Ausgabe pushBack format["    FPSMIN = %1  (Minimale Frameanzahl über die letzten 16 Frames)",_fps];

_Ausgabe pushBack format["    SPIELERZAHL = %1  (Anzahl der Spieler)",(count allPlayers)];
_Ausgabe pushBack format["    EINHEITENANZAHL = %1 | %2 | %3 | %4 (Einheitenanzahl WEST | EAST | IND | CIV)",(west countSide allUnits),(east countSide allUnits),(independent countSide allUnits),(civilian countSide allUnits)];
_Ausgabe pushBack format["    MINEN = %1  (Anzahl der Minen)",(count allMines)];
_Ausgabe pushBack format["    OBJEKTE = %1  (Anzahl der Missions-Objekte auf der Karte)",(count (allMissionObjects "ALL"))];
_Ausgabe pushBack format["    CBA_perFrameEH = %1  (Anzahl der CBA-Eventhandler)",(count (cba_common_perFrameHandlerArray))];

If (_Scripte) then {
    private ["_aktive_FSM","_aktive_SQF","_aktive_SQS"];
    _aktive_SQF = diag_activeSQFScripts;
    _aktive_SQS = diag_activeSQSScripts;
    _aktive_FSM = diag_activeMissionFSMs;
    _Ausgabe pushBack "    AKTIVE SQF-SCRIPTE - [SCRIPTNAME | ISTAKTIV | AKTUELLEZEILE | DATEINAME]";
    {
        _Ausgabe pushBack format["       %1 | %2 | %3 | %4",(_x select 0),(_x select 2),(_x select 3),(_x select 1)];
    }forEach _aktive_SQF;
    _Ausgabe pushBack "    AKTIVE SQS-SCRIPTE - [SCRIPTNAME | ISTAKTIV | AKTUELLEZEILE | DATEINAME]";
    {
        _Ausgabe pushBack format["       %1 | %2 | %3 | %4",(_x select 0),(_x select 2),(_x select 3),(_x select 1)];
    }forEach _aktive_SQS;
    _Ausgabe pushBack "    AKTIVE FSM-SCRIPTE - [NAME | STATUS | TIMEOUT]";
    {
        _Ausgabe pushBack format["       %1 | %2 | %3",(_x select 0),(_x select 1),(_x select 2)];
    }forEach _aktive_FSM;
};

If (_Variablen) then {
    private ["_alleVariablenMNS","_alleVariablenUI"];
    _alleVariablenMNS = allVariables missionnamespace;
    _alleVariablenUI = allVariables uinamespace;
    _Ausgabe pushBack "    VARIABLEN in MISSIONNAMESPACE [VARIABLENNAME = WERT]  (GROESSE DER AUSGABE IST LIMITIERT)";
    {
        private "_Wert";
        _Wert = missionnamespace getVariable[_x,"ERROR - ABRUF NICHT MOEGLICH"];
        If ((typeName _Wert) isEqualTo "CODE") then {_Wert = "CODE";};
        _Ausgabe pushBack format["       %1 = %2",_x,_Wert];
    }forEach _alleVariablenMNS;
    _Ausgabe pushBack "    VARIABLEN in UINAMESPACE [VARIABLENNAME = WERT]  (GROESSE DER AUSGABE IST LIMITIERT)";
    {
        private "_Wert";
        _Wert = uiNamespace getVariable[_x,"ERROR - ABRUF NICHT MOEGLICH"];
        If ((typeName _Wert) isEqualTo "CODE") then {_Wert = "CODE";};
        _Ausgabe pushBack format["       %1 = %2",_x,_Wert];
    }forEach _alleVariablenMNS;
};
{diag_log text _x;} forEach _Ausgabe;
diag_log text format["DIAGNOSEPROTOKOLL ENDE - BEENDET IN (%1) SEKUNDEN",(diag_tickTime - _tickzeit)];

nil;
