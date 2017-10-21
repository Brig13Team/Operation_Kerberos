/*
 *  Author: Dorbedo
 *
 *  Description:
 *      closes the loadingScreen
 *
 *  Parameter(s):
 *      0 : STRING - LoadingScreen ID
 *
 *  Returns:
 *     none
 *
 */

#include "script_component.hpp"
disableSerialization;
params [["_key","NOKEY",[""]]];

If (HASH_HASKEY(GVAR(loading),_key)) then {
    HASH_REM(GVAR(loading),_key);
};

If (isNull(findDisplay IDD_LOADING)) exitWith {
    (findDisplay IDD_LOADING) closeDisplay 1;
    GVAR(loading) = HASH_CREATE;
};

If (count (HASH_KEYS(GVAR(loading)))>0) exitWith {
    [] call FUNC(progressLoadingScreen);
};

//endLoadingScreen;
(findDisplay IDD_LOADING) closeDisplay 1;
