/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Grid Definitions
 *
 */

// the maximum display size with the 4:3 Ratio -> should be used for the most Interface-dialogs.
#define GUI_DLG_Abs (floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/4)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/3)))
#define GUI_DLG_WAbs (4*GUI_DLG_Abs*pixelW * pixelGridNoUIScale)
#define GUI_DLG_HAbs (3*GUI_DLG_Abs*pixelH * pixelGridNoUIScale)
#define GUI_DLG_X (0.5-0.5*GUI_DLG_WAbs)
#define GUI_DLG_Y (0.5-0.5*GUI_DLG_HAbs)
#define GUI_DLG_W (GUI_DLG_WAbs/40)
#define GUI_DLG_H (GUI_DLG_HAbs/25)

// the maximum display size with the 16:9 Ratio
#define GUI_DISP_Abs (floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/16)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/9)))
#define GUI_DISP_WAbs (16*GUI_DISP_Abs*pixelW*pixelGridNoUIScale)
#define GUI_DISP_HAbs (9*GUI_DISP_Abs*pixelH*pixelGridNoUIScale)
#define GUI_DISP_X (0.5-0.5*GUI_DISP_WAbs)
#define GUI_DISP_Y (0.5-0.5*GUI_DISP_HAbs)
#define GUI_DISP_W (GUI_DISP_WAbs/160)
#define GUI_DISP_H (GUI_DISP_HAbs/90)

#define GUI_MSG_X (safezoneX+GUI_DISP_W)
#define GUI_MSG_Y (0)
#define GUI_MSG_W (GUI_DISP_W*20)
#define GUI_MSG_H (GUI_DISP_H*8)
#define GUI_MSG_HEAD (GUI_DISP_H*2)
#define GUI_MSG_COL (GUI_DISP_W*0.2)
#define GUI_MSG_TEXT (GUI_DISP_H*6)
#define GUI_MSG_TEXTSIZE (GUI_MSG_HEAD)

#define GUI_NOTIFICATION_X (safezoneX+GUI_DISP_W*2)
#define GUI_NOTIFICATION_Y (safezoneY+safezoneH-8*GUI_DISP_H)
#define GUI_NOTIFICATION_H (GUI_DISP_H*6)
#define GUI_NOTIFICATION_W (GUI_DISP_W*12)
#define GUI_NOTIFICATION_NEXT_X (GUI_NOTIFICATION_W*0.75)
#define GUI_NOTIFICATION_PIC_X (GUI_NOTIFICATION_X+GUI_NOTIFICATION_W*0.25)
#define GUI_NOTIFICATION_PIC_W (GUI_NOTIFICATION_W*0.5)

#define TEXT_SIZE_SMALL (GUI_DLG_H*0.8)
#define TEXT_SIZE_MEDIUM (GUI_DLG_H*1)
#define TEXT_SIZE_LARGE (GUI_DLG_H*1.2)


/*
 *  Old Version below only for backwards compatibility
 * TODO: Remove this
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

#define GUI_TIMER_BACK_X (safezoneX + 0.5 * GUI_GRID_W)
#define GUI_TIMER_BACK_Y (safezoneY + safezoneH - 5.5 * GUI_GRID_H)
#define GUI_TIMER_BACK_H (2 * GUI_GRID_H)
#define GUI_TIMER_BACK_W (4 * GUI_GRID_W)
#define GUI_TIMER_PIC_X GUI_TIMER_BACK_X
#define GUI_TIMER_PIC_Y GUI_TIMER_BACK_Y
#define GUI_TIMER_PIC_H (2 * GUI_GRID_H)
#define GUI_TIMER_PIC_W (2 * GUI_GRID_W)
#define GUI_TIMER_TEXT_X (GUI_TIMER_BACK_X + GUI_TIMER_PIC_W * 0.9)
#define GUI_TIMER_TEXT_Y GUI_TIMER_BACK_Y
#define GUI_TIMER_TEXT_H (2 * GUI_GRID_H)
#define GUI_TIMER_TEXT_W (1.8 * GUI_GRID_W)

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
