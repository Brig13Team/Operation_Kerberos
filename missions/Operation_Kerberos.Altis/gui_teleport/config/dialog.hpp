/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_TELEPORT;
    name = "Teleporter";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    controlsBackground[] = {
        background_taskbar,
        background_display,
        table_background
    };
    controls[] = {
        clock,
        menu_button,

        map_bttn_background,
        map_bttn,

        controlTable,

        metro_back,
        metro,
        metro_side,
        background_device
    };


    #define BUTTON_HELPER(NUMBER) class DOUBLES(map_bttn,background) : RSC(BasePicture) { \
        idc = -(IDC_ECHIDNA_TELEPORT_BTTN_MAP); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        colorBackground[] = {0,0,0,1}; \
        colorText[] = {0,0,0,1}; \
    }; \
    class map_bttn : RSC(BaseButton) { \
        idc = IDC_ECHIDNA_TELEPORT_BTTN_MAP; \
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


    class table_background: RSC(BaseText) {
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 1;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 1;
        w = GUI_ECHIDNA_W * 30;
        h = GUI_ECHIDNA_H * 25.5;
        style = "0x02";
        font = GUI_FONT_BOLD;
        text = "";
        colorText[] = COLOR_TABLET_MAIN_TEXT;
        colorBackground[] = {RAL9005,0.2};
    };

    class controlTable : RSC(ControlsTable) {
        idc = IDC_ECHIDNA_TELEPORT_TABLE;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 1;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 1;
        w = GUI_ECHIDNA_W * 30;
        h = GUI_ECHIDNA_H * 25.5;
        rowHeight = 1 * GUI_ECHIDNA_H;
        headerHeight = 1 * GUI_ECHIDNA_H;
        firstIDC = IDC_ECHIDNA_TELEPORT_TABLE_FIRST;
        lastIDC = IDC_ECHIDNA_TELEPORT_TABLE_LAST;

        class RowTemplate {
            class RowBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_ECHIDNA_W * 29.5;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = 2 * GUI_ECHIDNA_W;
                controlOffsetY = 0;
                controlH = 1 * GUI_ECHIDNA_H;
            };
            class Column2 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 2 * GUI_ECHIDNA_W;
                columnW = 23 * GUI_ECHIDNA_W;
                controlOffsetY = 0.1 * GUI_ECHIDNA_H;
            };
            class Column3 {
                controlBaseClassPath[] = {"RscButton"};
                columnX = 25 * GUI_GRID_W;
                columnW = 5 * GUI_GRID_W;
                controlOffsetY = 0.1 * GUI_ECHIDNA_H;
            };
        };
        class HeaderTemplate {
            class HeaderBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_ECHIDNA_W * 29.5;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 2* GUI_ECHIDNA_W;
                columnW = 25 * GUI_ECHIDNA_W;
                controlOffsetY = 0.1 * GUI_GRID_H;
                controlH = 0.8 * GUI_GRID_H;
            };
        };
    };
};
