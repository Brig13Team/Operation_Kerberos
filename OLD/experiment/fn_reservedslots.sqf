/* 
ReservedSlot.sqf by Kahna

Initially call this script in the Init.sqf and then include it in whatever script you use to respawn players,
otherwise the respawned player will not have the Reserved Slot script applied to it.

*/

private ["_reserved_units", "_reserved_uids", "_uid"];

waitUntil {!isNull player};
waitUntil {(vehicle player) == player};
waitUntil {(getPlayerUID player) != ""};

// Variable Name of the Player Character to be restricted. //
_reserved_units = ["admin1","admin2"];

// The player UID is a 17 digit number found in the profile tab. //
_reserved_uids = ["76561198015424961","76561198020809170","76561197993438649","76561198014971264","76561198014957112","76561198042457380"];
//_reserved_uids = ["76561198015424963","76561198020809172"];


// Stores the connecting player's UID //
_uid = getPlayerUID player;


if (((vehicleVarName player) in _reserved_units) && !(_uid in _reserved_uids)) then
{
titleText ["", "BLACK OUT"];
disableUserInput true;
hint "You are in a reserved slot! You will be kicked to the lobby in 15 seconds!";
sleep 5;
hint "You are in a reserved slot! You will be kicked to the lobby in 10 seconds!";
sleep 5;
hint "You are in a reserved slot! You will be kicked to the lobby in 5 seconds!";
sleep 5;
titleText ["", "BLACK IN"];
disableUserInput false;
failMission "end1";
/*}else{
	if(!respawnEH_Added)then{
		player addEventHandler["Respawn",{[] execVM format["%1", __FILE__]}];
		respawnEH_Added = true;
	};*/
};