/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Grid Definitions
 *
 */
#define GUI_GRID_WAbs ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W (GUI_GRID_WAbs / 40)
#define GUI_GRID_H (GUI_GRID_HAbs / 25)
#define GUI_GRID_X (safezoneX)
#define GUI_GRID_Y (safezoneY + safezoneH - GUI_GRID_HAbs)


//--- Screen Center
#define GUI_GRID_CENTER_WAbs GUI_GRID_WAbs
#define GUI_GRID_CENTER_HAbs GUI_GRID_HAbs
#define GUI_GRID_CENTER_W GUI_GRID_W
#define GUI_GRID_CENTER_H GUI_GRID_H
#define GUI_GRID_CENTER_X (safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y (safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

#define GUI_MSG_X (safezoneX + 0.5 * GUI_GRID_W)
//#define GUI_MSG_Y (5 * GUI_GRID_H + safezoneY) ((5 * GUI_GRID_H  + safezoneY)+(5 * IGUI_TEXT_SIZE_MEDIUM))
#define GUI_MSG_Y ((5 * GUI_GRID_H  + safezoneY)+(5 * IGUI_TEXT_SIZE_MEDIUM))
#define GUI_MSG_W (10 * GUI_GRID_W)
#define GUI_MSG_H (4 * GUI_GRID_H)
#define GUI_MSG_HEAD (1 * GUI_GRID_H)
#define GUI_MSG_COL (0.2 * GUI_GRID_W)
#define GUI_MSG_TEXT (3 * GUI_GRID_H)

#define GUI_NOTIFICATION_X (safezoneX + 0.5 * GUI_GRID_W)
#define GUI_NOTIFICATION_Y (safezoneY + safezoneH - 3 * GUI_GRID_H)
#define GUI_NOTIFICATION_H (2 * GUI_GRID_H)
#define GUI_NOTIFICATION_W (2 * GUI_GRID_W)

#define GUI_LOADINGBAR_HEADER_X (safezoneX + 0.5 * GUI_GRID_W)
#define GUI_LOADINGBAR_HEADER_Y (safezoneY + safezoneH - 10.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_HEADER_H (1.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_HEADER_W (8 * GUI_GRID_W)
#define GUI_LOADINGBAR_X (safezoneX + 0.5 * GUI_GRID_W)
#define GUI_LOADINGBAR_Y (safezoneY + safezoneH - 9 * GUI_GRID_H)
#define GUI_LOADINGBAR_H (1.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_W (13.5 * GUI_GRID_W)
#define GUI_LOADINGBAR_SYMBOL_X (safezoneX + 0.6 * GUI_GRID_W)
#define GUI_LOADINGBAR_SYMBOL_Y (safezoneY + safezoneH - 9.2 * GUI_GRID_H)
#define GUI_LOADINGBAR_SYMBOL_H (1.3 * GUI_GRID_H)
#define GUI_LOADINGBAR_SYMBOL_W (1.3 * GUI_GRID_W)
#define GUI_LOADINGBAR_BAR_X (safezoneX + 2 * GUI_GRID_W)
#define GUI_LOADINGBAR_BAR_Y (safezoneY + safezoneH - 9 * GUI_GRID_H)
#define GUI_LOADINGBAR_BAR_H (1.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_BAR_W (12 * GUI_GRID_W)
#define GUI_LOADINGBAR_STATE_X (safezoneX + 1.25 * GUI_GRID_W)
#define GUI_LOADINGBAR_STATE_Y (safezoneY + safezoneH - 6.75 * GUI_GRID_H)
#define GUI_LOADINGBAR_STATE_H (0.6 * GUI_GRID_H)
#define GUI_LOADINGBAR_STATE_W (1.5 * GUI_GRID_W)
#define GUI_LOADINGBAR_ARROW_X (safezoneX + 1 * GUI_GRID_W)
#define GUI_LOADINGBAR_ARROW_Y (safezoneY + safezoneH - 7.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_ARROW_H (1.5 * GUI_GRID_H)
#define GUI_LOADINGBAR_ARROW_W (2 * GUI_GRID_W)

#define GUI_GRID_TABLET_BTTN_W (2*((GUI_GRID_CENTER_W * 40)/16))
#define GUI_GRID_TABLET_BTTN_H (2*((GUI_GRID_CENTER_H * 25)/10))
#define GUI_GRID_TABLET_BTTN_DIS_W (GUI_GRID_TABLET_BTTN_W * 0.1)
#define GUI_GRID_TABLET_BTTN_DIS_H (GUI_GRID_TABLET_BTTN_H * 0.1)
#define GUI_GRID_TABLET_BTTN_X (GUI_GRID_CENTER_X + 1 * GUI_GRID_TABLET_BTTN_W)
#define GUI_GRID_TABLET_BTTN_Y (GUI_GRID_CENTER_Y + 0.5 * GUI_GRID_TABLET_BTTN_H)

#define GUI_GRID_TABLET_BTTN_W (2*((GUI_GRID_CENTER_W * 38)/16))
#define GUI_GRID_TABLET_BTTN_H (2*((GUI_GRID_CENTER_H * 21)/10))
#define GUI_GRID_TABLET_BTTN_DIS_W (GUI_GRID_TABLET_BTTN_W * 0.1)
#define GUI_GRID_TABLET_BTTN_DIS_H (GUI_GRID_TABLET_BTTN_H * 0.1)
#define GUI_GRID_TABLET_BTTN_X (GUI_GRID_CENTER_X + GUI_GRID_CENTER_W)
#define GUI_GRID_TABLET_BTTN_Y (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H)
