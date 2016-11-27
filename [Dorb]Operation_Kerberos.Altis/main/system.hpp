/*

    Author: Dorbedo

    Description:
        don't edit unless you realy know how it works

*/
#define CBA_OFF
#define COMPONENT SYSTEM
#include "..\script_mission.hpp"


/*
    Name: dorb_system_fnc_compile

    Author: Dorbedo - Version 1.0

    Description:
        main compiling function
        adds header to functions
        adds functions to functionfviewer
        adds recompilingprevention

    Parameter(s):
        0: STRING - path to function file
        1: STRING - functionsname
        2: SCALAR - add the debug-header (default: 0 - MINIMAL; 1: SMALL; 2: MAPPING)

    Return
        nil
*/
class system {

compile = QUOTE( \
    private _fnc_scriptName = 'Main compiling function'; \
    scriptName _fnc_scriptName; \
    _this params [ARR_3([ARR_3('_path','',[''])],[ARR_3('_funcName','',[''])],[ARR_3('_headertype',0,[1])])]; \
    If (isClass(configFile>>'cfgPatches'>>'cba_cache_disable')) then { \
        [ARR_5(missionNamespace,_funcName,_path,_headertype,true)] call (parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,compile_sys)'); \
        with uiNamespace do { \
            If (isNil 'GVARMAIN(recompile)') then {GVARMAIN(recompile) = [];}; \
            GVARMAIN(recompile) pushBack [ARR_3(_path,_funcName,_headertype)]; \
            diag_log format [ARR_2('compiling: %2',[ARR_3(_path,_funcName,_headertype)])]; \
        }; \
    }else{ \
        private _cache = uiNamespace getVariable _funcName; \
        if (isNil '_cache') then { \
            [ARR_4(uiNamespace,_funcName,_path,_headertype)] call (parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,compile_sys)'); \
            missionNamespace setVariable [ARR_2(_funcName, uiNamespace getVariable _funcName)]; \
        }else{ \
            missionNamespace setVariable [ARR_2(_funcName,_cache)]; \
        }; \
    }; \
    nil;);

recompile = QUOTE( \
    private _fnc_scriptName = 'Recompiling function'; \
    scriptName _fnc_scriptName; \
    { \
        _x params [ARR_3('_path','_funcName','_headertype')]; \
        [ARR_5(missionNamespace,_funcName,_path,_headertype,true)] call (parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,compile_sys)'); \
    } forEach (uiNamespace getVariable [ARR_2('GVARMAIN(recompile)',[])]); \
    );

compile_sys = QUOTE( \
    private _fnc_scriptName = 'Compiling SyS'; \
    scriptName _fnc_scriptName; \
    _this params [ARR_5('_namespace','_funcName','_pathstring','_headertype','_recompile')]; \
    private _headerstring = switch (_headertype) do { \
        case 1 : {format [ARR_2('private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName)];}; \
        case 2 : {format [ARR_2('private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName; private _fnc_scriptMap = if !(isnil ''_fnc_scriptMap'') then {_fnc_scriptMap + [''%1'']} else {[''%1'']};',_funcName)];}; \
        default {format [ARR_2('private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName)];};}; \
    _metadata = [ARR_3(_funcName,_pathstring,_headertype)]; \
    If (_recompile) exitWith {_namespace setVariable [ARR_2(_funcName,compile (_headerstring + preprocessFileLineNumbers _pathstring))];}; \
    _cache = uiNamespace getVariable format[ARR_2('%1_meta',_funcName)]; \
    If (isNil '_cache') exitWith {uiNamespace setVariable [ARR_2(format[ARR_2('%1_meta',_funcName)],compilefinal str _metadata)];_namespace setVariable [ARR_2(_funcName,compilefinal (_headerstring + preprocessFileLineNumbers _pathstring))];}; \
    If !((((call _cache) select 0) isEqualTo (_metadata select 0))||(((call _cache) select 1) isEqualTo (_metadata select 1))) exitWith {diag_log 'Compiling Violation'; call FUNCSYS(kick);}; \
    _namespace setVariable [ARR_2(_funcName,compilefinal (_headerstring + preprocessFileLineNumbers _pathstring))];);

kick = QUOTE( \
        [] spawn { \
            If (!hasInterface) exitWith {}; \
            waitUntil {!isNil 'BIS_fnc_init'}; \
            waituntil {!(IsNull (findDisplay 46))}; \
            findDisplay 46 closeDisplay 0; \
        }; \
    );

};
