/*
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
#include "script_component.hpp"

_this spawn {
    SCRIPTIN(EH_killed,spawn);
    _this params["_unit","_killer","_instigator"];
    CHECK((side _unit)==civilian)

    If (isPlayer _unit) then {
        /// reduce the enemystrenght, if a player was killed
        private _key = (getPos _player) call FUNC(dz_convert);
        private _zoneHash = HASH_GET(GVAR(dangerzones),_key);
        private _unconciousPlayers = HASH_GET(_zoneHash,"unconciousPlayers");
        private _alreadyReduces = false;
        If (isNil "_unconciousPlayers") then {
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
        };
        If !(_alreadyReduces) then {
            /// reduce the enemyStrenght
            private _strenghtArray = _unit call FUNC(strengthPlayer);
            private _strenghtEnemy = HASH_GET(_zoneHash,"enemystrenght");
            If (isNil "_strenghtEnemy") then {_strenghtEnemy = 0;};
            _strenghtEnemy = (_strenghtEnemy - (_strenghtArray select 1)) max 0;
            HASH_SET(_zoneHash,"enemystrenght",_strenghtEnemy);
        };
    }else{
        //  a ai Unit was Killed

        // if unit is the last one in the group the units joins
        if (count (units group _unit))<2 then {
            private _group = group _unit;
            [_group] call FUNC(attackpos_reduce);

            // remove the group from hashes;
            private _grouphash = _group getVariable [QGVAR(grouphash),locationNull];
            If !(isNull _grouphash) then {
                /// if the group is registered somewhere, then remove the registration
                private _state = HASH_GET(_grouphash,"grouptype");
                private _key = switch _state do {
                    case "defence" : {"defenceGroups"};
                    case "patrol" : {"patrolGroups"};
                    default {"attackGroups"};
                };
                private _groupsarray = HASH_GET(GVAR(groups),_key);
                _groupsarray = _groupsarray - [_group];
                HASH_SET(GVAR(groups),_groupsarray);
                HASH_DELETE(_grouphash);
            };

            // join a random defence group
            private _defenceGroups = HASH_GET(GVAR(groups),"defenceGroups");
            If !(_defenceGroups isEqualTo []) then {
                (units (group _unit)) joinSilent (selectRandom _defenceGroups);
            };
        };

        /// check if other units recognized the dead
        /// TODO - only if a unit realy know about the incident
        private _distance = switch (true) do {
            case (_unit isKindOf "Air") : {1000};
            case (_unit isKindOf "LandVehicle") : {400};
            default {30};
        };
        private _otherUnits = (getPos _unit) nearEntities ["Man",_distance];
        _otherUnits = _otherUnits - [_unit]; /// TODO - evaluate if this is needed;
        // exit if noOne knows about the loss
        CHECK(_otherUnits isEqualTo [])
        _otherUnits = _otherUnits select {
            ((_x knowsAbout _killer) > 0.8)
        };
        if (_otherUnits isEqualTo []) then {
            // if no one knows, who killed the Unit, get some recon
            [_unit,_killer,_instigator] call FUNC(requestRecon);
        }else{
            [_unit,_killer,_instigator] call FUNC(killedUnit);
        };
    };

};
