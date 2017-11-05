class CommTower_V1 {
    type = "radiotower";
    objecttypes[] = {"Land_TTowerBig_1_F"};
    class header {
        #include "missioncompositions\CommTower_V1\header.sqe"
    };
    class composition {
        #include "missioncompositions\CommTower_V1\composition.sqe"
    };
};

class CommTower_V2 {
    type = "radiotower";
    objecttypes[] = {"Land_TTowerBig_2_F"};
    class header {
        #include "missioncompositions\CommTower_V2\header.sqe"
    };
    class composition {
        #include "missioncompositions\CommTower_V2\composition.sqe"
    };
};

class Kerb_Hill3234_Abschussrampe_02_big_Final {
    type = "scarab";
    objecttypes[] = {"rhs_9k79_B"};
    class header {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_big_Final\header.sqe"
    };
    class composition {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_big_Final\composition.sqe"
    };
};

class Kerb_Hill3234_Abschussrampe_02_Final {
    type = "scarab";
    objecttypes[] = {"rhs_9k79_B"};
    class header {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_Final\header.sqe"
    };
    class composition {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_Final\composition.sqe"
    };
};

class Kerb_Hill3234_Abschussrampe_02_small_Final {
    type = "scarab";
    objecttypes[] = {"rhs_9k79_B"};
    class header {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_small_Final\header.sqe"
    };
    class composition {
        #include "missioncompositions\Kerb_Hill3234_Abschussrampe_02_small_Final\composition.sqe"
    };
};

class Kerb_Hill3234_Arty {
    type = "artillery";
    objecttypes[] = {"rhs_2s3_tv","RHS_BM21_MSV_01","rhs_D30_vdv"};
    class header {
        #include "missioncompositions\Kerb_Hill3234_Arty\header.sqe"
    };
    class composition {
        #include "missioncompositions\Kerb_Hill3234_Arty\composition.sqe"
    };
};

class mission_artillery_01 {
    type = "artillery";
    objecttypes[] = {"rhs_D30_msv"};
    class header {
        #include "missioncompositions\mission_artillery_01\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_artillery_01\composition.sqe"
    };
};

class mission_artillery_02 {
    type = "artillery";
    objecttypes[] = {"RHS_BM21_MSV_01"};
    class header {
        #include "missioncompositions\mission_artillery_02\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_artillery_02\composition.sqe"
    };
};

class mission_artillery_03 {
    type = "artillery";
    objecttypes[] = {"RHS_BM21_VDV_01"};
    class header {
        #include "missioncompositions\mission_artillery_03\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_artillery_03\composition.sqe"
    };
};

class mission_device_01 {
    type = "device";
    class header {
        #include "missioncompositions\mission_device_01\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_device_01\composition.sqe"
    };
};

class mission_droneheadquarter_01 {
    type = "dronecommando";
    objecttypes[] = {"Land_CargoBox_V1_F"};
    class header {
        #include "missioncompositions\mission_droneheadquarter_01\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_droneheadquarter_01\composition.sqe"
    };
};

class mission_generic_01 {
    type = "%ALL";
    class header {
        #include "missioncompositions\mission_generic_01\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_generic_01\composition.sqe"
    };
};

class mission_generic_02 {
    type = "%ALL";
    class header {
        #include "missioncompositions\mission_generic_02\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_generic_02\composition.sqe"
    };
};

class mission_generic_03 {
    type = "%ALL";
    class header {
        #include "missioncompositions\mission_generic_03\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_generic_03\composition.sqe"
    };
};

class mission_generic_04 {
    type = "%ALL";
    class header {
        #include "missioncompositions\mission_generic_04\header.sqe"
    };
    class composition {
        #include "missioncompositions\mission_generic_04\composition.sqe"
    };
};

class radar {
    type = "radar";
    objecttypes[] = {"Land_Radar_Small_F"};
    class header {
        #include "missioncompositions\radar\header.sqe"
    };
    class composition {
        #include "missioncompositions\radar\composition.sqe"
    };
};
