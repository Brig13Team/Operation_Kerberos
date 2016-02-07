/*
    Author: Dorbedo

    Description:
        adds Action to spawner
    
    
*/
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(cratelogics) = [];

for "_i" from 1 to 9 do {
    if !(isNil (format["cratespawner%1",_i])) then {
        private _logicname = format["cratespawner%1",_i];
        GVAR(cratelogics) pushBack (missionNamespace getVariable [_logicname,objNull]);
        [["<t size='1.5' shadow='2' color='#FF860F'>" +localize LSTRING(crate_header) +"</t>", {_this call FUNC(crate_OpenMenu);}, [_logicname], 5, false, true, "",format["alive _target and (getposatl player distance getposatl cratespawner%1) < 4",_i]]] call CBA_fnc_addPlayerAction;
    };
};

private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable "D_ROOTDIR";
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    {
        If ((!isNull _x)&&{(player distance (getPosATL _x))<25}) then {
            private _spawnPos = getPos _x;
            _spawnPos set[2,1];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance _x)))*_zoom*6);
            drawIcon3D [_root+"data\icon\icon_robot.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(crate_header),0,(_sizeicon*0.015),"PuristaMedium"];
        };
    }forEach GVAR(cratelogics);
}];