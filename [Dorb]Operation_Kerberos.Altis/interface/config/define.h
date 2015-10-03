#define UI_PFAD_ICON #\data\icon\
//#define UI_FONT "EtelkaNarrowMediumPro"
#define UI_FONT "PuristaMedium"


#define UI_CL_PROGRESS {0.486,0.988,0,1}
//"PuristaBold"
#define UI_CL_TEXT {0.98,0.98,0.824,1}
#define UI_CL_TEXT_DARK {0.098,0.098,0.439,1}
//TEXT
#define UI_CL_HEADER {0.502,0,0,1}
#define UI_CL_HEADER2 {0.722,0.525,0.043,1}
#define UI_CL_HEADER_TEXT {0.98,0.98,0.824,1}


//Gruen
#define UI_CL_BTN1		{0.678,1,0.184,1}
#define UI_CL_BTN1_foc	{0.486,0.988,0,1}
//Blau
#define UI_CL_BTN2		{0,0,0.545,1}
#define UI_CL_BTN2_foc	{0,0,1,1}
//ORange
#define UI_CL_BTN3		{1,0.843,0,1}
#define UI_CL_BTN3_foc	{1,1,0,1}
//Violett
#define UI_CL_BTN4		{0.78,0.082,0.522,1}
#define UI_CL_BTN4_foc	{1,0,1,1}
//Tuerkis
#define UI_CL_BTN5		{0,0.749,1,1}
#define UI_CL_BTN5_foc	{0.529,0.808,0.98,1}
//Rot
#define UI_CL_BTN6		{1,0.549,0,1}
#define UI_CL_BTN6_foc	{1,0.271,0,1}
//Weinrot
#define UI_CL_BTN7		{0,0.467,0,1}
#define UI_CL_BTN7_foc	{0,0.6,0,1}

// { 0,0.392,0,1}

//HEADER 0,0.392,0,1
#define UI_CL_BODY   {0.98,0.941,0.902,1}
#define UI_CL_BODY_TEXT {0.098,0.098,0.439,1}
// {0,0.502,0,1}
//BODY 0,0.502,0,1
//violett
#define UI_CL_CTRL_VIOLETT1 {0.78,0.082,0.522,1}
#define UI_CL_CTRL_VIOLETT2 {1,0,1,1}
//0.78,0.082,0.522,1
//1,0,1,1
//orange
//1,0.843,0,1
//1,1,0,1
//grün
#define UI_CL_CTRL_GRUEN1 {0.678,1,0.184,1}
#define UI_CL_CTRL_GRUEN2 {0.486,0.988,0,1}
//0.678,1,0.184,1
//0.486,0.988,0,1
//Tuerkis
//0,0.749,1,1
//0.529,0.808,0.98,1
//Blau
#define UI_CL_CTRL_BLUE1 {0,0,0.545,1}
#define UI_CL_CTRL_BLUE2 {0,0,1,1}
//  {0,0,0.545,1}
// {0,0,1,1}
//rot
#define UI_CL_CTRL_ROT1 {1,0.271,0,1}
#define UI_CL_CTRL_ROT2 {1,0.549,0,1}
//1,0.271,0,1
//1,0.549,0,1
//weinrot
#define UI_CL_CTRL_WEINROT1 {0.502,0,0,1}
#define UI_CL_CTRL_WEINROT2 {0.647,0.165,0.165,1}
//0.502,0,0,1
//0.647,0.165,0.165,1
#define UI_CL_CTRL_GRAU1 {0.863,0.863,0.863,1}
#define UI_CL_CTRL_GRAU2 {0.753,0.753,0.753,1}
#define UI_CL_CTRL_GRAU3 {0.502,0.502,0.502,1}
#define UI_CL_CTRL_GRAU4 {0.301,0.301,0.301,1}
//MAROON
#define UI_CL_CTRL_MAROON {0.502,0,0,1}

//#define UI_HEADER UI_GREEN_DARK
//#define UI_HEADER {0.196,0.804,0.196,1}
//#define UI_BODY UI_GREEN_DARK
//#define UI_BODY {0,1,0,1}

//#define UI_TEXT UI_WHITE_LINEN


// ArmA interface coordinates of the largest 4/3-format GUI area possible
#define _gui_max_dim (safeZoneW min safeZoneH)
#define _gui_start_x (0.5 - 0.5*_gui_max_dim)
#define _gui_start_y (0.5 - 0.5*_gui_max_dim)
#define _gui_w _gui_max_dim
#define _gui_h _gui_max_dim

// Macros to convert the GUI coordinates to arma interface coordinates
#define _get_gui_x(X) (_gui_start_x + (X)*_gui_w)
#define _get_gui_y(Y) (_gui_start_y + (Y)*_gui_h)
#define _get_gui_w(W) ((W)*_gui_w)
#define _get_gui_h(H) ((H)*_gui_h)

// ArmA interface coordinates of the virtual screen taking into account the GUI area
#define _screen_x _get_gui_x(0.05)
#define _screen_y _get_gui_y(0.05)
#define _screen_w _get_gui_w(0.9)
#define _screen_h _get_gui_h(0.9)

// Macros to convert virtual screen coordinates to arma interface coordinates
#define _get_screen_x(X) (_screen_x + (X)*_screen_w)
#define _get_screen_y(Y) (_screen_y + (Y)*_screen_h)
#define _get_screen_w(W) ((W)*_screen_w)
#define _get_screen_h(H) ((H)*_screen_h)

//////////////////////////////
// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400 

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4


class dorb_gui_backgroundBase {
	type = CT_STATIC;
	idc = -1;
	style = ST_CENTER;
	colorText[] = UI_CL_TEXT;
	colorBackground[] = UI_CL_HEADER;
	font = UI_FONT;
	text = "";
	sizeEx = _get_screen_h(0.04);
};

class dorb_gui_loadingbarBase {
	type = CT_PROGRESS;
	style = 0;
	colorFrame[] = UI_CL_CTRL_GRAU4;
	colorBar[] = UI_CL_CTRL_GRAU2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1;
	h = 0.03;
};


 class dorb_gui_comboX {
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_COMBO; // Control identification (without it, the control won't be displayed)
	type = CT_COMBO; // Type is 4
	style = ST_LEFT + LB_TEXTURES; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
	
	colorBackground[] = UI_CL_CTRL_WEINROT1; // Fill color
	colorSelectBackground[] = UI_CL_CTRL_WEINROT1; // Selected item fill color

			sizeEx = _get_screen_h(0.04); // Text size
			font = UI_FONT; // Font from CfgFontFamilies
			shadow = 0; // Shadow (0 - none, 1 - N/A, 2 - black outline)
			colorText[] = UI_CL_TEXT; // Text and frame color
			colorDisabled[] = UI_CL_TEXT; // Disabled text color
			colorSelect[] = UI_CL_TEXT; // Text selection color
			
			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = ""; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa"; // Expand arrow
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa"; // Collapse arrow

			wholeHeight = h = _get_screen_h(0.1); // Maximum height of expanded box (including the control height)
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it

			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1}; // Sound played when the list is expanded
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1}; // Sound played when the list is collapsed
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ComboScrollBar
			{
				width = 0; // width of ComboScrollBar
				height = 0; // height of ComboScrollBar
				scrollSpeed = 0.01; // scrollSpeed of ComboScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};

			onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			onDestroy = "systemChat str ['onDestroy',_this]; false";
			onSetFocus = "systemChat str ['onSetFocus',_this]; false";
			onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
			onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
			onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			onMouseMoving = "";
			onMouseHolding = "";

			onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
};
class dorb_gui_Button {
	access = 0;
	type = CT_BUTTON;
	style = ST_CENTER;
	text = "";
	font = UI_FONT;
	sizeEx = _get_screen_h(0.04);
	colorText[] = UI_CL_TEXT;
	colorDisabled[] = {0.3,0.3,0.3,1};
	colorBackground[] = UI_CL_CTRL_GRUEN2;
	colorBackgroundActive[] = UI_CL_CTRL_GRUEN1;
	colorFocused[] = UI_CL_CTRL_GRUEN2;
	colorBackgroundDisabled[] = {0.6,0.6,0.6,1};
	offsetX = 0.004;
	offsetY = 0.004;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = {0,0,0,1};
	shadow = 0;
	colorBorder[] = {0,0,0,1};
	borderSize = 0;
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	onButtonClick = "";
};
class dorb_gui_shctButton : dorb_gui_Button {
	type = 16;
	style = 48;
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 1.0;
		bottom = 1.0;
	};
	class ShortcutPos {
		left = 0;
		top = 0;
		w = 0.3;
		h = 0.7;
	};
	class TextPos {
		left = 0.001;
		top = 0.0001;
		right = 0.0001;
		bottom = 0.0001;
	};
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(0.3,0.3,0.3,1)";
	animTextureOver = "#(argb,8,8,3)color(0.8,0.3,0,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,0.5,0,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,0,0,1)";
	animTextureDefault = "#(argb,8,8,3)color(0,1,0,1)";
	period = 0.1;
	periodFocus = 0.4;
	periodOver = 0.4;
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = UI_CL_CTRL_GRUEN2;
	color2[] = UI_CL_TEXT;
	colorDisabled[] = {0,0,0,0.3};
	colorBackground[] = UI_CL_CTRL_GRUEN1;
	colorBackground2[] = UI_CL_CTRL_GRUEN2;
	colorBackgroundfocused[] = UI_CL_CTRL_GRUEN1;
	text = "";
	shadow = 1;
	size = _get_screen_h(0.04);
	class Attributes {
		font = "TahomaB";
		color = UI_TEXT;
		align = "left";
		shadow = 1;
	};
	class AttributesImages {
		font = UI_FONT;
		color = UI_TEXT;
		align = "left";
	};
};
 class dorb_gui_listbox {
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
	type = CT_LISTBOX; // Type is 5
	style = ST_LEFT + LB_TEXTURES; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
		
	colorBackground[] = UI_CL_CTRL_GRAU3; // Fill color
	colorSelectBackground[] = UI_CL_CTRL_GRAU2; // Selected item fill color
	colorSelectBackground2[] = UI_CL_CTRL_GRAU2; // Selected item fill color (oscillates between this and colorSelectBackground)

	sizeEx = _get_screen_h(0.04); // Text size
	font = UI_FONT; // Font from CfgFontFamilies
	shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
	colorText[] = UI_CL_TEXT; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorSelect[] = UI_CL_TEXT; // Text selection color
	colorSelect2[] = UI_CL_TEXT; // Text selection color (oscillates between this and colorSelect)
	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = ""; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

			rowHeight = _get_screen_h(0.07); // Row height
			itemSpacing = 0; // Height of empty space between items
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it
			canDrag = 0; // 1 (true) to allow item dragging

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ListScrollBar //In older games this class is "ScrollBar"
			{
				width = 0; // width of ListScrollBar
				height = 0; // height of ListScrollBar
				scrollSpeed = 0.01; // scroll speed of ListScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = UI_CL_CTRL_GRAU3; // Scrollbar color
			};

			onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			onDestroy = "systemChat str ['onDestroy',_this]; false";
			onSetFocus = "systemChat str ['onSetFocus',_this]; false";
			onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
			onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
			onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			onMouseMoving = "";
			onMouseHolding = "";

			onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
			onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
			onLBDrag = "systemChat str ['onLBDrag',_this]; false";
			onLBDragging = "systemChat str ['onLBDragging',_this]; false";
			onLBDrop = "systemChat str ['onLBDrop',_this]; false";
};
class dorb_gui_pictureBase : dorb_gui_backgroundBase {
	style = ST_PICTURE;
};
class dorb_gui_treeBase {
		access = 0;
		idc = -1;
		type = CT_TREE; // 12
		style = ST_MULTI;
		default = 0;
		blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

			colorBorder[] = {0,0,0,1}; // Frame color

		colorBackground[] = {0, 0, 0, 1};
			colorSelect[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 0)
			colorMarked[] = {0.95,0.95,0.95,1}; // Marked item fill color (when multiselectEnabled is 1)
			colorMarkedSelected[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 1)

		sizeEx = 0.031;
		font = FontCSE;
		shadow = 2;
		colorText[] = {0.543, 0.5742, 0.4102, 1.0}; // Text color
		colorSelectText[] = {0.95,0.95,0.95,1}; // Selected text color (when multiselectEnabled is 0)
		colorMarkedText[] = {0.95,0.95,0.95,1}; // Selected text color (when multiselectEnabled is 1)

			tooltip = "";
			tooltipColorShade[] = {0,0,0,1};
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {1,1,1,1};

		multiselectEnabled = 0;
		expandOnDoubleclick = 1;
		hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
		expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
		maxHistoryDelay = 1;

			
			class ScrollBar
			{
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				autoScrollDelay = 5;
				autoScrollEnabled = 0;
				autoScrollRewind = 0;
				autoScrollSpeed = -1;
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				height = 0;
				scrollSpeed = 0.06;
				shadow = 0;
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				width = 0;
			};

			colorDisabled[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown
			colorArrow[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown

			
	};
	
class dorb_gui_editBase {
	access = 0;
	type = CT_EDIT;
	style = ST_LEFT+ST_FRAME;
	colorBackground[] = UI_CL_CTRL_GRAU1;
	colorText[] = UI_CL_BODY_TEXT;
	colorSelection[] = UI_CL_CTRL_GRAU2;
	colorDisabled[] = UI_CL_CTRL_GRAU3;
	font = UI_FONT;
	sizeEx = _get_screen_h(0.04);
	autocomplete = "";
	text = "";
	size = _get_screen_h(0.02);
	shadow = 0;
};
class dorb_gui_listboxN {
	access = 0; // allow alterations / additions to, but not erasure of, tokennames in this class.
             // this equally affects child classes. they cannot be removed, nor can their tokenNames be erased, only altered
             // to completely remove or alter a child class (in this case scrollbar), this parent class must be inherited
             // then again, perhaps irrelevant, perhaps it's simply being a root class that causes all this
	type = CT_LISTNBOX;// 102; 
	style = ST_MULTI;
	font = UI_FONT; 
	sizeEx = _get_screen_h(0.04);
	colorText[] = UI_CL_BODY_TEXT; 
	colorBackground[] = UI_CL_CTRL_GRAU3; 
	canDrag = false;
	
	autoScrollSpeed = -1; 
	autoScrollDelay = 5; 
	autoScrollRewind = 0; 
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
	columns[] = {0.3, 0.6, 0.7}; 
	color[] = UI_CL_CTRL_GRAU3; 
	colorScrollbar[] = UI_CL_CTRL_GRAU2; 
	colorSelect[] = UI_CL_CTRL_GRAU3; 
	colorSelect2[] = UI_CL_CTRL_GRAU3; 
	colorDisabled[] = UI_CL_CTRL_GRAU3;
	colorSelectBackground[] = UI_CL_CTRL_GRAU1; 
	colorSelectBackground2[] = UI_CL_CTRL_GRAU1; 
	
	
	pictureColor[] = UI_CL_CTRL_GRAU3; // Picture color
	pictureColorSelect[] = UI_CL_CTRL_GRAU4; // Selected picture color
	pictureColorDisabled[] = UI_CL_CTRL_GRAU1; // Disabled picture color
	
	drawSideArrows = 0; 
	idcLeft = -1; 
	idcRight = -1; 
	maxHistoryDelay = 1; 
	rowHeight = 0; 
	soundSelect[] = {"", 0.1, 1}; 
	period = 1; 
	lineSpacing = 1;
	shadow = 0; 
	class ScrollBar {
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = UI_CL_CTRL_GRAU3;
		colorActive[] = UI_CL_CTRL_GRAU1;
		colorDisabled[] = UI_CL_CTRL_GRAU1;
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
	};
	class ListScrollBar {
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = UI_CL_CTRL_GRAU3;
		colorActive[] = UI_CL_CTRL_GRAU1;
		colorDisabled[] = UI_CL_CTRL_GRAU1;
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};

};
class dorb_gui_combo {
	access = 0;
	type = CT_COMBO;
	style = ST_LEFT;
	h = 0.05;
	wholeHeight = 0.25;
	colorSelect[] = {0.6,0.6,0.6,1};
	colorText[] = {1,1,1,1};
	colorBackground[] = {0.2,0.2,0.2,1};
	colorScrollbar[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.5};
	font = "TahomaB";
	sizeEx = 0.04;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1.0;
	shadow = 0;
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa"; // Expand arrow
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa"; // Collapse arrow
	class ComboScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
		shadow = 0;
	};
};
class dorb_gui_StructuredText {
  idc = -1; 
  type = CT_STRUCTURED_TEXT;  // defined constant
  style = ST_LEFT;            // defined constant
  colorBackground[] = UI_CL_CTRL_GRAU2; 
  x = 0.1; 
  y = 0.1; 
  w = 0.3; 
  h = 0.1; 
  size = 0.018;
  text = "";
/*  class Attributes {
    font = "TahomaB";
    color = "#000000";
    align = "center";
    valign = "middle";
    shadow = false;
    shadowColor = "#ff0000";
    size = "1";
 };*/
};