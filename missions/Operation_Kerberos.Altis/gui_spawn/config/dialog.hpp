/*
    Author: Dorbedo
*/

#define CBA_OFF
#define INCLUDE_GUI
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    controlsBackground[] = {
        background_taskbar,
        background_display,
        background_object
    };
    controls[] = {
        clock,
        menu_button,

        spare_back_1,
        spare_back_2,
        spare_back_3,
        spare_back_4,
        spare_back_5,
        spare_back_6,

        spawnmenubutton_1_background,
        spawnmenubutton_2_background,
        spawnmenubutton_1,
        spawnmenubutton_2,

        vehiclelist,
        header,
        vehicleproperties,

        metro_back,
        metro,
        metro_side,
        background_device
    };
    objects[] = {
        vehicle
    };

    class background_object: background_display {
        idc = -1;
        colorBackground[] = {RAL9002,1};
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y+GUI_ECHIDNA_H*10;
        w = GUI_ECHIDNA_W*20;
        h = GUI_ECHIDNA_H*17.5;
    };

    #define BUTTON_HELPER(NUMBER) class TRIPLES(spawnmenubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_ECHIDNA_SPAWN_VEHICLEBUTTON + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        colorBackground[] = {ARR_4(0,0,0,1)}; \
        colorText[] = {ARR_4(0,0,0,1)}; \
    }; \
    class DOUBLES(spawnmenubutton,NUMBER) : RSC(BaseButton) { \
        idc = IDC_ECHIDNA_SPAWN_VEHICLEBUTTON + NUMBER; \
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


    class vehiclelist : RSC(BaseListboxN) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLELIST;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*21;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*3;
        w = GUI_ECHIDNA_W*18;
        h = GUI_ECHIDNA_H*19;
        columns[] = {-0.01,0.65,0.8};
        sizeEx = GUI_ECHIDNA_H;
        rowHeight = GUI_ECHIDNA_H;
        tooltip = "";
        color[] = {RAL9005,1};
        colorScrollbar[] = {RAL9005,1};
        colorSelect[] = {RAL9005,1};
        colorSelect2[] = {RAL9005,1};
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = {RAL9002,1};
        colorSelectBackground2[] = {RAL9002,1};
        colorText[] = {RAL9005,1};
        colorBackground[] = {RAL7047,1};
    };

    class vehicleproperties : RSC(BaseListboxN) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLEPROPERTIES;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*3;
        w = GUI_ECHIDNA_W*18;
        h = GUI_ECHIDNA_H*10;
        columns[] = {-0.01,0.5};
        sizeEx = GUI_ECHIDNA_H;
        rowHeight = GUI_ECHIDNA_H;
        tooltip = "";
        color[] = {RAL9005,1};
        colorScrollbar[] = {RAL9005,1};
        colorSelect[] = {RAL9005,1};
        colorSelect2[] = {RAL9005,1};
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = {RAL9002,1};
        colorSelectBackground2[] = {RAL9002,1};
        colorText[] = {RAL9005,1};
        colorBackground[] = {RAL7047,1};
    };

    class vehicle : RSC(BaseObjectContainer) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLEOBJECT;
        model = "\A3\Weapons_F\empty.p3d";
        direction[]={0,0,1};
        up[]={0,1,0};
        enableZoom = 0;
        zoomDuration = 1;
        position[]={0,0,4};
        positionBack[]={-0.5,-0.5,5};
    };

    class header : RSC(BaseText) {
        idc = IDC_ECHIDNA_SPAWN_HEADER;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W*40;
        h = GUI_ECHIDNA_H*2;
        style = "0x02";
        font = FONT_BOLD;
        sizeEx = GUI_ECHIDNA_H*1.8;
        colorBackground[] = {RAL5015,1};
        colorText[] = {RAL9005,1};
        text = CSTRING(HEADER);
    };

    class spare_back_1 : RSC(BaseText) {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_1;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W*20;
        h = GUI_ECHIDNA_H*13.5;
        colorBackground[] = {RAL9010,1};
    };
    class spare_back_2 : spare_back_1 {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_2;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*20;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W*20;
        h = GUI_ECHIDNA_H*27.5;
    };
    class spare_back_3 : spare_back_1 {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_3;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*0.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*2.5;
        w = GUI_ECHIDNA_W*19.5;
        h = GUI_ECHIDNA_H*10.5;
        colorBackground[] = {RAL9018,1};
    };
    class spare_back_4 : spare_back_1 {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_4;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W*20.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*2.5;
        w = GUI_ECHIDNA_W*19;
        h = GUI_ECHIDNA_H*20;
        colorBackground[] = {RAL9018,1};
    };
    class spare_back_5 : spare_back_1 {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_5;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W*0.5;
        h = GUI_ECHIDNA_H*27.5;
    };
    class spare_back_6 : spare_back_1 {
        idc = IDC_ECHIDNA_SPAWN_SPAREBACK_6;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H*27;
        w = GUI_ECHIDNA_W*40;
        h = GUI_ECHIDNA_H*0.5;
    };

};
