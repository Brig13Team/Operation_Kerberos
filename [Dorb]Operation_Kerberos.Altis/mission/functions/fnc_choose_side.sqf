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
_config = missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions";
for "_i" from 0 to (count _config)-1 do {
	_taskarray pushBack [(_config select _i),getNumber((_config select _i)>>"probability")];
};

{
	_x params ["_type","_probability"];
	If (_probability>=(random 1)) then {
		/// choose the position
		private ["_positiontypes","_position","_distance"];
		_positiontypes = getArray(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>(_x select 0)>>"location">>"areas");
		_distance = getnumber(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>(_x select 0)>>"location">>"distance");
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
		_delay_spawn = (getnumber(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>(_x select 0)>>"delay_spawn")) max 1;
		_delay_reveal = getnumber(missionconfigfile>>"missions_config">>"main">>_taskMAIN>>"sidemissions">>(_x select 0)>>"delay_reveal");
		[QUOTE(_this spawn FUNC(side_create)),[_taskMAIN,_positionMain,_type,_position,format["%1_%2",_taskID,(_forEachIndex)],_delay_reveal],_delay_spawn] call EFUNC(common,waitandexec);
	};
}forEach _taskarray;