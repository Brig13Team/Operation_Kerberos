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

#define GUI_TIMER_BACK_X (safezoneX+GUI_DISP_W*2)
#define GUI_TIMER_BACK_Y (0-GUI_DISP_H*5)
#define GUI_TIMER_BACK_H (GUI_DISP_H*4)
#define GUI_TIMER_BACK_W (GUI_DISP_W*15)
#define GUI_TIMER_PIC_X GUI_TIMER_BACK_X
#define GUI_TIMER_PIC_Y GUI_TIMER_BACK_Y
#define GUI_TIMER_PIC_W (GUI_DISP_W*4)
#define GUI_TIMER_PIC_H GUI_TIMER_BACK_H
#define GUI_TIMER_TEXT_X (GUI_TIMER_BACK_X+GUI_DISP_W*5)
#define GUI_TIMER_TEXT_Y GUI_TIMER_BACK_Y
#define GUI_TIMER_TEXT_W (GUI_DISP_W*10)
#define GUI_TIMER_TEXT_H (GUI_DISP_H*4)

#define GUI_LOADINGBAR_HEADER_X (GUI_DISP_X+GUI_DISP_W*50)
#define GUI_LOADINGBAR_HEADER_Y (GUI_DISP_Y+GUI_DISP_H*30)
#define GUI_LOADINGBAR_HEADER_H (GUI_DISP_H*4)
#define GUI_LOADINGBAR_HEADER_W (GUI_DISP_W*22)
#define GUI_LOADINGBAR_X (GUI_DISP_X+GUI_DISP_W*50)
#define GUI_LOADINGBAR_Y (GUI_DISP_Y+GUI_DISP_Y*34)
#define GUI_LOADINGBAR_H (GUI_DISP_H*4)
#define GUI_LOADINGBAR_W (GUI_DISP_W*37)
#define GUI_LOADINGBAR_SYMBOL_X (GUI_DISP_X+GUI_DISP_W*51)
#define GUI_LOADINGBAR_SYMBOL_Y (GUI_DISP_Y+GUI_DISP_H*35)
#define GUI_LOADINGBAR_SYMBOL_H (GUI_DISP_H*3)
#define GUI_LOADINGBAR_SYMBOL_W (GUI_DISP_W*3)
#define GUI_LOADINGBAR_BAR_X (GUI_DISP_X+GUI_DISP_W*55)
#define GUI_LOADINGBAR_BAR_Y (GUI_DISP_Y+GUI_DISP_H*34)
#define GUI_LOADINGBAR_BAR_H (GUI_DISP_H*4)
#define GUI_LOADINGBAR_BAR_W (GUI_DISP_W*33)
#define GUI_LOADINGBAR_STATE_X (GUI_DISP_X+GUI_DISP_W*53)
#define GUI_LOADINGBAR_STATE_Y (GUI_DISP_Y+GUI_DISP_H*40)
#define GUI_LOADINGBAR_STATE_H (GUI_DISP_H*1.5)
#define GUI_LOADINGBAR_STATE_W (GUI_DISP_W*4)
#define GUI_LOADINGBAR_ARROW_X (GUI_DISP_X+GUI_DISP_W*52)
#define GUI_LOADINGBAR_ARROW_Y (GUI_DISP_Y+GUI_DISP_H*38)
#define GUI_LOADINGBAR_ARROW_H (GUI_DISP_H*4)
#define GUI_LOADINGBAR_ARROW_W (GUI_DISP_W*5)


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

