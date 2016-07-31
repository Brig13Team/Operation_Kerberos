/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

#include "\a3\ui_f\hpp\defineCommon.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"


/// CI
#define DORB_GUI_COL_BACKGROUND {RAL9011,0.75}




/// Messaging

#define DORB_GUI_MSG_X (safezoneX + 0.5 * GUI_GRID_W)
#define DORB_GUI_MSG_Y (5 * GUI_GRID_H + safezoneY)
#define DORB_GUI_MSG_W (10 * GUI_GRID_W)
#define DORB_GUI_MSG_H (4 * GUI_GRID_H)
#define DORB_GUI_MSG_HEAD (1 * GUI_GRID_H)
#define DORB_GUI_MSG_COL (0.2 * GUI_GRID_W)
#define DORB_GUI_MSG_TEXT (3 * GUI_GRID_H)






class dorb2_gui_new_RscStructuredText {
    idc = -1; 
    type = 13;  // defined constant
    style = 0x00;            // defined constant
    colorBackground[] = DORB_GUI_COL_BACKGROUND; 
    size = GUI_TEXT_SIZE_MEDIUM;
    text = "";
    class Attributes {
        font = GUI_FONT_NORMAL;
        color = "#000000";
        align = "left";
        valign = "middle";
        shadow = 0;
        shadowColor = "#ff0000";
        size = 1;
    };
};
class dorb2_gui_new_RscText {
    access = 0;
    type = 0;
    idc = -1;
    style = 0x00;
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_TEXT_SIZE_MEDIUM;
    colorBackground[] = DORB_GUI_COL_BACKGROUND; 
    colorText[] = {RAL7047,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};




