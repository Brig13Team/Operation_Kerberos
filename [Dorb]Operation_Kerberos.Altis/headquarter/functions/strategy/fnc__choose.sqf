/*
    Author: Dorbedo

    Description:
        choosing the strategy from config

    Parameter(s):
        none

    Returns:
        none
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_attackPos",["_again",false,[true]],"_lastValue",["_passing",5,[0]]];
TRACEV_4(_attackPos,_again,_lastValue,_passing);
private _failedattacks = HASH_GET_DEF(_attackPos,"failedattacks",0);

private _enemyValue = HASH_GET_DEF(_attackPos,"enemyvalue",0);
If (_enemyValue == 0) then {
    [_attackPos] call FUNC(attackpos_update);
};
CHECK(isNull _attackPos)

private _enemyValue = HASH_GET_DEF(_attackPos,"enemyvalue",0);
private _enemystrength = HASH_GET_DEF(_attackPos,"enemystrength",[ARR_3(0,0,0)]);
private _enemyDefence = HASH_GET_DEF(_attackPos,"enemydefence",[ARR_3(0,0,0)]);
private _enemyType = HASH_GET_DEF(_attackPos,"enemytype",[ARR_3(0,0,0)]);
private _possibleStrategys = [];
// [possiblity,_value,"STRATEGY",[PARAMETER]];


private _curValue = _enemyValue * ([_attackPos] call FUNC(getDistanceCoeff)) *
        (
            1 +
            _failedattacks * 0.2 +
            (missionNamespace getVariable [QGVAR(playermalus),0])
        );

If (_again) then {
    //TRACEV_3(_again,_curValue,_lastValue);
    _curValue = _lastValue;
    _again = false;
};
TRACEV_2(_again,_curValue);


// cycle through current availible groups
private _availableGroups = [];
{
    private _grouphash = _x;
    private _group = _grouphash getVariable "group";
    If !(isNil "_grouphash") then {
        private _state = HASH_GET(_grouphash,"state");
        If ((_state in ["idle","wait"])) then {
            _availableGroups pushBack _group;
        };
    };
} forEach (HASH_GET_DEF(GVAR(groups),"attackGroups",[]));
TRACEV_1(_availableGroups);
// add the availible groups
{
    private _curGroup = _x;

    private _possibility = 0;
    private _grouphash = _curGroup getVariable QGVAR(grouphash);
    private _groupValue = HASH_GET_DEF(_grouphash,"value",0);
    private _groupstrength = HASH_GET_DEF(_grouphash,"strength",[ARR_3(0,0,0)]);
    private _groupdefence = HASH_GET_DEF(_grouphash,"defence",[ARR_3(0,0,0)]);
    private _grouptype = HASH_GET_DEF(_grouphash,"type",0);

    If !(_groupValue isEqualTo 0) then {
        private _valueDiffMod = (1/(_groupValue/_enemyValue));
        private _possibility = selectMax [
            (_enemyType select 0) *
                ((_groupstrength select 0)*(1-(_enemyDefence select _grouptype))) *
                (1-((_enemystrength select _grouptype)*(1-(_groupdefence select 0)))) *
                _valueDiffMod,
            (_enemyType select 1) *
                ((_groupstrength select 1)*(1-(_enemyDefence select _grouptype))) *
                (1-((_enemystrength select _grouptype)*(1-(_groupdefence select 1)))) *
                _valueDiffMod,
            (_enemyType select 2) *
                ((_groupstrength select 2)*(1-(_enemyDefence select _grouptype))) *
                (1-((_enemystrength select _grouptype)*(1-(_groupdefence select 2)))) *
                _valueDiffMod
        ];
        private _curStratValue = _groupValue;
        private _parameter = [_curGroup];
        If (_possibility > 0) then {
            _possibleStrategys pushBack [_possibility,_curStratValue,"groundattack",_parameter];
        };
    };
} forEach (_availableGroups select {!isNull _x});

// add the offmap support
{
    private _curCfg = _x;

    private _condition = getText(_curCfg >> "condition");

    If ([] call compile _condition) then {
        private _stratValue = getNumber(_curCfg >> "value");
        private _stratstrength = getarray(_curCfg >> "strength");
        private _stratdefence = getarray(_curCfg >> "defence");
        private _strattype = getNumber(_curCfg >> "type");

        private _valueDiffMod = (1/(_stratValue/_enemyValue));
        private _possibility = selectMax [
            (_enemyType select 0) *
                ((_stratstrength select 0)*(1-(_enemyDefence select _strattype))) *
                (1-((_enemystrength select _strattype)*(1-(_stratdefence select 0)))) *
                _valueDiffMod,
            (_enemyType select 1) *
                ((_stratstrength select 1)*(1-(_enemyDefence select _strattype))) *
                (1-((_enemystrength select _strattype)*(1-(_stratdefence select 1)))) *
                _valueDiffMod,
            (_enemyType select 2) *
                ((_stratstrength select 2)*(1-(_enemyDefence select _strattype))) *
                (1-((_enemystrength select _strattype)*(1-(_stratdefence select 2)))) *
                _valueDiffMod
        ];
        private _curStratValue = _stratValue;
        private _parameter = [_strat];
        If (_possibility > 0) then {
            _possibleStrategys pushBack [_possibility,_curStratValue,configName _curCfg,_parameter];
        };
    };
} forEach (configProperties [missionConfigFile >> "strategies", "!((toLower(configname _x)) in ['groundattack'])", true]);

private _currentStrategies = [[_possibleStrategys,0,false] call EFUNC(common,sel_array_weighted)];
TRACEV_2(_currentStrategies,_possibleStrategys);

// execute the strategies until the current value reaches zero
{
    TRACEV_1(_curValue);
    If (_curValue < 0) exitWith {};

    _x params ["_possibility","_curStratValue","_strategytype","_curparameter"];

    _curValue = _curValue - _curStratValue;

    private _stratCfg = (missionConfigFile >> "strategy" >> _strategytype);

    private _strategyhash = HASH_CREATE;
    HASH_GET(_attackPos,"strategies") pushBack _strategyhash;
    HASH_SET(_strategyhash,"strategytype",_strategytype);

    private _timeout = (getNumber(_stratCfg >> "timeout"));
    private _condition = (getText(_stratCfg >> "finishcondition"));
    private _function = (getText(_stratCfg >> "function"));

    private _parameter = [];
    If !(_function isEqualTo "") then {
        If !(isNil _function) then {
            _parameter = [_attackPos,_strategyhash,_curparameter] call (missionNamespace getVariable _function);
        }else{
            _parameter = [_attackPos,_strategyhash,_curparameter] call compile _function;
        };
    };

    HASH_SET(_strategyhash,"value",_curStratValue);

    If (_timeout > 0) then {
        _timeout = _timeout + CBA_missiontime;
        HASH_SET(_strategyhash,"timeout",_timeout);
    }else{
        HASH_SET(_strategyhash,"timeout",-1);
    };
    If (_condition isEqualTo "") then {
        HASH_SET(_strategyhash,"finishcondition",{true});
        HASH_SET(_strategyhash,"parameter",[]);
    }else{
        HASH_SET(_strategyhash,"finishcondition", compile _condition);
        HASH_SET(_strategyhash,"parameter",_parameter);
    };

    If !((getText(_stratCfg >> "onfinish")) isEqualTo "") then {
        HASH_SET(_strategyhash,"onfinish",(getText(_stratCfg >> "onfinish")));
    };
    /*
    If !((getText(_stratCfg >> "onsuc")) isEqualTo "") then {
        HASH_SET(_strategyhash,"function",(getText(_stratCfg >> "function")));
    };
    If !((getText(_stratCfg >> "function")) isEqualTo "") then {
        HASH_SET(_strategyhash,"onfinish",(getText(_stratCfg >> "function")));
    };
    */

} forEach _currentStrategies;

If (
    (_curValue > 0)&&
    (!_again)
    ) then {
    _again = true;
    _passing = _passing - 1;
    //TRACE("Choosing again");
    //TRACEV_3(_curValue,_again,_passing);
};


If ((_again)&&{_passing > 0}) exitWith {
    //TRACEV_3(_attackPos,_curValue,_passing);
    [_attackPos,true,_curValue,_passing] call FUNC(strategy__choose);
};
#ifdef DEBUG_MODE_FULL
    private _currentStrategies = HASH_GET(_attackPos,"strategies") apply {HASH_GET(_x,"strategytype")};
    TRACEV_6(_attackPos,_currentStrategies,_curValue,_enemyType,_enemyValue,_enemyThreat);
#endif
