

class baseMainmission : baseMission {
    class side {
        min = 1;
        max = 3;
        sidemissions[] = {"%ALL"}; // sidemissionWildcard
    };
};
class baseSidemission : baseMission {
    class position : position {
        // the possible locations, if none defined, the mainlocation is used
        areas[] = {};
        // the min/max distance of the location to choose, if negative, the condition is ignored
        minDistance = -1;
        maxDistance = -1;
        // the radius around the location
        radius = 500;
    };
};

class mainmissions {
    #include "mainmissions.hpp"
};
class sidemissions {
    #include "sidemissions.hpp"
};
