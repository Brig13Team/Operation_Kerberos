/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onCameraChanged Event
 *
 *  Parameter(s):
 *      0 : STRING - CmaeraView
 *      1 : STRING - CameraOn
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_CameraView","_vehicle"];

(
!((toUpper _CameraView) in ["GUNNER", "GROUP"]) &&
{!isNull ACE_player} &&
{player == ACE_player} &&
{alive ACE_player} &&
{ACE_player == _vehicle || vehicle ACE_player == _vehicle} &&
{!([] call ace_common_fnc_isFeatureCameraActive)} &&
{!(_vehicle isKindOf "UAV" || _vehicle isKindOf "UAV_01_base_F")}
)
