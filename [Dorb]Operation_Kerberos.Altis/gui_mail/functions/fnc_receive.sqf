/*
 *  Author: Dorbedo
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


_this params [
    ["_header","",[""]],
    ["_content","",[""]],
    ["_sender", LSTRING(sender) ,[""]],
    ["_folder",LSTRING(inbox),[""]]
];

If (isLocalized _sender) then {_sender = localize _sender;};
If (isLocalized _folder) then {_folder = localize _folder;};


If !(HASH_HASKEY(GVAR(mail),_folder)) then {
    HASH_SET(GVAR(mail),_folder,[]);
};

private _messageHash = HASH_CREATE;
HASH_GET(GVAR(mail),_folder) pushBack _messageHash;

HASH_SET(_messageHash,"header",_header);
HASH_SET(_messageHash,"sender",_sender);
HASH_SET(_messageHash,"content",_content);
HASH_SET(_messageHash,"date",date);
