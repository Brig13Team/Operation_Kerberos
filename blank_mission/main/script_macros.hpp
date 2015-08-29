#include "\x\cba\addons\main\script_macros_mission.hpp"

#define PATHTO_SYS_LONG(var1,var2,var3,var4) ##var1\##var2\##var3\##var4.sqf

#ifdef DISABLE_COMPILE_CACHE
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))'
    #define PREPMAIN(var1) TRIPLES(PREFIX,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))'
    #define PREPS(var1,var2) TRIPLES(ADDON,fnc,DOUBLES(var1,var2)) = compile preProcessFileLineNumbers 'PATHTO_SYS_LONG(COMPONENT,functions,var1,DOUBLES(fnc,var2))'
#else
    #define PREP(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPMAIN(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(PREFIX,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPS(var1,var2) ['PATHTO_SYS_LONG(COMPONENT,functions,var1,DOUBLES(fnc,var2))', 'TRIPLES(ADDON,fnc,DOUBLES(var1,var2))'] call SLX_XEH_COMPILE_NEW
#endif

#ifdef PART
	#define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\PART\NAME'
#else
	#define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\NAME'
#endif
