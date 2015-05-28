/// CBA
#define PREFIX dorb
#define COMPONENT kerberos
#define CUSTOM_FOLDER functions
#include "\x\cba\addons\main\script_macros_mission.hpp"

/// DEF
#define DEBUGMODUS

/// ALLG
#define FM(VAR) TRIPLES(PREFIX,fnc,VAR)
#define FMP spawn CBA_fnc_globalExecute

#define CHECK(CONDITION) if (CONDITION) exitWith {};	
#define FCALL(var1) \
	call TRIPLES(PREFIX,fnc,var1)
#define FSPAWN(var1) \
	spawn TRIPLES(PREFIX,fnc,var1)
#define FCMAKRO(VAR) FCALL(DOUBLES(makro,VAR))		//falls ich irgendwann mal Lust habe die makros in eine Datei zu packen

#define SELRND FCMAKRO(selrandom)
#define TILGE FCMAKRO(delete)
	
//// LOG Funktionen
#define CHECK_STR(var1) \
	__EVAL (If (IS_STRING(var1)) then {var1} else {FORMAT_1("NO_STRING",__LINE__)})	
#define d_error(eintrag) \
	[eintrag,_fnc_scriptName] FCALL(makro_log);
#define d_error_p(eintrag) \
	[eintrag,_fnc_scriptName,_fnc_scriptNameParent] FCALL(makro_log);
#define d_error_o(eintrag) \
	[eintrag] FCALL(makro_log); 
#ifdef DEBUGMODUS
	#define d_log(eintrag) \
		[eintrag,_fnc_scriptName] FCALL(makro_log);
	#define d_log_p(eintrag) \
		[eintrag,_fnc_scriptName,_fnc_scriptNameParent] FCALL(makro_log);
	#define d_log_o(eintrag) \
		[eintrag] FCALL(makro_log);
#else
    #define d_log(eintrag) /*disabled*/;
	#define d_log_p(eintrag) /*disabled*/;
	#define d_log_o(eintrag) /*disabled*/;
#endif






//// Variablen

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define GETUVAR(var1,var2) uiNamespace GETVAR_SYS(var1,var2)
#define GETPRVAR(var1,var2) profileNamespace GETVAR_SYS(var1,var2)
#define GETPAVAR(var1,var2) parsingNamespace GETVAR_SYS(var1,var2)

#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#define GETGVAR(var1,var2) GETMVAR(GVAR(var1),var2)
#define GETEGVAR(var1,var2,var3) GETMVAR(EGVAR(var1,var2),var3)
