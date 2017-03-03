/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_val_x","_val_y","_val_w","_val_h"];

#define UI_GRID_W (pixelW * pixelGrid) // One grid width
#define UI_GRID_H (pixelH * pixelGrid) // One grid height
#define UI_GUTTER_W (pixelW * 2)       // One “gutter” width
#define UI_GUTTER_H (pixelH * 2)       // One “gutter” height

#define UI_MAX_GRID (floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/4)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/3)))

// first we get the maximum display size with the 4:3 Ratio
#define GUI_DISP_Abs (floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/4)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/3)))
#define GUI_DISP_WAbs (4*GUI_DISP_Abs)
#define GUI_DISP_HAbs (3*GUI_DISP_Abs)

// the maximum 4:3 display is reduced by 25% to make it possible to view the frame
#define GUI_ECHIDNA_WAbs (0.75*GUI_DISP_WAbs*pixelW * pixelGridNoUIScale)
#define GUI_ECHIDNA_HAbs (0.75*GUI_DISP_HAbs*pixelH * pixelGridNoUIScale)
#define GUI_ECHIDNA_X (0.5-0.5*GUI_ECHIDNA_WAbs)
#define GUI_ECHIDNA_Y (0.5-0.5*GUI_ECHIDNA_HAbs)
#define GUI_ECHIDNA_W (GUI_ECHIDNA_WAbs/40)
#define GUI_ECHIDNA_H (GUI_ECHIDNA_HAbs/30)

#define GUI_DISPLAY_GRID_W (0.9*4*(floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/4)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/3))))
#define GUI_DISPLAY_GRID_H (0.9*3*(floor(((SafeZoneW/(pixelW*pixelGridNoUIScale))/4)min((SafeZoneH/(pixelH*pixelGridNoUIScale))/3))))


//_val_x = 0.5 - pixelW * pixelGridNoUIScale * 0.5 * GUI_DISPLAY_GRID_W;
//_val_y = 0.5 - pixelH * pixelGridNoUIScale * 0.5 * GUI_DISPLAY_GRID_H;
//_val_w = pixelW * pixelGridNoUIScale * GUI_DISPLAY_GRID_W;
//_val_h = pixelH * pixelGridNoUIScale * GUI_DISPLAY_GRID_H;

_val_x = GUI_ECHIDNA_X;
_val_y = GUI_ECHIDNA_Y;
_val_w = GUI_ECHIDNA_WAbs;
_val_h = GUI_ECHIDNA_HAbs;

hint parseText format["x=%1< /br>y=%2< /br>w=%3< /br>h=%4",_val_x,_val_y,_val_w,_val_h];


/*
_val_x = 0.5 - pixelW * pixelGridNoUIScale * 55;
_val_y = 0.5 - pixelH * pixelGridNoUIScale * 30;
_val_w = pixelW * pixelGridNoUIScale * 110;
_val_h = pixelH * pixelGridNoUIScale * 60;
*/
disableSerialization;

createDialog "adtest";

private _ctrl = ((findDisplay 1000) displayCtrl 1001);

_ctrl ctrlSetPosition [_val_x, _val_y, _val_w, _val_h];
_ctrl ctrlSetBackgroundColor [0,0,0,0.5];
_ctrl ctrlCommit 0;


_val_x = GUI_ECHIDNA_X;
_val_y = GUI_ECHIDNA_Y + GUI_ECHIDNA_WAbs - GUI_ECHIDNA_H * 2.5;
_val_w = GUI_ECHIDNA_WAbs;
_val_h = GUI_ECHIDNA_H * 2.5;

private _ctrl = ((findDisplay 1000) displayCtrl 1002);

_ctrl ctrlSetPosition [_val_x, _val_y, _val_w, _val_h];
_ctrl ctrlSetBackgroundColor [0,0,0,1];
_ctrl ctrlCommit 0;
