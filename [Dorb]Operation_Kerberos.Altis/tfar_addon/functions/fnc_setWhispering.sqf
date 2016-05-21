/*
    Author: Dorbedo

    Description:
       sets player to whispering

    Parameter(s):
        none
    Returns:
        nothing

*/
#include "script_component.hpp"

TF_speak_volume_level = "whispering";
TF_speak_volume_meters = 5;
["OnSpeakVolume_", TFAR_currentUnit, [TFAR_currentUnit, TF_speak_volume_meters]] call TFAR_fnc_fireEventHandlers;