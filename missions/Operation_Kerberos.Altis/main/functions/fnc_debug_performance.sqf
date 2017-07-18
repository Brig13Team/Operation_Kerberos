/*
    Author: Dorbedo

    Description:
        Diagnosefunktion um Performance-Probleme zu analysieren

*/
#include "script_component.hpp"
_this params[["_Scripte",true,[true]],["_Variablen",false,[true]]];
private _Ausgabe = [];
private _tickzeit = diag_tickTime;
private _stunden = floor (_tickzeit / 3600);
private _sekunden = _tickzeit - (_stunden * 3600);
private _minuten = floor (_sekunden / 60);
private _sekunden = _sekunden - (_minuten * 60);
private _zeitstempel = format["%1:%2:%3",_stunden,_minuten,_sekunden];
_Ausgabe pushBack format["DIAGNOSEPROTOKOLL ANFANG - %1 (%2)",_zeitstempel,_tickzeit];

private _fps = diag_fps;
private _fps_min = diag_fpsmin;
_Ausgabe pushBack format["    FPS    = %1  (Durchschnitt über die letzten 16 Frames)",_fps];
_Ausgabe pushBack format["    FPSMIN = %1  (Minimale Frameanzahl über die letzten 16 Frames)",_fps];

_Ausgabe pushBack format["    SPIELERZAHL = %1  (Anzahl der Spieler)",(count allPlayers)];
_Ausgabe pushBack format["    EINHEITENANZAHL = %1 | %2 | %3 | %4 (Einheitenanzahl WEST | EAST | IND | CIV)",(west countSide allUnits),(east countSide allUnits),(independent countSide allUnits),(civilian countSide allUnits)];
_Ausgabe pushBack format["    MINEN = %1  (Anzahl der Minen)",(count allMines)];
_Ausgabe pushBack format["    OBJEKTE = %1  (Anzahl der Missions-Objekte auf der Karte)",(count (allMissionObjects "ALL"))];
_Ausgabe pushBack format["    CBA_perFrameEH = %1  (Anzahl der CBA-Eventhandler)",(count (cba_common_perFrameHandlerArray))];
If (hasInterface) then {
    _Ausgabe pushBack format["    Viewdistance = %1 | %2  (Sichtweite | [Objektsichtweite , Schattensichtweite])",(viewDistance),(getObjectViewDistance)];
};

If (_Scripte) then {
    private _aktive_SQF = diag_activeSQFScripts;
    private _aktive_SQS = diag_activeSQSScripts;
    private _aktive_FSM = diag_activeMissionFSMs;
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
    private _alleVariablenMNS = allVariables missionnamespace;
    private _alleVariablenUI = allVariables uinamespace;
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
