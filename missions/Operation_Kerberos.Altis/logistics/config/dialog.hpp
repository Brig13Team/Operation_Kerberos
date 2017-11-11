/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(helper) {
    idd = 10000;
    name = "Helper_Cargo";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;

    onLoad = "";
    onUnload = "";

    controlsBackground[] = {
        background
    };
    controls[] = {
        controlTable,
        controlTable2
    };

    class background: RSC(BaseText) {
        x = SafeZoneX + GUI_DISP_W*3 * 1;
        y = SafeZoneY + GUI_DISP_H*3 * 5;
        w = GUI_DISP_W*3 * 15;
        h = GUI_DISP_H*3 * 30;
        style = "0x02";
        font = FONT_BOLD;
        text = "";
        colorText[] = COLOR_BASE_WHITE;
        colorBackground[] = COLOR_BASE_BLACK;
    };

    class controlTable : RSC(ControlsTable) {
        idc = 10001;
        x = SafeZoneX + GUI_DISP_W*3 * 1.5;
        y = SafeZoneY + GUI_DISP_H*3 * 5.5;
        w = GUI_DISP_W*3 * 14;
        h = GUI_DISP_H*3 * 15;
        rowHeight = 1 * GUI_DISP_H*3;
        headerHeight = 1 * GUI_DISP_H*3;
        firstIDC = 10002;
        lastIDC = 10100;

        class RowTemplate {
            class RowBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*3 * 9;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = 4 * GUI_DISP_W*3;
                controlOffsetY = 0;
                controlH = 1 * GUI_DISP_H*3;
            };
            class Column2 {
                controlBaseClassPath[] = {"RscEdit"};
                columnX = 4 * GUI_DISP_W*3;
                columnW = 4 * GUI_DISP_W*3;
                controlOffsetY = 0.1 * GUI_DISP_H*3;
            };
            class Column3 {
                controlBaseClassPath[] = {"RscButton"};
                columnX = 12 * GUI_GRID_W;
                columnW = 2 * GUI_GRID_W;
                controlOffsetY = 0.1 * GUI_DISP_H*3;
            };
        };
        class HeaderTemplate {
            class HeaderBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*3 * 14;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 2* GUI_DISP_W*3;
                columnW = 12 * GUI_DISP_W*3;
                controlOffsetY = 0.1 * GUI_GRID_H;
                controlH = 0.8 * GUI_GRID_H;
            };
        };
    };

    class controlTable2 : RSC(ControlsTable) {
        idc = 11001;
        x = SafeZoneX + GUI_DISP_W*3 * 1.5;
        y = SafeZoneY + GUI_DISP_H*3 * 23.5;
        w = GUI_DISP_W*3 * 14;
        h = GUI_DISP_H*3 * 11;
        rowHeight = 1 * GUI_DISP_H*3;
        headerHeight = 1 * GUI_DISP_H*3;
        firstIDC = 11002;
        lastIDC = 11100;

        class RowTemplate {
            class RowBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*3 * 9;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = 4 * GUI_DISP_W*3;
                controlOffsetY = 0;
                controlH = 1 * GUI_DISP_H*3;
            };
            class Column2 {
                controlBaseClassPath[] = {"RscCheckbox"};
                columnX = 4 * GUI_DISP_W*3;
                columnW = 1 * GUI_DISP_W*3;
                controlOffsetY = 0.1 * GUI_DISP_H*3;
            };
        };
        class HeaderTemplate {
            class HeaderBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*3 * 14;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 2* GUI_DISP_W*3;
                columnW = 12 * GUI_DISP_W*3;
                controlOffsetY = 0.1 * GUI_GRID_H;
                controlH = 0.8 * GUI_GRID_H;
            };
        };
    };
};
