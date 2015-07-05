/*
	Author: Dorbedo

	Description:
		Spawns predefined defencepositions

	Parameter(s):
		0 : ARRAY	- Position
		(optional)
		1 :	SCALAR	- Type
		


*/
#include "script_component.hpp"

DEFAULT_PARAM(0,_position,[]);
CHECK(_position isEqualTo [])
DEFAULT_PARAM(1,_type,-1);
DEFAULT_PARAM(2,_dir,0);
private["_makro"];
If (_type < 0) then {_type = floor(random 3);};
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
<<<<<<< HEAD
				[_position,_makro,_dir] call FM(spawn_makro_exec);
=======
				[_position,_makro] call FM(spawn_macro_exec);
>>>>>>> origin/master
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
<<<<<<< HEAD
				[_position,_makro,_dir] call FM(spawn_makro_exec);
=======
				[_position,_makro] call FM(spawn_macro_exec);
>>>>>>> origin/master
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
<<<<<<< HEAD
				[_position,_makro,_dir] call FM(spawn_makro_exec);
=======
				[_position,_makro] call FM(spawn_macro_exec);
>>>>>>> origin/master
			};











};