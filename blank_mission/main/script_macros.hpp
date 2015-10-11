/* -------------------------------------------
Macro: CBA_OFF
    turns off the including of CBA because of compatibility issues during description.ext
    If CBA_OFF is defined, some important MACROS are copied out of CBA
Parameters:
    none

Example:
    (begin example)
        #define CBA_OFF
        #include "script_component.hpp"
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifndef CBA_OFF
    #include "\x\cba\addons\main\script_macros_mission.hpp"
#else
    #define DOUBLES(var1,var2) ##var1##_##var2
    #define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
    #define QUOTE(var1) #var1
    #define ADDON DOUBLES(PREFIX,COMPONENT)
    #define MAIN_ADDON DOUBLES(PREFIX,main)
    #define CSTRING(var1) QUOTE(TRIPLES($STR,ADDON,var1))
    #define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(PREFIX,var1),var2))
    #define FUNC(var1) TRIPLES(ADDON,fnc,var1)
    #define FUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)
    #define EFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)
    #define INCLUDE_PREINIT(var1) \
        class DOUBLES(PREFIX,var1) {\
            init = QUOTE(call compile preProcessFileLineNumbers 'var1\XEH_PreInit.sqf'); \
        };
    #define INCLUDE_POSTINIT(var1) \
        class DOUBLES(PREFIX,var1) {\
            init = QUOTE(call compile preProcessFileLineNumbers 'var1\XEH_PreInit.sqf'); \
        };
    #undef CBA_OFF
#endif
/* -------------------------------------------
Macro: SCRIPT(VAR)
   Sets name of script
   Overrides CBA "SCRIPT"
Parameters:
    NAME - Name of script [Indentifier]

Example:
    (begin example)
        SCRIPT(boom);
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifdef PART
    #define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\PART\NAME'
#else
    #define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\NAME'
#endif

/* -------------------------------------------
Macro: SCRIPTIN(VAR)
   Sets name of an inner script
Parameters:
    NAME - Name of script [Indentifier]

Example:
    (begin example)
        SCRIPTIN(boom);
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifdef PART
    #define SCRIPTIN(NAME,NAME2) scriptName 'PREFIX\COMPONENT\PART\NAME_NAME2'
#else
    #define SCRIPTIN(NAME,NAME2) scriptName 'PREFIX\COMPONENT\NAME_NAME2'
#endif


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


#define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))
#define QGVARMAIN(var1) QUOTE(GVARMAIN(var1))

#ifndef STRING_MACROS_GUARD
#define STRING_MACROS_GUARD
    #define LSTRING(var1) QUOTE(TRIPLES(STR,ADDON,var1))
    #define ELSTRING(var1,var2) QUOTE(TRIPLES(STR,DOUBLES(PREFIX,var1),var2))
    #define CSTRING(var1) QUOTE(TRIPLES($STR,ADDON,var1))
    #define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(PREFIX,var1),var2))
#endif
