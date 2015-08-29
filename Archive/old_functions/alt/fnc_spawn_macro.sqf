/*
	Author: Dorbedo

	Description:
		Spawns predefined defencepositions

	Parameter(s):
		0 : ARRAY	- Position
		(optional)
		1 :	SCALAR	- Type
		2 :	SCALAR	- Direction
	
	Makros:
	1	-	Mortarpos(medium)
	2	-	Mortarpos(heavy)
	3	-	Device-Defence
	4	-	Small MG
	5	-	AA-Position
	6	-	MG/AT-Position
	7	-	Military Tower
	8	-	Mortarpos(small)
	
	(RDS)
	100	-	AA-Pos

*/
#include "script_component.hpp"

DEFAULT_PARAM(0,_position,[]);
CHECK(_position isEqualTo [])
DEFAULT_PARAM(1,_type,-1);
DEFAULT_PARAM(2,_dir,0);
private["_makro"];
//If (_type < 0) then {_type = floor(random 3);};
_makro = [];

switch (_type) do {
	/// Mortarpos
	case 1 : {_makro = [	["CamoNet_BLUFOR_Curator_F",[6.90625,-1.03516,-0.00143909],94.0229],
						["Land_HBarrier_Big_F",[-8.79541,-0.799316,-0.00143909],270],
						["Land_HBarrier_Big_F",[6.85254,-7.86816,-0.00143909],321],
						["Land_HBarrier_Big_F",[-4.8916,-8.06836,-0.00143909],218],
						["Land_HBarrier_Big_F",[1.02344,-14.2632,-0.00143909],1],
						["Land_Cargo10_orange_F",[-5.40308,-1.08447,-0.00143576],0.00266482],
						["B_Mortar_01_F",[0.579346,-0.28125,0.0386391],357.285],
						["Land_Pallet_MilBoxes_F",[6.93945,-4.12402,-0.00143909],0],
						["Land_PaperBox_closed_F",[7.03931,-1.9375,-0.00143909],0],
						["Land_BagFence_Short_F",[0.6875,-1.80615,-0.000439167],0],
						["Land_BagFence_Corner_F",[-0.779053,-1.51758,-0.000439167],179.725],
						["Land_BagFence_Corner_F",[1.86646,-1.45508,-0.000439167],93.6522],
						["Land_HBarrier_Big_F",[6.21826,6.80176,-0.00143909],218],
						["Land_HBarrier_Big_F",[-5.36743,6.8418,-0.00143909],321],
						["Land_HBarrier_Big_F",[0.673584,13.1768,-0.00143909],1],
						["Land_Cargo10_grey_F",[-5.29321,1.71533,-0.00143719],0.00398437],
						["Land_PaperBox_open_empty_F",[6.80688,0.234863,-0.00143909],0],
						["Land_BagFence_Short_F",[0.497314,2.04395,-0.000439167],0],
						["Land_BagFence_Corner_F",[-0.950684,1.65674,-0.000439167],273.377],
						["Land_BagFence_Corner_F",[2.00171,1.73975,-0.000439167],0],
						["Land_HBarrier_Big_F",[10.0647,-0.479492,-0.00143909],270]
					];

				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// Heavy Mortarpos
	case 2 : {_makro = [	["Land_HBarrier_5_F",[-14.2971,7.22803,-0.00143909],87],
						["Land_HBarrier_5_F",[-14.0071,1.698,-0.00143909],87],
						["Land_HBarrier_5_F",[-13.8711,-3.91919,-0.00142527],268],
						["Land_HBarrier_3_F",[-14.8235,13.7136,-0.00143909],315.267],
						["Land_HBarrier_1_F",[-14.2637,10.1389,-0.00135088],42],
						["Land_BagBunker_Small_F",[-2.72876,-13.6111,-0.00143909],0],
						["Land_HBarrier_5_F",[-7.96606,-10.0889,-0.00137186],178],
						["Land_HBarrier_5_F",[-12.0251,-8.45459,-0.00128603],227],
						["Land_HBarrier_5_F",[2.01392,-10.0188,-0.00143909],178],
						["Land_HBarrier_5_F",[6.51392,-8.17944,-0.00143909],135],
						["Land_HBarrier_3_F",[1.09448,-13.5542,-0.00143909],359],
						["Land_HBarrier_3_F",[-6.47534,-13.4041,-0.00143909],359],
						["CamoNet_BLUFOR_Curator_F",[-10.1697,-0.0690918,-0.00143909],269.005],
						["Land_BagBunker_Tower_F",[-0.737793,15.8162,-0.00143909],88.5693],
						["Land_HBarrier_5_F",[8.17969,-4.09131,-0.00143909],267],
						["Land_HBarrier_5_F",[7.70288,7.08813,-0.00143909],87],
						["Land_HBarrier_5_F",[-8.27588,13.2542,-0.00138712],356],
						["Land_HBarrier_5_F",[5.83618,11.6384,-0.00143909],46],
						["Land_HBarrier_5_F",[7.96289,1.51807,-0.00143909],87],
						["RHS_NSV_TriPod_VDV",[1.59546,15.7356,2.75005],0.00542848],
						["B_Mortar_01_F",[-1.40747,-2.77637,0.167271],5.37988],
						["B_Mortar_01_F",[-1.64551,1.71216,0.0430107],19.9213],
						["B_Mortar_01_F",[2.52319,-0.944092,0.0949411],3.89695],
						["Land_ToiletBox_F",[5.85132,-1.97656,-0.00139666],87.9884],
						["Land_ToiletBox_F",[5.76123,0.593506,-0.00139523],88.0165],
						["Land_WaterTank_F",[-10.2688,-2.20654,-0.00144339],357.999],
						["Land_BagFence_Round_F",[-2.63159,3.4043,-0.000137806],141],
						["Land_BagFence_Round_F",[-2.48633,-3.48804,-0.000137806],31],
						["Land_BagFence_Round_F",[2.14502,1.21216,-0.000137806],179],
						["Land_BagFence_Round_F",[2.05298,-1.45581,-0.000137806],0],
						["Land_BagFence_Round_F",[-0.737793,3.07617,-0.000137806],231],
						["Land_BagFence_Round_F",[-2.88257,1.47534,-0.000137806],50],
						["Land_BagFence_Round_F",[-2.82031,-1.59888,-0.000137806],121],
						["Land_BagFence_Round_F",[-0.587402,-3.0542,-0.000137806],301],
						["Land_BagFence_Round_F",[3.50049,-0.174805,-0.000137806],270],
						["Land_HBarrier_1_F",[-11.2832,12.9185,-0.00143909],48],
						["Land_PaperBox_closed_F",[-11.5571,0.710693,-0.00143909],3.31802],
						["Land_PaperBox_closed_F",[-10.3296,2.46655,-0.00143909],69]
					];

				[_position,_makro,_dir] call FM(spawn_macro_exec);

			};
	/// Device-Defence
	case 3 : {_makro = [	
						["Land_New_WiredFence_10m_F",[-21.6787,-6.14648,-0.00143623],269.791],
						["Land_New_WiredFence_10m_F",[-21.7786,3.89355,-0.00143623],269.791],
						["Land_New_WiredFence_5m_F",[-18.9434,9.56885,-0.00144053],0],
						["Land_Cargo_House_V1_F",[-15.3412,2.62402,-0.00143909],267.906],
						["Land_Cargo_House_V1_F",[-14.7311,-5.70605,-0.00143909],267.906],
						["Land_New_WiredFence_10m_F",[-16.412,-10.9399,-0.00143623],0],
						["Land_New_WiredFence_10m_F",[-11.4716,9.51172,-0.00143623],0.100499],
						["Land_BagBunker_Small_F",[-8.69873,-11.5259,-0.00143909],0],
						["Land_BarGate_F",[-0.946655,-11.5718,-0.00143909],0],
						["Land_New_WiredFence_10m_F",[-1.63171,9.50098,-0.00143623],0.100499],
						["Land_New_WiredFence_10m_F",[8.94788,-10.0298,-0.00143623],0],
						["Land_New_WiredFence_5m_F",[6.10645,9.56885,-0.00144053],0],
						["RHS_NSV_TriPod_VDV",[8.05261,-12.2314,-0.00455618],178.279],
						["Land_Sign_WarningMilitaryArea_F",[4.92114,-12.8154,-0.00143909],2],
						["Land_BagFence_Round_F",[6.91919,-12.9521,-0.000137806],50.6164],
						["Land_BagFence_Round_F",[10.1536,-12.7886,-0.000137806],301.259],
						["Land_BagFence_Short_F",[5.39172,-11.793,-0.000439167],0],
						["Land_BagFence_Short_F",[10.5825,-11.5112,-0.000439167],269.238],
						["Land_New_WiredFence_pole_F",[8.73108,9.17773,-0.00143909],0],
						["Land_New_WiredFence_10m_F",[18.798,-10.0103,-0.00143623],0],
						["Land_New_WiredFence_10m_F",[23.458,-5.33203,-0.00143623],270.451],
						["Land_New_WiredFence_10m_F",[19.1178,9.3501,-0.00143623],0],
						["Land_New_WiredFence_10m_F",[23.5081,4.51758,-0.00143623],270.451],
						["CamoNet_BLUFOR_Curator_F",[18.9404,-2.80615,-0.00143909],95.7334],
						["Land_New_WiredFence_10m_Dam_F",[8.63904,29.4946,-0.00143671],0],
						["Land_New_WiredFence_10m_F",[3.16797,14.2178,-0.00143623],270.451],
						["Land_New_WiredFence_10m_F",[3.21802,24.0674,-0.00143623],270.451],
						["Land_New_WiredFence_10m_F",[23.6379,24.2275,-0.00143623],270.451],
						["Land_New_WiredFence_10m_F",[23.5881,14.3672,-0.00143623],270.451],
						["Land_New_WiredFence_10m_F",[19.0978,29.5493,-0.00143623],0],
						["Land_Cargo_Patrol_V1_F",[18.9819,25.4419,-0.00143862],177.993]
					];

				[_position,_makro,_dir] call FM(spawn_macro_exec);

			};
	/// Small MG
	case 4 : {_makro = [	
						["Land_BagFence_Short_F",[0.114746,-1.16797,-0.00143909],0],
						["Land_BagFence_Corner_F",[1.44214,-0.902832,-0.00143909],90.7108],
						["Land_BagFence_Corner_F",[-1.44775,-0.937012,-0.00143909],176.331],
						["Land_BagFence_Long_F",[-1.79199,1.04883,-0.00143909],269.938],
						["Land_BagFence_Long_F",[1.62451,1.26563,-0.00143909],269.938],
						["Land_BagFence_End_F",[1.02808,2.64209,-0.00143909],181.019],
						["Land_BagFence_End_F",[-1.17651,2.24072,-0.00143909],1.31518],
						["RHS_NSV_TriPod_VDV",[0.12915,0.986816,-0.00465584],0.028533]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);

			};
	/// AA-Pos Vanilla
	case 5 : {_makro = [	
						["Land_BagFence_Long_F",[-1.2019,1.85986,-0.00143909],142.333],
						["Land_BagFence_Long_F",[-1.12646,-2.1709,-0.00143909],214.219],
						["Land_BagFence_Long_F",[1.99219,-0.306396,-0.00143909],270.013],
						["O_static_AA_F",[0.73999,-2.00171,0.00328255],146.858],
						["O_static_AA_F",[-2.06348,-0.151611,0.00333309],269.036],
						["O_static_AA_F",[0.952637,1.79004,0.00333691],25.6731]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// MG/AT-Pos with direction
	case 6 : {_makro = [	
						["Land_HBarrier_5_F",[-2.63916,-3.16235,-0.00143909],0],
						["Land_HBarrier_5_F",[2.93042,-3.18652,-0.00143909],0],
						["Land_HBarrier_3_F",[6.69653,-2.14648,-0.00143909],272.21],
						["Land_BagFence_Round_F",[-1.93652,4.41406,-0.00143909],179.792],
						["Land_BagFence_Long_F",[-4.74902,-0.854492,-0.00143909],274.111],
						["Land_BagFence_Short_F",[-3.56592,3.3125,-0.00143909],118.671],
						["Land_BagFence_Round_F",[3.38696,4.3374,-0.00143909],174.852],
						["Land_BagFence_Short_F",[5.28467,3.40625,-0.00143909],43.1379],
						["Land_BagFence_Short_F",[6.46655,0.595215,-0.00143909],92.3614],
						["Box_IND_AmmoVeh_F",[2.06836,-1.25537,0.0291023],359.993],
						["Box_IND_AmmoVeh_F",[-2.55469,-1.34912,0.0291033],359.994],
						["O_static_AT_F",[3.4397,2.81445,0.003335],353.538],
						["O_static_AT_F",[-1.6543,2.74121,0.00333357],0.30482],
						["RHS_NSV_TriPod_VDV",[1.05591,2.78027,-0.00345707],0.0924312],
						["RHS_NSV_TriPod_VDV",[5.68848,1.63721,-0.00348091],59.189],
						["RHS_NSV_TriPod_VDV",[-3.28882,1.62646,-0.00350904],281.956],
						["CamoNet_OPFOR_open_Curator_F",[0.210449,0.305176,-0.00143909],0]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// Military Tower
	case 7 : {[_position] spawn FM(spawn_tower);};
	/// Old Simple Mortarpos (sandbags + mortar)
	case 8 : {[_position] spawn FM(spawn_mortarpos);};
	
	
	/// Tank-Pos - high
	case 9 : {_makro = [	
						["Land_HBarrier_Big_F",[3.81738,1.66357,0.0300326],269.237],
						["Land_HBarrier_Big_F",[-4.11206,1.42578,0.0300326],270.453],
						["Land_HBarrier_5_F",[-0.241211,4.7832,0.0300326],0],
						["rhs_t90_tv",[0,0,0],1.53107e-006]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// ZSU-Pos
	case 10 : {_makro = [	
						["Land_HBarrier_5_F",[3.31616,0.787598,-0.0259438],268.905],
						["Land_HBarrier_5_F",[-3.16846,0.872559,-0.0259438],92.4311],
						["Land_HBarrier_3_F",[-1.99292,4.40283,-0.0259438],0],
						["Land_HBarrier_3_F",[2.54712,4.29248,-0.0259438],0],
						["Land_HBarrier_1_F",[-3.21436,-3.8501,-0.0259438],268.644],
						["Land_HBarrier_1_F",[0.213135,4.34717,-0.0259438],0],
						["Land_HBarrier_1_F",[3.34546,-3.96045,-0.0259438],268.644],
						["Land_HBarrier_1_F",[3.39551,-2.74023,-0.0259438],268.644],
						["Land_HBarrier_1_F",[-3.18457,-2.67041,-0.0259438],268.644],
						["rhs_zsu234_aa",[0,0,0],0.000299447]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// Tank-Pos - low
	case 11 : {_makro = [	
						["Land_HBarrier_5_F",[-3.96118,2.3877,0.0246592],269.554],
						["Land_HBarrier_5_F",[3.48877,2.21777,0.0246592],269.554],
						["Land_HBarrier_5_F",[-0.241455,4.36328,0.0246592],0.754987],
						["Land_HBarrier_3_F",[-3.9165,-2.13623,0.0246592],270.346],
						["Land_HBarrier_3_F",[3.5437,-2.39648,0.0246592],270.346],
						["rhs_t90_tv",[0,0,0],2.57125e-006]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// AA-Pos heavy sourounded static
	case 12 : {_makro = [	
						["Land_HBarrierWall6_F",[0.178955,-9.03613,-0.00143909],180.724],
						["Land_HBarrierWall_corridor_F",[-8.63892,-0.467773,-0.00143909],0],
						["Land_HBarrierWall_corner_F",[-6.77881,-8.84717,-0.00143909],179.909],
						["Land_HBarrierWall4_F",[-7.60107,-4.19775,-0.00143909],270.216],
						["Land_HBarrierWall4_F",[-7.53101,4.46191,-0.00143909],270.216],
						["Land_BagFence_Corner_F",[-3.58765,-1.2793,-0.000439167],179.495],
						["Land_BagFence_Corner_F",[-3.62646,0.489746,-0.000439167],271.645],
						["Land_HBarrierWall6_F",[-1.43164,9.25586,-0.00143909],1.25827],
						["Land_HBarrierWall_corner_F",[5.46729,9.36133,-0.00143909],2.00187],
						["Land_HBarrierWall_corner_F",[-7.54004,8.87988,-0.00143909],269.445],
						["Land_HBarrierWall6_F",[6.5061,-1.51514,-0.00143909],90.874],
						["Land_HBarrierWall_corner_F",[6.30811,-8.36572,-0.00143909],91.3353],
						["Land_HBarrierWall4_F",[6.31934,4.88184,-0.00143909],89.7476],
						["RHS_NSV_TriPod_VDV",[-2.19165,0.0947266,-0.00487232],270.205],
						["O_static_AA_F",[-1.49878,2.9624,0.00329876],322.386],
						["O_static_AA_F",[1.64038,2.97852,0.00331593],43.3626],
						["O_static_AA_F",[1.57202,-2.72607,0.00324535],159.413],
						["O_static_AA_F",[-1.10522,-3.50928,0.00332546],217.815],
						["Box_East_AmmoVeh_F",[1.03931,-0.618164,0.0291004],360]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};			
	/// AA-Pos heavy sourounded ZSU
	case 13 : {_makro = [	
						["Land_HBarrierWall6_F",[-0.118164,-8.31445,-0.00143909],180.724],
						["Land_HBarrierWall6_F",[-2.04883,9.65723,-0.00143909],1.25827],
						["Land_HBarrierWall_corridor_F",[-9.29614,-0.0864258,-0.00143909],0],
						["Land_HBarrierWall_corner_F",[-7.42603,-8.46533,-0.00143909],179.909],
						["Land_HBarrierWall_corner_F",[-8.18726,9.26123,-0.00143909],269.445],
						["Land_HBarrierWall4_F",[-8.18823,4.85352,-0.00143909],270.216],
						["Land_HBarrierWall4_F",[-8.2583,-3.80615,-0.00143909],270.216],
						["Land_BagFence_Corner_F",[-4.66357,0.631348,-0.000439167],271.645],
						["Land_BagFence_Corner_F",[-4.625,-1.12744,-0.000439167],179.495],
						["Land_HBarrierWall6_F",[5.77124,-1.09424,-0.00143909],89.3662],
						["Land_HBarrierWall_corner_F",[4.82007,9.74268,-0.00143909],2.00187],
						["Land_HBarrierWall_corner_F",[5.66089,-7.98438,-0.00143909],91.3353],
						["Land_HBarrierWall4_F",[5.66211,5.26367,-0.00143909],89.7476],
						["rhs_zsu234_aa",[-0.309082,-4.15967,0.0278034],271.803],
						["rhs_zsu234_aa",[-0.437256,4.85645,0.0244765],91.2487],
						["RHS_NSV_TriPod_VDV",[-2.81909,0.48584,-0.00475454],270.184]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};
	/// Sandbag-Tower + Defence
	case 14 : {_makro = [	
						["CamoNet_BLUFOR_open_Curator_F",[0.242188,0.532227,-0.00143909],88.7696],
						["Land_BagBunker_Tower_F",[6.08521,1.07959,-0.00143909],181.004],
						["Land_BagBunker_Tower_F",[-6.34131,2.08057,-0.00143909],0],
						["Land_HBarrierWall_corridor_F",[2.34229,7.55225,-0.00143909],275.357],
						["Land_HBarrier_5_F",[-0.136475,-5.64941,-0.00143909],181.128],
						["Land_HBarrier_3_F",[3.47266,-4.60693,-0.00143909],273.798],
						["Land_HBarrier_3_F",[-1.61377,5.83691,-0.00143909],0.822655],
						["Land_Pallet_MilBoxes_F",[1.68433,-3.80908,-0.00143909],0],
						["Land_BagFence_Long_F",[-8.02246,2.98438,2.77956],270.792],
						["Land_BagFence_Long_F",[6.0957,-1.93555,2.77956],0],
						["Land_BagFence_Long_F",[4.40747,-0.535645,2.77956],270.792],
						["Land_BagFence_Long_F",[-5.86426,5.14453,2.77956],0],
						["Land_BagFence_Long_F",[7.76758,0.273926,2.77956],270.792],
						["Land_BagFence_Long_F",[-4.55249,3.66406,2.77956],270.792],
						["Land_PaperBox_open_full_F",[-2.05811,-0.100586,-0.00143909],0],
						["Land_PaperBox_open_empty_F",[1.82178,-1.73047,-0.00143909],0],
						["Land_BagFence_Corner_F",[7.47607,-1.58447,2.77956],89.9506],
						["Land_BagFence_Corner_F",[-7.7251,4.77637,2.77956],267.367],
						["Land_BagFence_End_F",[-4.64551,1.69629,2.77956],102.284],
						["Land_BagFence_End_F",[4.36914,1.30664,2.77956],270.959],
						["O_static_AT_F",[-6.27051,3.06787,2.75829],3.06981],
						["O_static_AT_F",[6.10718,0.229492,2.75827],185.297],
						["RHS_M2StaticMG_D",[-7.51978,0.386719,2.7631],180.046],
						["RHS_M2StaticMG_D",[7.30225,2.64307,2.76309],7.0639]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};	
	/// Big Defence-Pos
	case 15 : {_makro = [	
						["Land_HBarrier_Big_F",[-10.8943,-3.81201,-0.00143909],87],
						["Land_HBarrier_Big_F",[-5.1853,-6.79297,-0.00143909],181],
						["Land_Pallet_MilBoxes_F",[-5.42603,-4.75049,-0.00143909],0],
						["Land_PaperBox_open_full_F",[-7.94873,-2.3418,-0.00143909],0],
						["Land_PaperBox_open_empty_F",[-7.79858,-4.46191,-0.00143909],0],
						["Land_BagBunker_Large_F",[-7.07227,5.06201,-0.00143909],90.267],
						["CamoNet_BLUFOR_open_Curator_F",[4.75244,-3.88867,-0.00143909],0],
						["Land_Cargo_House_V1_F",[6.85132,3.05029,-0.00143909],0],
						["Land_HBarrier_Big_F",[12.1731,-3.75781,-0.00143909],91],
						["Land_HBarrier_5_F",[1.72827,-0.382813,-0.00143909],269],
						["Land_BagFence_Round_F",[3.94287,-6.78564,-0.000137806],314.063],
						["Land_BagFence_Long_F",[9.52783,-3.39551,-0.000439167],182],
						["Land_BagFence_Long_F",[0.607666,-7.40576,-0.000439167],181],
						["Land_BagFence_Long_F",[9.62671,-7.58594,-0.000439167],177],
						["Land_BagFence_Long_F",[3.96802,-3.00586,-0.000439167],182],
						["Land_BagFence_End_F",[6.64551,-7.5542,-0.000439167],179],
						["Land_BagFence_End_F",[2.43774,-7.46777,-0.000439167],0],
						["Land_HBarrier_Big_F",[9.46094,9.65918,-0.00143909],3],
						["Land_HBarrier_Big_F",[12.2832,4.69189,-0.00143909],91],
						["Land_HBarrierBig_F",[1.17749,9.42578,-0.00143909],179],
						["Land_HBarrier_5_F",[1.66821,5.63721,-0.00143909],269],
						["RHS_M2StaticMG_D",[-10.3904,7.73047,0.165628],11.4462],
						["RHS_MK19_TriPod_D",[7.56763,-5.61035,0.00809431],180.353],
						["O_static_AT_F",[1.6665,-5.19141,0.00333929],173.73],
						["RHS_M2StaticMG_D",[-10.2715,2.56445,0.159867],270.211]
					];
				[_position,_makro,_dir] call FM(spawn_macro_exec);
			};				
				
			
			
	
	
	
	
	case 100 : {[_position] spawn FM(spawn_aapos);};
};