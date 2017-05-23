class drones
{
    class B_UAV_01_F
    {
        scan_radius = 100;
        scan_waypoint = "HOLD";

        class waypoints
        {
            class HOLD
            {
                distance = 250;
                height = 200;
            };
            class MOVE
            {
                height = 200;
            };
        };
    };

    class O_UAV_01_F : B_UAV_01_F {};

    class B_UAV_02_F
    {
        muzzle = "missiles_SCALPEL";
        attack_waypoint = "MOVE";

        scan_radius = 500;
        scan_waypoint = "LOITER";

        class waypoints
        {
            class LOITER
            {
                type = "CIRCLE_L";
                radius = 500;
                height = 2000;
            };
            class MOVE
            {
                height = 2000;
            };
        };
    };

    class B_UAV_02_CAS_F : B_UAV_02_F
    {
        muzzle = "GBU12BombLauncher";
    };

    class O_UAV_02_F : B_UAV_02_F {};
    class O_UAV_02_CAS_F : B_UAV_02_CAS_F {};
    class O_T_UAV_04_CAS_F : B_UAV_02_CAS_F {
        muzzle = "missiles_Jian";
    };

    class rhs_pchela1t_vvs
    {
        scan_radius = 300;
        scan_waypoint = "LOITER";

        class waypoints
        {
            class LOITER
            {
                type = "CIRCLE_L";
                radius = 200;
                height = 500;
            };
            class MOVE
            {
                height = 500;
            };
        };
    };
}
