#include "script_component.hpp"
/**
 * Name: dorb_main_fnc_compileComponent
 *
 * Author: Dorbedo
 * compiles a missioncomponent
 *
 * Arguments:
 * 0: <STRING> componentname
 *
 * Return Value:
 * Nothing
 *
 */

params [["_componentName", "", [""]]];

private _configName = format ["CfgComponent_%1", _componentName];

if !(isClass (missionConfigFile >> _configname)) exitWith {};




"Extended_AnimChanged",
"Extended_AnimStateChanged",
"Extended_AnimDone",
"Extended_ContainerClosed",
"Extended_ContainerOpened",
"Extended_ControlsShifted",
"Extended_Dammaged",
"Extended_Engine",
"Extended_EpeContact",
"Extended_EpeContactEnd",
"Extended_EpeContactStart",
"Extended_Explosion",
"Extended_Fired",
"Extended_FiredBis",
"Extended_FiredNear",
"Extended_Fuel",
"Extended_Gear",
"Extended_GetIn",
"Extended_GetInMan",
"Extended_GetOut",
"Extended_GetOutMan",
"Extended_HandleHeal",
"Extended_Hit",
"Extended_HitPart",
"Extended_IncomingMissile",
"Extended_Init",
"Extended_InitPost",
"Extended_InventoryClosed",
"Extended_InventoryOpened",
"Extended_Killed",
"Extended_LandedTouchDown",
"Extended_LandedStopped",
"Extended_Local",
"Extended_Respawn",
"Extended_Put",
"Extended_Take",
"Extended_SeatSwitched",
"Extended_SeatSwitchedMan",
"Extended_SoundPlayed",
"Extended_WeaponAssembled",
"Extended_WeaponDisassembled",
"Extended_WeaponDeployed",
"Extended_WeaponRested",
"Extended_Reloaded",
"Extended_FiredMan",
"Extended_TurnIn",
"Extended_TurnOut",
"Extended_Deleted"





[
    {
        If (GVAR(Events_preinit) isEqualTo []) exitWith {
            (_this select 1) call CBA_fnc_removePerFrameHandler;
        };
        private _current = GVAR(Events_preinit) deleteAt 0;
        [] call compile preprocessFileLineNumbers _current;
        ERROR("Preinit Backup Loop - compiling error occured");
    },
    0,
    []
] call CBA_fnc_addPerFrameHandler;

[
    {(!isNil "BIS_fnc_init")&&{BIS_fnc_init}},
    {
        [
            {
                If (GVAR(Events_postinit) isEqualTo []) exitWith {
                    diag_log text "[MissionFile] (System) PostInit compiling finished";
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_postinit) deleteAt 0;
                #ifdef DEBUG_MODE_FULL
                    private _time = diag_tickTime;
                    diag_log text (format["[MissionFile] (postInit) Compiling %1 started",_current]);
                #endif
                [] call compile preprocessFileLineNumbers _current;
                #ifdef DEBUG_MODE_FULL
                    diag_log text (format["[MissionFile] (postInit) Compiling %1 finished in %2",_current,_time - diag_tickTime]);
                #endif
            },
            0,
            []
        ] call CBA_fnc_addPerFrameHandler;
    },
    []
] call CBA_fnc_waitUntilAndExecute;

[
    {(!isNil "BIS_fnc_init")&&{BIS_fnc_init}},
    {
        [
            {
                If (GVAR(Events_all) isEqualTo []) exitWith {
                    diag_log text "[MissionFile] (System) Events compiling finished";
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_all) deleteAt 0;
                #ifdef DEBUG_MODE_FULL
                    private _time = diag_tickTime;
                    diag_log text (format["[MissionFile] (Events) Compiling %1 started",_current]);
                #endif
                [] call compile preprocessFileLineNumbers _current;
                #ifdef DEBUG_MODE_FULL
                    diag_log text (format["[MissionFile] (Events) Compiling %1 finished in %2",_current,_time - diag_tickTime]);
                #endif
            },
            0,
            []
        ] call CBA_fnc_addPerFrameHandler;
    },
    []
] call CBA_fnc_waitUntilAndExecute;

private _time = diag_tickTime + 60;
while {(diag_tickTime < _time)&&(!(GVAR(Events_preinit) isEqualTo []))} do {
    private _current = GVAR(Events_preinit) deleteAt 0;
    #ifdef DEBUG_MODE_FULL
        private _time = diag_tickTime;
        diag_log text (format["[MissionFile] (preInit) Compiling %1 started",_current]);
    #endif
    [] call compile preprocessFileLineNumbers _current;
    #ifdef DEBUG_MODE_FULL
        diag_log text (format["[MissionFile] (preInit) Compiling %1 finished in %2",_current,_time - diag_tickTime]);
    #endif
};

IF (!(GVAR(Events_preinit) isEqualTo [])) then {
    diag_log text "[MissionFile] (main) PreInit Compiling not finished";
}else{
    diag_log text format["[MissionFile] (main) PreInit Compiling finished in: %1",(diag_ticktime - _PreinitStartTime)];
};
