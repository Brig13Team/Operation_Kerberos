_this spawn {
    scriptname "dorb\player\XEH_fired";
    #include "script_component.hpp"
    if((getposatl (_this select 0) distance2D getposatl base) >51) exitwith {};
    deleteVehicle (_this select 6);
    [localize ELSTRING(player,base_fire),localize ELSTRING(player,base),true] call BIS_fnc_guiMessage;
};
