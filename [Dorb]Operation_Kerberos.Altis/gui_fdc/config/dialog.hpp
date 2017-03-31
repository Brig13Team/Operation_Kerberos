/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    controlsBackground[] = {
        background_display,
        background_taskbar
    };
    controls[] = {
        clock,
        menu_button,

        Map_Tablet,

        bttnBackgrd_1,
        bttnBackgrd_2,
        menubutton_1,
        menubutton_2,
        menubutton_3,
        menubutton_4,
        menubutton_5,
        menubutton_6,
        menubutton_7,

        metro_back,
        metro,
        metro_side,
        background_device
    };
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call FUNC(OnUnLoad);_this call EFUNC(gui_Echidna,OnUnLoad););

    #define BUTTON_HELPER(NUMBER) class TRIPLES(menubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_FDC_MAIN_BTTN + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        colorBackground[] = {0,0,0,1}; \
        colorText[] = {0,0,0,1}; \
    }; \
    class DOUBLES(menubutton,NUMBER) : RSC(BaseButton) { \
        idc = IDC_FDC_MAIN_BTTN + NUMBER; \
        x = 0;y = 0;w = 0;h = 0; \
        sizeEx = GUI_ECHIDNA_H * 0.7; \
        text = ""; \
        style = "48+0x800"; \
        colorBackground[]= COLOR_DISABLED; \
        colorBackgroundActive[]= COLOR_DISABLED; \
        colorFocused[]= COLOR_DISABLED; \
        colorBackgroundDisabled[]= COLOR_DISABLED; \
        colorText[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT; \
        colorDisabled[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT_DISABLED; \
        shadow = 0; \
        colorShadow[] = COLOR_DISABLED; \
        offsetX = 0; \
        offsetY = 0; \
        offsetPressedX = 0; \
        offsetPressedY = 0; \
    }

    BUTTON_HELPER(1);
    BUTTON_HELPER(2);
    BUTTON_HELPER(3);
    BUTTON_HELPER(4);
    BUTTON_HELPER(5);
    BUTTON_HELPER(6);
    BUTTON_HELPER(7);


    class Map_Tablet : RSC(BaseMapControl) {
        idc = IDC_FDC_MAP;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        type = 101;
        style = 48;
        colorText[] = {0.00, 0.00, 0.00, 1.00};
        font = "TahomaB";
        sizeEx = 0.040000;
        maxSatelliteAlpha = 0;
        drawObjects = 0;
        showMarkers=1;
    };

    class Info_Group : RSC(BaseControlsGroupNoHScrollbar) {
        idc = IDC_FDC_INFO_GRP;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 28;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 12;
        h = GUI_ECHIDNA_H * 27.5;
    };

    class Order_Group : RSC(BaseControlsGroupNoHScrollbar) {
        idc = IDC_FDC_ORDER_GRP;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 28;
        h = GUI_ECHIDNA_H * 27.5;
        class controls {
            class background : RSC(BaseText) {
                idc = IDC_FDC_ORDER_BACK;
                x = 0;
                y = 0;
                w = GUI_ECHIDNA_W * 28;
                h = GUI_ECHIDNA_H * 27.5;
            };
            class warningOrder_Header : RSC(BaseText) {
                idc = IDC_FDC_ORDER_WARNING_HEADER;
                x = GUI_ECHIDNA_W * 3;
                y = GUI_ECHIDNA_H * 3;
                w = GUI_ECHIDNA_W * 28;
                h = GUI_ECHIDNA_H * 2;
                style = "0x00";
                font = FONT_BOLD;
                sizeEx = GUI_ECHIDNA_H * 2;
                text = CSTRING(ORDER_HEADER);
            };
            class warningOrder_Observer_name : RSC(BaseText) {
                idc = -1;
                x = GUI_ECHIDNA_W * 4;
                y = GUI_ECHIDNA_H * 5.5;
                w = GUI_ECHIDNA_W * 5;
                h = GUI_ECHIDNA_H * 2;
                text = CSTRING(ORDER_OBSERVER);
            };
            class warningOrder_Observer_edit_1 : RSC(BaseEdit) {
                idc = IDC_FDC_ORDER_WARNING_OBSERVER_edit_1;
                x = GUI_ECHIDNA_W * 9.5;
                y = GUI_ECHIDNA_H * 5.5;
                w = GUI_ECHIDNA_W * 1.5;
                h = GUI_ECHIDNA_H * 2;
            };
            class warningOrder_Observer_minus : RSC(BaseText) {
                idc = -1;
                x = GUI_ECHIDNA_W * 4;
                y = GUI_ECHIDNA_H * 5.5;
                w = GUI_ECHIDNA_W * 1;
                h = GUI_ECHIDNA_H * 2;
                text = "-";
                style = "0x02";
            };
            class warningOrder_Observer_edit_2 : warningOrder_Observer_edit_1 {
                idc = IDC_FDC_ORDER_WARNING_OBSERVER_edit_2;
                x = GUI_ECHIDNA_W * 12;
                w = GUI_ECHIDNA_W * 3;
            };
        };
    };

    class Position_Group : RSC(BaseControlsGroupNoHScrollbar) {
        idc = IDC_FDC_POSITION_GRP;
    };

    class bttnBackgrd_1 : RSC(BaseText) {
        idc = IDC_FDC_MAIN_BTTN_BACK_1;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        colorBackGround = {RAL9005,1};
    };
    class bttnBackgrd_2 : bttnBackgrd_1 {
        idc = IDC_FDC_MAIN_BTTN_BACK_2;
    };


    /*
        Warning Order

            a)* Observer-Identification

            b)* MissionType
                - "FireMission"
                - "Adjust Fire"
                - "Fire for Effect"
                - "Polar"

            c)* TargetNumber
                - 2Letter + 4 Digits

            d) Number of Guns
                - used in FFE

        Location of Target

            a) By Grid Coordinates
                1) Grid easting-> norhting
                    - East (3-5 digits)
                    - north (3-5 digits)
                b) ALtitude
                    - sealevel
                c) Target Grid Zone
            b) By Ref/Shift from a TargetNumber
                Offset from a Targetlocation
            c) by Poloar coordinates

                “Direction 1240, Distance 2000, Up 50”.
            d) by Target number

        Direction
            Direction GT

        Target Description
            a) Description
                1)* Target Type and Subtype
                2) Degree of Protection (only for Personal)
                    e.g. Prone
                3)* Target size
                    radius or retangular
                4) Target activity
                    "Prepared to move"
                5) combination of all
            b) Target strenght
                1-4 digits
            c) Report value accuracy
                1-3 digits
            d) Trajectory type
                high angle (default for arty) or low angel (default for mortar)
            e) Dange close Missions
            f) Ammunition
                1) Number of Rounds
                2) Type
                    shell and fuze
            g) effect required
                1) traditional ammunition (HE, ICM)
                    1-30% (default neutralization 20-29%)
                2) special effects
                    mark, mark illuminating, smoke, quick smoke, blinding,
            h) Method of Fire and method of COntol
                A)
                    1) "Fire for Effect" - effect without adjustment
                    2) "Adjust Fire" - fire is qdjusted by observer
                    3) "Battery left (or Right)" 5 sec. between guns
                        "Battery Right 10 Seconds"
                    4) "Continous Illumination"
                    5) "Co-Ordinated Illumination"
                    6) "Continous Fire" - Stop via "End of Mission" or "Cease Loading" or "Check FIre"
                B) Method of control
                    1) "At my Command" -
                    2) "Resticted when Ready"
                        "Rsticted when Ready from 2359, for 65 Minutes"
                    3) "Time on Target"
                        "TOT 1545"
                    4) "Time to fire"
                    5) "When ready"
                C) Firing Interval
                    "Interval 5 rounds 20 sec"
                D) Duration of Fire
                    * Mainly used for smoke or Illumination
    */
};
