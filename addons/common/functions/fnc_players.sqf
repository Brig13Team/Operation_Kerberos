/*
    Author: Dorbedo
    
    Description:
        returns an array with all players
    Parameter(s):
        none
    Return:
        ARRAY - including all players
*/
#include "script_component.hpp"

If !(isMultiplayer) exitWith {[player]};

private _allHCs = entities "HeadlessClient_F";
(allPlayers - _allHCs);