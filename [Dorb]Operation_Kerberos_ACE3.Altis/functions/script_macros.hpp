/* -------------------------------------------
Macro: PARAMS_n()
	moved the CBA functions into new BIS version
	
Parameters:
	VARIABLE - Partial name of the function

Parameters:
	A..I - Name of variable to read from _this [Identifier]

Author:
	Dorbedo
------------------------------------------- */

#define PARAMS_1(A) params[QUOTE(A)]; TRACE_1("PARAMS_1, " + QUOTE(_this),A)
#define PARAMS_2(A,B) params[QUOTE(A),QUOTE(B)]; TRACE_2("PARAMS_2, " + QUOTE(_this),A,B)
#define PARAMS_3(A,B,C) params[QUOTE(A),QUOTE(B),QUOTE(C)]; TRACE_3("PARAMS_3, " + QUOTE(_this),A,B,C)
#define PARAMS_4(A,B,C,D) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D)]; TRACE_4("PARAMS_4, " + QUOTE(_this),A,B,C,D)
#define PARAMS_5(A,B,C,D,E) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D),QUOTE(E)]; TRACE_5("PARAMS_5, " + QUOTE(_this),A,B,C,D,E)
#define PARAMS_6(A,B,C,D,E,F) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D),QUOTE(E),QUOTE(F)]; TRACE_6("PARAMS_6, " + QUOTE(_this),A,B,C,D,E,F)
#define PARAMS_7(A,B,C,D,E,F,G) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D),QUOTE(E),QUOTE(F),QUOTE(G)]; TRACE_7("PARAMS_7, " + QUOTE(_this),A,B,C,D,E,F,G)
#define PARAMS_8(A,B,C,D,E,F,G,H) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D),QUOTE(E),QUOTE(F),QUOTE(G),QUOTE(H)]; TRACE_8("PARAMS_8, " + QUOTE(_this),A,B,C,D,E,F,G,H)
#define PARAMS_9(A,B,C,D,E,F,G,H,I) params[QUOTE(A),QUOTE(B),QUOTE(C),QUOTE(D),QUOTE(E),QUOTE(F),QUOTE(G),QUOTE(H),QUOTE(I)]; TRACE_9("PARAMS_9, " + QUOTE(_this),A,B,C,D,E,F,G,H,I)

/* -------------------------------------------
Macro: DEFAULT_PARAM()
	moved the CBA functions into new BIS version

Parameters:
	INDEX - Index of parameter in _this [Integer, 0+]
	NAME - Name of the variable to set [Identifier]
	DEF_VALUE - Default value to use in case the array is too short or the value at INDEX is nil [Any]

Author:
	Dorbedo
------------------------------------------- */
#define DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) \
	private #NAME; \
	NAME = param[INDEX,DEF_VALUE]; \
	TRACE_3("DEFAULT_PARAM",INDEX,NAME,DEF_VALUE)

/* -------------------------------------------
Macro: FM()
	Function Name
	
Parameters:
	VARIABLE - Partial name of the function

Example:
	(begin example)
		this call FM(test)
	(end)

Author:
	Dorbedo
------------------------------------------- */
#define FM(VAR) TRIPLES(PREFIX,fnc,VAR)

/* -------------------------------------------
Macro: FMP
	Spawns CBA_fnc_globalExecute

Parameters:
	none

Example:
	(begin example)
		{-1,{hint _this},["Makro Test"]} FMP;
	(end)

Author:
	Dorbedo
------------------------------------------- */
#define FMP spawn CBA_fnc_globalExecute
/* -------------------------------------------
Macro: CHECK()
	Checks Condition - Exit if true
	
	Hint: no ';' after CHECK()

Parameters:
	CODE - Condition to Check

Example:
	(begin example)
		// if is server exit
		CHECK(isServer)
	(end)

Author:
	Dorbedo
------------------------------------------- */
#define CHECK(CONDITION) if (CONDITION) exitWith {};
/* -------------------------------------------
Macro: SELRND()
	Selects a random element of an array

Parameters:
	ARRAY - array to select from

Example:
	(begin example)
		_winner = ["Klaus","Dieter","Thorsten"] SELRND;
	(end)
	
	(begin example)
		_gamers = ["Felix","Hans","Heinrich"];
		_looser = _gamers SELRND;
	(end)

Author:
	Dorbedo
------------------------------------------- */
#define SELRND call TRIPLES(dorb,makro,selectrandom)
/* -------------------------------------------
Macro: TILGE
	deletes:
		- Marker
		- Objects (vehicles incl Crew)
		- Groups
		- Arrays including these

Parameters:
	none

Example:
	(begin example)
		[veh1  ,  group1  ,  [ "Marker1" , "marker2" ]  ,  [ [ Veh2 ] , soldier1 ] , [ group2 ] ]     TILGE;
		[soldier3,soldier4] TILGE;
		"marker3" TILGE;
	(end)

Author:
	Dorbedo
------------------------------------------- */
#define TILGE call TRIPLES(dorb,makro,delete)

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
