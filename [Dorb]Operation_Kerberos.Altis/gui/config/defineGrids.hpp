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
