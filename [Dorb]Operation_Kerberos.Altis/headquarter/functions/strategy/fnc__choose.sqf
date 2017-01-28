/*
    Author: Dorbedo

    Description:
        choosing the strategy from config

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"

_this params ["_attackPos",["_again",false,[true]],"_lastValue",["_passing",5,[0]]];

private _failedattacks = HASH_GET_DEF(_attackPos,"failedattacks",0);

private _enemyType = HASH_GET(_attackPos,"enemytype"); /// [0,0,0] - amount of specific groups
private _enemyValue = HASH_GET(_attackPos,"enemyvalue"); /// [0,0,0] - value of each type
private _enemyThreat = HASH_GET(_attackPos,"enemythreat"); /// [0,0,0] - combined threat
TRACEV_4(_failedattacks,_enemyType,_enemyValue,_enemyThreat);
private _curValue = _enemyValue apply {_x * (_failedattacks * 0.2 + 1 + (missionNamespace getVariable [QGVAR(playermalus),0]) )};
If (_again) then {
    TRACEV_3(_again,_curValue,_lastValue);
    _curValue = _lastValue;
    _again = false;
};

private _chosenStrategies = [];


/// get some AA - strategie
If ((_enemyType select 2)>0) then {
    /// posible strategies against air
    private _strategyCfgs = configProperties [(missionConfigFile >> "strategy"),"(((getArray(_x >> 'threat')) select 2) > 0)",true];
    private _possibleStrategys = [];
    {
        //// check additional condition - e.g. all Support used
        private _condition = (getText(_x>>"condition"));
        If ([] call compile _condition) then {
            //// weight the strategy
            private _tempValue = (getNumber(_x>>"value"));
            private _tempthreat = (getArray(_x>>"threat"));
            private _temp = 0;
            /// minimal value difference
            If (((_curValue select 2) - ((_tempthreat select 2) * (_tempValue))) > 0) then {
                _temp = 1 / ((abs((_curValue select 2) - ((_tempthreat select 2) * (_tempValue)))+ 1) * 10);
            }else{
                _temp = 1 / (abs((_curValue select 2) - ((_tempthreat select 2) * (_tempValue)))+1);
            };
            _temp = _temp * 1000000;
            _possibleStrategys pushBack [_temp,_x];
        };
    } forEach _strategyCfgs;
    /// select the strategy (weighted)
    private _strategyToAdd = ([_possibleStrategys,0,false] call EFUNC(common,sel_array_weighted)) select 1;
    private _tempValue = (getNumber(_strategyToAdd>>"value"));
    private _tempthreat = (getArray(_strategyToAdd>>"threat"));
    private _temptype = (getArray(_strategyToAdd>>"type"));

    //// reduce the needed strategy -> if a helicopter is send, there is no need to send additional infantrie
    _curValue set[2,    ((_curValue select 2) - (_tempValue * (_tempthreat select 2))) max 0    ];
    _curValue set[1,    ((_curValue select 1) - (_tempValue * (_tempthreat select 1))) max 0    ];
    _curValue set[0,    ((_curValue select 0) - (_tempValue * (_tempthreat select 0))) max 0    ];

    _chosenStrategies pushBack _strategyToAdd;
};

/// get some AT - strategie
If ((_enemyType select 1)>0) then {
    /// posible strategies against air
    private _strategyCfgs = configProperties [(missionConfigFile >> "strategy"),"(((getArray(_x >> 'threat')) select 1) > 0)" ,true];
    private _possibleStrategys = [];
    TRACEV_1(_strategyCfgs);
    {
        //// check additional condition - e.g. all Support used
        private _condition = (getText(_x>>"condition"));
        If ([] call compile _condition) then {
            //// weight the strategy
            private _tempValue = (getNumber(_x>>"value"));
            private _tempthreat = (getArray(_x>>"threat"));
            private _temp = 0;
            /// minimal value difference
            If (((_curValue select 1) - ((_tempthreat select 1) * (_tempValue))) > 0) then {
                _temp = 1 / ((abs((_curValue select 1) - ((_tempthreat select 1) * (_tempValue)))+ 1) * 10);
            }else{
                _temp = 1 / (abs((_curValue select 1) - ((_tempthreat select 1) * (_tempValue)))+1);
            };
            _temp = _temp * 1000000;
            TRACEV_4(configname _x,_temp,_tempValue,_tempthreat);
            _possibleStrategys pushBack [_temp,_x];
        };
    } forEach _strategyCfgs;
    /// select the strategy (weighted)
    TRACEV_1(_possibleStrategys);
    private _strategyToAdd = ([_possibleStrategys,0,false] call EFUNC(common,sel_array_weighted)) select 1;
    private _tempValue = (getNumber(_strategyToAdd>>"value"));
    private _tempthreat = (getArray(_strategyToAdd>>"threat"));
    private _temptype = (getArray(_strategyToAdd>>"type"));

    //// reduce the needed strategy -> if a helicopter is send, there is no need to send additional infantrie
    _curValue set[2,    ((_curValue select 2) - (_tempValue * (_tempthreat select 2))) max 0    ];
    _curValue set[1,    ((_curValue select 1) - (_tempValue * (_tempthreat select 1))) max 0    ];
    _curValue set[0,    ((_curValue select 0) - (_tempValue * (_tempthreat select 0))) max 0    ];
    TRACEV_5(_strategyToAdd,_tempValue,_tempthreat,_temptype,_curValue);
    _chosenStrategies pushBack _strategyToAdd;
};


/// attack the rest with infanterie
If ((_enemyType select 0)>0) then {
    /// posible strategies against air
    private _strategyCfgs = configProperties [(missionConfigFile >> "strategy"),"(((getArray(_x >> 'threat')) select 0) > 0)",true];
    private _possibleStrategys = [];
    {
        //// check additional condition - e.g. all Support used
        private _condition = (getText(_x>>"condition"));
        If ([] call compile _condition) then {
            //// weight the strategy
            private _tempValue = (getNumber(_x>>"value"));
            private _tempthreat = (getArray(_x>>"threat"));
            private _temp = 0;
            /// minimal value difference
            If (((_curValue select 0) - ((_tempthreat select 0) * (_tempValue))) > 0) then {
                _temp = 1 / ((abs((_curValue select 0) - ((_tempthreat select 0) * (_tempValue)))+ 1) * 10);
            }else{
                _temp = 1 / (abs((_curValue select 0) - ((_tempthreat select 0) * (_tempValue)))+1);
            };
            _temp = _temp * 1000000;
            _possibleStrategys pushBack [_temp,_x];
        };
    } forEach _strategyCfgs;
    /// select the strategy (weighted)
    private _strategyToAdd = ([_possibleStrategys,0,false] call EFUNC(common,sel_array_weighted)) select 1;
    private _tempValue = (getNumber(_strategyToAdd>>"value"));
    private _tempthreat = (getArray(_strategyToAdd>>"threat"));
    private _temptype = (getArray(_strategyToAdd>>"type"));

    //// reduce the needed strategy -> if a helicopter is send, there is no need to send additional infantrie
    _curValue set[2,    ((_curValue select 2) - (_tempValue * (_tempthreat select 2))) max 0    ];
    _curValue set[1,    ((_curValue select 1) - (_tempValue * (_tempthreat select 1))) max 0    ];
    _curValue set[0,    ((_curValue select 0) - (_tempValue * (_tempthreat select 0))) max 0    ];

    _chosenStrategies pushBack _strategyToAdd;
};

If (
    (((_curValue select 0)>0)||
    ((_curValue select 1)>0)||
    ((_curValue select 2)>0))&&
    (!_again)
    ) then {
    _again = true;
    _passing = _passing - 1;
    TRACE("Choosing again");
    TRACEV_3(_curValue,_again,_passing);
};


//// register the strategies and execute them

{
    private _strategyhash = HASH_CREATE;
    HASH_GET(_attackPos,"strategies") pushBack _strategyhash;

    HASH_SET(_strategyhash,"strategytype",configName _x);

    private _timeout = (getNumber(_x >> "timeout"));
    private _condition = (getText(_x >> "finishcondition"));
    private _function = (getText(_x >> "function"));

    private _parameter = [];
    If !(_function isEqualTo "") then {
        If !(isNil _function) then {
            _parameter = [_attackPos,_strategyhash] call (missionNamespace getVariable _function);
        }else{
            _parameter = [_attackPos,_strategyhash] call compile _function;
        };
    };
    //private _parameter = [[_attackPos,_strategyhash] call compile _function] param [0,[]];
    TRACEV_5(configName _x,_attackPos,_strategyhash,_function,_parameter);
    TRACEV_3(_timeout,_condition,_parameter);
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

    If !((getText(_x >> "onfinish")) isEqualTo "") then {
        HASH_SET(_strategyhash,"onfinish",(getText(_x >> "onfinish")));
    };
    /*
    If !((getText(_x >> "onsuc")) isEqualTo "") then {
        HASH_SET(_strategyhash,"function",(getText(_x >> "function")));
    };
    If !((getText(_x >> "function")) isEqualTo "") then {
        HASH_SET(_strategyhash,"onfinish",(getText(_x >> "function")));
    };
    */

} forEach _chosenStrategies;


If ((_again)&&{_passing > 0}) then {
    TRACEV_3(_attackPos,_curValue,_passing);
    [_attackPos,true,_curValue,_passing] call FUNC(strategy__choose);
};
