/**
 * Author: Dorbedo
 * on fired event
 *
 * Arguments:
 * 0: <OBJECT> the vehicle
 * 0: <STRING> weapon
 * 0: <STRING> muzzle
 * 0: <STRING> firemode
 * 0: <STRING> ammotype
 * 0: <STRING> magazine
 * 0: <OBJECT> projectile
 * 0: <OBJECT> gunnter
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_vehicle","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];

private _muzzleSpeed = _vehicle getVariable [QGVAR(muzzleSpeed),vectorMagnitude (velocity _projectile)];

#ifdef DEBUG_MODE_FULL
    If (isNil QGVAR(debug_marker)) then {
        GVAR(debug_marker) = createMarkerLocal ["DEBUGMARKER_ARTILLERY",getPos _projectile];
        GVAR(debug_marker) setMarkerShapeLocal "ICON";
        GVAR(debug_marker) setMarkerTypeLocal "hd_dot";
        [
            {
                _this params ["_projectile","_handler"];
                If !(alive _projectile) then {
                    [_handler] call CBA_fnc_removePerFrameHandler;
                    deleteMarkerLocal GVAR(debug_marker);
                    GVAR(debug_marker) = nil;
                };
                GVAR(debug_marker) setMarkerPosLocal (getPos _projectile);
                GVAR(debug_marker) setMarkerTextLocal format["%1",(getPosATL _projectile)select 2];
            },
            _projectile
        ] call CBA_fnc_addPerFrameHandler;
    };
#endif


TRACEV_1(_muzzleSpeed);

private _projectileVec = velocity _projectile;
private _projectileVelo = (vectorNormalized _projectileVec) vectorMultiply (_muzzleSpeed);

_projectile setVelocity _projectileVelo;

_vehicle setVariable [QGVAR(lastShot),CBA_missiontime];
