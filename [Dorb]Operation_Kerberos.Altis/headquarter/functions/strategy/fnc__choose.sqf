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

private _curValue = _enemyValue apply {_x * (_failedattacks * 0.2 + 1 + (missionNamespace getVariable [QGVAR(playermalus),0]) )};
If (_again) then {
    _curValue = _lastValue
};

private _chosenStrategies = [];


/// get some AA - strategie
If ((_enemyType select 2)>0) then {
    /// posible strategies against air
    private _strategyCfgs = "(((getArray(_x >> 'threat')) select 2) > 0)" configClasses (missionConfigFile >> "strategy");
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
    private _strategyCfgs = "(((getArray(_x >> 'threat')) select 1) > 0)" configClasses (missionConfigFile >> "strategy");
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
            If (((_curValue select 1) - ((_tempthreat select 1) * (_tempValue))) > 0) then {
                _temp = 1 / ((abs((_curValue select 1) - ((_tempthreat select 1) * (_tempValue)))+ 1) * 10);
            }else{
                _temp = 1 / (abs((_curValue select 1) - ((_tempthreat select 1) * (_tempValue)))+1);
            };
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


/// attack the rest with infanterie
If ((_enemyType select 0)>0) then {
    /// posible strategies against air
    private _strategyCfgs = "(((getArray(_x >> 'threat')) select 0) > 0)" configClasses (missionConfigFile >> "strategy");
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
};


//// register the strategies and execute them

{
    private _hash = HASH_CREATE;
    HASH_GET(_attackPos,"strategies") pushBack _hash;

    HASH_SET(_hash,"strategytype",className _x);

    private _timeout = (getText(_x >> "timeout"));
    private _condition = (getText(_x >> "finishcondition"));
    private _function = (getText(_x >> "function"));

    private _parameter = [[_attackPos,_hash] call compile _function)] param [0,[]];

    If (_timeout > 0) then {
        _timeout = _timeout + CBA_missiontime;
        HASH_SET(_hash,"timeout",_timeout);
    }else{
        HASH_SET(_hash,"timeout",-1);
    };
    If (_condition isEqualTo "") then {
        HASH_SET(_hash,"finishcondition",{true});
        HASH_SET(_hash,"parameter",[]);
    }else{
        HASH_SET(_hash,"finishcondition", compile _condition);
        HASH_SET(_hash,"parameter",_parameter);
    };

    If !((getText(_x >> "onfinish")) isEqualTo "") then {
        HASH_SET(_hash,"onfinish",(getText(_x >> "onfinish")));
    };
    /*
    If !((getText(_x >> "onsuc")) isEqualTo "") then {
        HASH_SET(_hash,"function",(getText(_x >> "function")));
    };
    If !((getText(_x >> "function")) isEqualTo "") then {
        HASH_SET(_hash,"onfinish",(getText(_x >> "function")));
    };
    */

} forEach _chosenStrategies;


If ((_again)&&{_passing > 0}) then {
    [_attackPos,true,_curValue,_passing] call FUNC(strategy__choose);
};
