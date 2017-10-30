#define CBA_OFF
#include "script_component.hpp"
class cargos {
    class ace_track {
        width = 0.54;
        length = 0.4;
        height = 0.15;
        offset[] = {0,-0.3,0};
    };
    class ace_wheel {
        width = 1;
        length = 1;
        height = 0.32;
        offset[] = {0,-0.5,-0.12};
    };
    class WpnsBox_F {
        width = 1.1;
        length = 0.73;
        height = 0.344;
        offset[] = {0,0,0.023};
    };
    class AmmoBox_F {
        width = 0.45;
        length = 0.72;
        height = 0.6;
        offset[] = {0,0,0.025};
    };
    class WpnsBox_large_F {
        width = 1.63;
        length = 0.73;
        height = 0.344;
        offset[] = {0,0,0.023};
    };
    class WpnsBox_long_F {
        width = 1.63;
        length = 0.34;
        height = 0.344;
        offset[] = {0,0,0.023};
    };
    class Supplydrop {
        width = 1.54;
        length = 1.05;
        height = 1.35;
        offset[] = {0,0,-0.215};
    };
    class ace_medcrate {
        width = 1.3;
        length = 0.4;
        height = 0.35;
    };

    class bwa3_democracybox {
        width = 2.55;
        length = 5.8;
        height = 2.3;
        offset[] = {0,0,1.15};
        stackable = -1;
    };
    class B_Slingload_01_Cargo_F {
        width = 2.45;
        length = 6.25;
        height = 2.73;
        stackable = -1;
    };
    class B_Slingload_01_Medevac_F : B_Slingload_01_Cargo_F {
        width = 2.7;
    };
    class B_Slingload_01_Ammo_F : B_Slingload_01_Cargo_F {};
    class B_Slingload_01_Repair_F : B_Slingload_01_Cargo_F {};
    class B_Slingload_01_Fuel_F : B_Slingload_01_Cargo_F {};
    class AmmoVeh_F {
        width = 1.54;
        length = 1.54;
        height = 1.54;
        offset[] = {0,0,-0.05};
    };
    class Land_Cargo10_base {
        width = 2.5;
        length = 3.1;
        height = 1.25;
        stackable = -1;
    };
    class Land_Cargo10_blue_F : Land_Cargo10_base {};
    class Land_Cargo10_brick_red_F : Land_Cargo10_base {};
    class Land_Cargo10_cyan_F : Land_Cargo10_base {};
    class Land_Cargo10_grey_F : Land_Cargo10_base {};
    class Land_Cargo10_light_blue_F : Land_Cargo10_base {};
    class Land_Cargo10_light_green_F : Land_Cargo10_base {};
    class Land_Cargo10_military_green_F : Land_Cargo10_base {};
    class Land_Cargo10_orange_F : Land_Cargo10_base {};
    class Land_Cargo10_red_F : Land_Cargo10_base {};
    class Land_Cargo10_sand_F : Land_Cargo10_base {};
    class Land_Cargo10_white_F : Land_Cargo10_base {};
    class Land_Cargo10_yellow_F : Land_Cargo10_base {};
    class Land_Cargo20_base {
        width = 6.2;
        length = 2.46;
        height = 2.64;
    };
    class Land_Cargo20_blue_F : Land_Cargo20_base {};
    class Land_Cargo20_brick_red_F : Land_Cargo20_base {};
    class Land_Cargo20_china_color_V1_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_china_color_V2_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_color_V1_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_color_V2_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_color_V3_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_cyan_F : Land_Cargo20_base {};
    class Land_Cargo20_grey_F : Land_Cargo20_base {};
    class Land_Cargo20_light_blue_F : Land_Cargo20_base {};
    class Land_Cargo20_light_green_F : Land_Cargo20_base {};
    class Land_Cargo20_military_green_F : Land_Cargo20_base {};
    class Land_Cargo20_military_ruins_F : Land_Cargo20_base {};
    class Land_Cargo20_orange_F : Land_Cargo20_base {};
    class Land_Cargo20_red_F : Land_Cargo20_base {};
    class Land_Cargo20_sand_F : Land_Cargo20_base {};
    class Land_Cargo20_vr_F : Land_Cargo20_base {};
    class Land_Cargo20_white_F : Land_Cargo20_base {};


    class CargoBox_V1_F {
        width = 1.54;
        length = 1.54;
        height = 1.54;
        offset[] = {0,0,-0.05};
    };
    class CargoNet_01_ammo_F {
        width = 1.6;
        length = 1.6;
        height = 1.68;
    };
    class RHS_M119_WD {
        width = 2;
        length = 5.1;
        height = 1.5;
        offset[] = {0,-1.3,0.8};
        stackable = -1;
    };
    class RHS_M119_D : RHS_M119_WD {};
    class rhs_D30_vdv : RHS_M119_WD {
        offset[] = {0,0.6,-0.7};
    };
    class rhs_D30_at_vdv : rhs_D30_vdv {};

    class FIM92_static {
        width = 3;
        length = 3;
        height = 2;
        offset[] = {0,0,-0.5};
        stackable = -1;
    };

    class TOW_static {
        width = 1.7;
        length = 1.7;
        height = 1.2;
        offset[] = {0,0.5,-0.5};
        stackable = -1;
    };

    class m2_mg2 {
        width = 1.2;
        length = 2;
        height = 0.7;
        offset[] = {-0.35,0.6,-0.9};
        stackable = -1;
    };

    class m2_mg {
        width = 1.2;
        length = 1.9;
        height = 1.5;
        offset[] = {-0.35,0.6,-1};
        stackable = -1;
    };

    class mk19_stat {
        width = 1.2;
        length = 1.2;
        height = 0.7;
        offset[] = {0,0.8,-0.7};
        stackable = -1;
    };

    class Quadbike_01_F {
        width = 1.2;
        length = 2.2;
        height = 1;
        offset[] = {0,-0.05,-0.9};
        stackable = -1;
    };

    class rhs_mrzr4 {
        width = 1.6;
        length = 3.7;
        height = 2.1;
        offset[] = {-0.02,0,-0.55};
        stackable = -1;
    };

    class SDV_01_F {
        width = 2;
        length = 6.2;
        height = 1.5;
        offset[] = {0,-1.1,-1.2};
        stackable = -1;
    };

    class Boat_Transport_01_F {
        width = 2.1;
        length = 4.9;
        height = 1.5;
        offset[] = {0,0,-0.5};
        stackable = -1;
    };

    class rhs_3Ya40_1 {
        width = 2.5;
        length = 0.9;
        height = 0.8;
        offset[] = {0,0,-0.05};
        stackable = -1;
    };

    class rhs_7ya37_1 {
        width = 1.15;
        length = 0.45;
        height = 0.55;
        offset[] = {0,0,0};
        stackable = -1;
    };

    class Land_DataTerminal_01_F {
        width = 1.4;
        length = 0.6;
        height = 0.5;
        offset[] = {0,0,0.25};
    };

    class Proxy_UsBasicAmmoBox {
        width = 0.7;
        length = 0.55;
        height = 0.5;
        offset[] = {0,0,0};
    };

    class Proxy_UsBasicWeaponBox {
        width = 0.9;
        length = 0.45;
        height = 0.2;
        offset[] = {0,0,0};
    };

    class Equipment_Box_F {
        width = 0.6;
        length = 1.15;
        height = 0.75;
        offset[] = {0,0,0};
    };

    class Uniforms_Box_F {
        width = 0.6;
        length = 1.15;
        height = 0.75;
        offset[] = {0,0,0};
    };

    class CargoNet_01_box_F {
        width = 1.5;
        length = 1.5;
        height = 1.3;
        offset[] = {0,0,0};
    };

};
