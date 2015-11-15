/*
	Author: Dorbedo
	
	Description:
		Selects SideMission
	
	Parameter(s):
		0 : STRING	- TASKID
	
*/
#include "script_component.hpp"
SCRIPT(choose);
params [["_taskMAIN",format["NOTNUMMER%1",random 1000000],[""]],["_positionMain",[],[[]],[2,3]]];
TRACEV_1(_taskID);

CHECK(_positionMain isEqualTo [])


private ["_taskarray","_armys","_army","_config","_task"];
_taskarray = [];
_config = missionconfigfile>>"missions_config">>"main">>"sidemissions";
{
	_taskarray pushBack [_x,getNumber(_x>>"probability")];
}forEach _config;

{
	_x params ["_type","_probability"];
	If (_probability>=(random 1)) then {
		/// choose the position
		private ["_positiontypes","_position","_distance"];
		_positiontypes = getArray(missionconfigfile>>"missions_config">>"main">>(_x select 0)>>"location">>"areas");
		_distance = getnumber(missionconfigfile>>"missions_config">>"main">>_task>>"location">>"distance");
		if (_positiontypes isEqualTo []) then {
			_position = [_positionMain,_distance,0] call EFUNC(common,pos_random);
		}else{
			if ("water" in _positiontypes) then {
				_positions pushBack (missionnamespace getVariable ["_water",[]]);
				CHECK(_positions isEqualTo [])
				_position = [_position,_distance,3] call EFUNC(common,pos_random);
			}else{
				private "_positions";
				_positions = [];
				{
					_positions pushBack (missionnamespace getVariable [_x,[]]);
				}forEach _positiontypes;
				CHECK(_positions isEqualTo [])
				_position = (_positions SELRND)select 0;
				_position = [_position,_distance,0] call EFUNC(common,pos_random);
			};
		};
		
		[_taskMAIN,_type,_position,format["%1_%2",_taskID,(_forEachIndex)]] spawn FUNC(side_create);

	};
}forEach _taskarray;