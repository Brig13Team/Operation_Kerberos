/*
    Author: Dorbedo
    
    Description:
        returns strenght
    
    Parameter(s):
        none

    Returns:
        none
*/


/// Attackpositions -> 

GVAR(attackpos)

GVAR(type)          // -> Type of Player (0-inf,1-tanks,2-planes)
GVAR(cost)          // -> cost of playergroup
GVAR(threat)        // -> best attacktyp 
GVAR(troopsSend)    // -> attacks called upon position
GVAR(strategy)      // -> chosen strategy


/// Dangermatrix

GVAR(definitions)   // []
GVAR(buffer)        // Temp value -> not public



/// Groups
GVAR(cost)          // Cost save -> updated on state change
GVAR(target)        // Target of group
GVAR(state)         // State of group
GVAR(type)          // Type of group
GVAR(threat)        // Threat of group


/// Waypoints
GVAR(WP_hashes)
GVAR(WP_deaktivated)

