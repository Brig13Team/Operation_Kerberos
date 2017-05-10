/**
 *  Author: Dorbedo
 *
 *  Description:
 *      killed event
 *
 *  Parameter(s):
 *      0 : OBEJCT - Unit who got killed
 *      1 : OBEJCT - Killer
 *      2 : OBEJCT - Unit who pulled the trigger
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"

If (!canSuspend) then {
    _this spawn FUNC(onKilled);
};

_this params["_unit","_killer","_instigator"];

// workaround for modified EH
_killer = if ((_unit==_killer)||{isNull _killer}) then {
    _unit getVariable ["ace_medical_lastDamageSource", _killer];
} else {
    _killer
};

TRACEV_3(_unit,_killer,_instigator);
// ignor blue on blue
CHECK(side _unit == side _killer)

If (!isServer) exitWith {
    [QGVAR(killedUnit),[_unit,_killer,_instigator]] call CBA_fnc_serverEvent;
};


If (isPlayer _unit) then {
    TRACE("Player killed");
    /// reduce the enemystrength, if a player was killed
    private _DZkey = [(getPos _unit)] call FUNC(dzconvert);
    private _zoneHash = HASH_GET(GVAR(dangerzones),_DZkey);
    if (isNil "_zoneHash") then {
        _zoneHash = HASH_CREATE;
        HASH_SET(GVAR(dangerzones),_DZkey,_zoneHash);
    };
    private _unconciousPlayers = HASH_GET_DEF(_zoneHash,"unconciousPlayers",[]);
    private _alreadyReduces = false;
    if (_unit in _unconciousPlayers) then {
        /// skip the reduction, if it is already reduced by unconsciousness
        _alreadyReduces = true;
        _unconciousPlayers = _unconciousPlayers - [_unit];
        HASH_SET(_zoneHash,"unconciousPlayers",_unconciousPlayers);
        private _unconciousHash = HASH_GET(_zoneHash,"unconcious");
        private _playerhash = {
            If (_unit == (HASH_GET(_x,"player"))) exitWith {_x;};
        } forEach _unconciousHash;
        If (!isNil "_playerhash") then {
            _unconciousHash = _unconciousHash - _playerhash;
            HASH_DELETE(_playerhash);
        };
        HASH_SET(_zoneHash,"unconcious",_unconciousHash);
    };
    If !(_alreadyReduces) then {
        /// reduce the enemystrength
        private _strengthArray = _unit call FUNC(strengthPlayer);
        private _strengthEnemy = HASH_GET(_zoneHash,"enemystrength");
        If (isNil "_strengthEnemy") then {_strengthEnemy = 0;};
        _strengthEnemy = (_strengthEnemy - (_strengthArray select 1)) max 0;
        HASH_SET(_zoneHash,"enemystrength",_strengthEnemy);
    };
}else{
    //  a ai Unit was Killed
    TRACE("AI killed");
    // if unit is the last one in the group the units joins
    if ((count (units (group _unit)))<2) then {
        private _group = group _unit;

        // join a random attack group
        private _newgroups = (["combat"] call FUNC(statemachine_getAIGroups));
        If !(_newgroups isEqualTo []) then {
            (units (group _unit)) joinSilent (selectRandom _newgroups);
        };
    };

    /// check if other units recognized the dead
    /// TODO - only if a unit realy know about the incident
    private _deathWasKnowledged = false;
    if ((count (units (group _unit)))<1) then {
        private _distance = 30;
        private _otherUnits = (getPos _unit) nearEntities ["Man",_distance];
        TRACEV_2(_distance,_otherUnits);
        _otherUnits = _otherUnits - [_unit]; /// TODO - evaluate if this is needed;
        // exit if noOne knows about the loss
        CHECK(_otherUnits isEqualTo [])
        _otherUnits = _otherUnits select {
            ((_x knowsAbout _killer) > 0.8)
        };
        TRACEV_1(_otherUnits);
        if !(_otherUnits isEqualTo []) then {
            _deathWasKnowledged = true;
        };
    }else{
        _deathWasKnowledged = true;
    };

    TRACEV_4(_deathWasKnowledged,_unit,_killer,_instigator);

    if (_deathWasKnowledged) then {
        [_unit,_killer,_instigator] call FUNC(killedUnit);
    }else{
        // if no one knows, who killed the Unit, get some recon
        [_unit,_killer,_instigator] call FUNC(requestRecon);
    };
};
