/*
 *  Author: Dorbedo
 *
 *  Description:
 *      User can open the Menu
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - isallowed to open the Menu
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If ((isNil "ace_player")||{isNull ace_player}) exitWith {false};

switch (true) do {
    case ((vehicle ace_player) == ace_player) : {
        (({
            _x params ["_position","_targetName","_condition","_params"];
            If (IS_CODE(_position)) then {
                (_params call _position)&&
                {(_params call _condition)}
            }else{
                ((ace_player distance2D _position)<CHECK_RADIUS)&&
                {(_params call _condition)}
            };
        } count GVAR(pos_infanterie))>0)

    };
    case ((vehicle ace_player) isKindof "Air") : {
        (({
            _x params ["_position","_targetName","_condition","_params"];
            If (IS_CODE(_position)) then {
                ((driver (vehicle ace_player)) == ace_player)&&
                {(_params call _position)}&&
                {_params call _condition}
            }else{
                ((driver (vehicle ace_player)) == ace_player)&&
                {((ace_player distance2D _position)<CHECK_RADIUS)}&&
                {(_params call _condition)}
            };
        } count GVAR(pos_air))>0)
    };
    case ((vehicle ace_player) isKindof "Ship") : {
        (({
            _x params ["_position","_targetName","_condition","_params"];
            If (IS_CODE(_position)) then {
                ((driver (vehicle ace_player)) == ace_player)&&
                {(_params call _position)}&&
                {_params call _condition}
            }else{
                ((driver (vehicle ace_player)) == ace_player)&&
                {((ace_player distance2D _position)<CHECK_RADIUS)}&&
                {(_params call _condition)}
            };
        } count GVAR(pos_ship))>0)
    };
    default {
        (({
            _x params ["_position","_targetName","_condition","_params"];
            If (IS_CODE(_position)) then {
                ((driver (vehicle ace_player)) == ace_player)&&
                {(_params call _position)}&&
                {_params call _condition}
            }else{
                ((driver (vehicle ace_player)) == ace_player)&&
                {((ace_player distance2D _position)<CHECK_RADIUS)}&&
                {(_params call _condition)}
            };
        } count GVAR(pos_default))>0)

    };
};
