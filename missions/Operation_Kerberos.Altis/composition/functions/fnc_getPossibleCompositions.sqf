/**
 * Author: Dorbedo
 * returns the possible compositions
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * <ARRAY> possible composition configs
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _allCompositions = [];
If (isClass(configFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [configFile >> "CfgKerberos" >> "CfgComposition" >> "compositions","true",true]);
};

If (isClass(missionConfigFile >> "CfgKerberos" >> "CfgComposition")) then {
    _allCompositions append (configProperties [missionconfigFile >> "CfgKerberos" >> "CfgComposition" >> "compositions","true",true]);
};

private _return = [];
TRACEV_1(_allCompositions);
{
    if (isClass _x) then {
        private _cfg = _x >> "composition" >> "items" >> "Item0" >> "Entities";
        If (isClass _cfg) then {
            private _Objects = configProperties [
                _cfg,
                "(isClass _x)&&{getText(_x >> 'dataType') == 'Object'}",
                "true",
                true
            ];
            _invalidItems = _Objects select {!(isClass(configFile >> 'CfgVehicles' >> getText(_x >> 'type')))};
            //#ifdef DEBUG_MODE_FULL
            If ((count _invalidItems)==0) then {
                _return pushBack _x;
            } else {
                TRACEV_1(_invalidItems);
            };
            //#else
            //If ((count _invalidItems)==0) then {
                //_return pushBack _x;
            //};
            //#endIf
        };
    };
    nil;
} count _allCompositions;

_return;
