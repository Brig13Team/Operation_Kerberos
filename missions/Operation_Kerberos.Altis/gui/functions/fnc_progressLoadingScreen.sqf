/*
 *  Author: Dorbedo
 *
 *  Description:
 *      processes the loadingScreen
 *
 *  Parameter(s):
 *      0 : STRING - LoadingScreen ID
 *      1 : SCALAR - loading status (0-1)
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
disableSerialization;
params [["_curKey","",[""]],["_val",0,[0]]];

If ((!(_curKey isEqualTo ""))&&(HASH_HASKEY(GVAR(loading),_curkey))) then {
    _val = (_val min 1) max 0;
    HASH_SET(GVAR(loading),_curKey,_val);
};

private _loadingprocesses = [];

{
    private _curKey = _x;
    _loadingprocesses pushBack (HASH_GET(GVAR(loading),_curKey));
} forEach HASH_KEYS(GVAR(loading));

private _process = [_loadingprocesses] call EFUNC(common,arithmeticMean);

//progressLoadingScreen _process;
private _disp = findDisplay IDD_LOADING;
If ((isNull _disp)||(isNil "_process")) exitWith {
    uisleep 1;
    [] call FUNC(endLoadingScreen);
};

((findDisplay IDD_LOADING) displayCtrl IDD_LOADING_PROGRESS) progressSetPosition _process;
