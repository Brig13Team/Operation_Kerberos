///////////////////////////////////////////////////////////////////////////
/// Text Sizes
///////////////////////////////////////////////////////////////////////////
//MUF - text sizes are using new grid (40/25)
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

#define IGUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 0.8)


///////////////////////////////////////////////////////////////////////////
/// Fonts
///////////////////////////////////////////////////////////////////////////

//Changed by MUF - TODO: set proper fonts when available - PREPARED FOR FONT CHANGE (was Zeppelin32Mono, changed to Purista/Etelka)

//GUI_FONT_MONO - used for optics active parts
//GUI_FONT_BOLD - used for titles
#define GUI_FONT_NORMAL			RobotoCondensed
#define GUI_FONT_BOLD			RobotoCondensedBold
#define GUI_FONT_THIN			RobotoCondensedLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro

#define GUI_FONT_CODE			LucidaConsoleB	//Deprecated - for engine debug only (has only two sizes, which causes errors).
#define GUI_FONT_SYSTEM			TahomaB		//Deprecated - for engine debug only (has only one size, which causes errors).

///////////////////////////////////////////////////////////////////////////
/// Sizes
///////////////////////////////////////////////////////////////////////////

//--------------------------------------------------MUF-made a bit bigger for Purista font - TODO: find out precise values
// #define TextSize_xsmall			0.014
// #define TextSize_IGUI_normal		0.0234375
// #define TextSize_small			0.02674
// #define TextSize_normal			0.02674
// #define TextSize_medium			0.0286458
// #define TextSize_big			0.0325521

// #define TextSize_xsmall			0.02   //new values used in A3 with Purista font - won't be used when TKOH GUI merged
// #define TextSize_IGUI_normal	0.024
// #define TextSize_small			0.03
// #define TextSize_normal			0.03
// #define TextSize_medium			0.032
// #define TextSize_big			0.033
//--------------------------------------------------MUF-made a bit bigger for Purista font



#define SizeMapMarker			32

#define blinkPeriod			1

//dimension of bitmaps to be mapped 1:1 in 720p
#define w16 0.0196078
#define h16 0.0261438

#define w32 0.0392157
#define h32 0.0522876

#define w64 0.0784314
#define h64 0.1045752

#define w128 0.1568627
#define h128 0.2091503

#define w256 0.3137255
#define h256 0.4183007

#define w512 0.6274510
#define h512 0.8366013

#define w1024 1.2549020
#define h1024 1.6732026

#define w2048 2.5098039
#define h2048 3.3464052

///////////////////////////////////////////////////////////////////////////
/// IGUI fading times
///////////////////////////////////////////////////////////////////////////
#define DIMM_START	0
#define DIMM_END	0.3


///////////////////////////////////////////////////////////////////////////
/// Other
///////////////////////////////////////////////////////////////////////////
#define TOSTRING(TEXT)	#TEXT

#define	flag_west	"A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_bluefor_ca.paa"
#define	flag_east	"A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_opfor_ca.paa"
#define	flag_guer	"A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_indep_ca.paa"
#define	flag_civl	"A3\ui_f\data\gui\rsc\RscDisplayMultiplayerSetup\flag_civil_ca.paa"

#define KEY_HINT(name, dik, text) class name {key = dik; hint = "";}
