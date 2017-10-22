/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the sandstorm Effect
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define WINDSTRENGTH 6

If !(GVAR(sandstormIsActive)) exitWith {
    /// Destroy
    [(_this select 1)] call CBA_fnc_removePerFrameHandler;
    [] spawn {
        If (isNil QGVAR(sandstorm_ppEffect)) exitWith {};
        GVAR(sandstorm_ppEffect) ppEffectAdjust [1,1.0,0.0,[.55,.55,.52,0],[.88,.88,.93,1],[1,.1,.4,0.03]];
        GVAR(sandstorm_ppEffect) ppEffectCommit 30;
        ppEffectDestroy GVAR(sandstorm_ppEffect);
    };

    If (isNil QGVAR(sandstorm_emitterArray)) exitWith {};

    {
        deleteVehicle _x;
    } forEach GVAR(sandstorm_emitterArray);

    GVAR(sandstorm_emitterArray) = nil;
    deleteVehicle GVAR(sandstorm_emitter);
    GVAR(sandstorm_emitter) = nil
};

/// player is in respawn -> do nothing
If (isNull player) exitWith {};

_windDir = WindDir;
_windDirVec = [[0,1],_windDir] call EFUNC(common,rotateVectorXY);

private _fnc_setDir = {
    (GVAR(sandstorm_emitterArray) select 1) setDropInterval (0.7 + ((_windDirVec select 0)*0.2));
    (GVAR(sandstorm_emitterArray) select 2) setDropInterval (0.7 + ((_windDirVec select 1)*0.2));
    (GVAR(sandstorm_emitterArray) select 3) setDropInterval (0.7 - ((_windDirVec select 0)*0.2));
    (GVAR(sandstorm_emitterArray) select 4) setDropInterval (0.7 - ((_windDirVec select 1)*0.2));
};
private _colors = [
    [[.6,.5,.4,0.0],[.6,.5,.4,.04],[.6,.5,.4,.02],[.6,.5,.4,.02],[.6,.5,.4,.02],[.6,.5,.4,.01],[.6,.5,.4,.01],[.6,.5,.4,.01]],
    [[.6,.5,.4,0.0],[.6,.5,.4,.06],[.6,.5,.4,.05],[.6,.5,.4,.04],[.6,.5,.4,.03],[.6,.5,.4,.02],[.6,.5,.4,.02],[.6,.5,.4,.02]],
    [[.6,.5,.4,0.0],[.6,.5,.4,.08],[.6,.5,.4,.07],[.6,.5,.4,.06],[.6,.5,.4,.04],[.6,.5,.4,.04],[.6,.5,.4,.03],[.6,.5,.4,.03]],
    [[.6,.5,.4,0.0],[.6,.5,.4,.10],[.6,.5,.4,.09],[.6,.5,.4,.08],[.6,.5,.4,.06],[.6,.5,.4,.06],[.6,.5,.4,.06],[.6,.5,.4,.05]],
    [[.6,.5,.4,0.0],[.6,.5,.4,.14],[.6,.5,.4,.11],[.6,.5,.4,.10],[.6,.5,.4,.08],[.6,.5,.4,.08],[.6,.5,.4,.07],[.6,.5,.4,.07]],
    [[.6,.5,.4,0.0],[.6,.5,.4,.18],[.6,.5,.4,.13],[.6,.5,.4,.12],[.6,.5,.4,.10],[.6,.5,.4,.10],[.6,.5,.4,.10],[.6,.5,.4,.10]]
];
private _Volume = [7.83,7.84,7.85];

If (isNil QGVAR(sandstorm_emitterArray)) then {
    GVAR(sandstorm_emitter) = "Logic" createVehicleLocal (getPosASL player);
    GVAR(sandstorm_emitter) attachTo [player,[0,0,0]];
    GVAR(sandstorm_emitterArray) = [];
    GVAR(sandstorm_emitterArray) set [0,"#particlesource" createVehicleLocal (getPos player)];
    (GVAR(sandstorm_emitterArray) select 0) attachTo [GVAR(sandstorm_emitter),[0,0,0]];
    {
        private _temp = "#particlesource" createVehicleLocal (getPosASL player);
        _temp setParticleClass "HousePartDust";
        _temp setParticleCircle [0,[0,0,0]];
        _temp attachTo [(GVAR(sandstorm_emitterArray) select 0),[0,0,0]];
        _temp setParticleRandom [0,[70,0,-0.8],[0,0,0],0,0.215,[0.02,0,0.02,0.106],0,0];
        _temp setParticleParams [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16,12,13,0],
            "",
            "Billboard",
            1,
            30,
            _x,
            [(_windDirVec select 0) * WINDSTRENGTH,(_windDirVec select 1) * WINDSTRENGTH,0],        //Velocity
            0,
            10,
            7.84,
            0.0001,
            [5,15,10,15,20],
            [[.6,.5,.4,0.0],[.6,.5,.4,.04],[.6,.5,.4,.02],[.6,.5,.4,.03],[.6,.5,.4,.02],[.6,.5,.4,.01],[.6,.5,.4,.01],[.6,.5,.4,.01]],
            [1000],
            0,
            0.0,
            "",
            "",
            (GVAR(sandstorm_emitterArray) select 0)
        ];
        GVAR(sandstorm_emitterArray) pushBack _temp;
    } forEach [
        [0,70,0],
        [0,-70,0],
        [70,0,0],
        [-70,0,0]
    ];

    [] call _fnc_setDir;
    };



    If (isNil QGVAR(sandstorm_ppEffect)) then {
        GVAR(sandstorm_ppEffect) = ppEffectCreate ["colorCorrections", 1501];
        GVAR(sandstorm_ppEffect) ppEffectEnable true;
        GVAR(sandstorm_ppEffect) ppEffectAdjust [1,1.02,-0.005,[0,0,0,0],[1,0.8,0.6,0.65],[0.199,0.587,0.115,0]];
        GVAR(sandstorm_ppEffect) ppEffectCommit 20;
    };
    ISNILS(ZAEHLER,0);
    ZAEHLER = ZAEHLER + 1;
    If (ZAEHLER > 4) then {
    /// set the direction of the storm
    [] call _fnc_setDir;


    {
        (GVAR(sandstorm_emitterArray) select (_forEachIndex + 1)) setParticleParams [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16,12,13,0],
            "",
            "Billboard",
            1,
            30,
            _x,
            [(_windDirVec select 0) * WINDSTRENGTH,(_windDirVec select 1) * WINDSTRENGTH,0],        //Velocity
            0,
            10,
            (selectRandom _Volume),
            0.0001,
            [5,15,10,15,20],
            (selectRandom _colors),
            [1000],
            0,
            0.0,
            "",
            "",
            (GVAR(sandstorm_emitterArray) select 0)
        ];
    } forEach [
        [0,70,0],
        [0,-70,0],
        [70,0,0],
        [-70,0,0]
    ];
    ZAEHLER = 0;
};
