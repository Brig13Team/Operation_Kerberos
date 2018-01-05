params ["_vehicle", "_turret", ["_magazines", [], [[]]]];

If (_magazines isEqualTo []) exitWith {};

// magazine specific reloadTime
private _reloadTime = getNumber(configFile >> "CfgMagazines" >> ((_magazines select 0) select 0) >> "BWA3_MagazineRearmTime");
If (_reloadTime == 0) then {_reloadTime = 7;};

// missionside changes
switch (((_magazines select 0) select 0)) do {
    case "BWA3_Spike_LR" : {
        _reloadTime = 150;
    };
    case "BWA3_240Rnd_APFSDS_shells";
    case "BWA3_160Rnd_HE_shells";
    case "BWA3_160Rnd_ABM_shells" : {
        _reloadTime = 100;
    };
};

private _curMagazine = (_magazines select 0) select 0;
private _addMagazine = ({(_x select 0) isEqualTo _curMagazine} count ((magazinesAllTurrets _vehicle) select {((_x select 1) isEqualTo _turret) && ((_x select 2) > 0)})) < ((_magazines select 0) select 1);



[
    _reloadTime,
    [_vehicle, _turret, _magazines],
    {
        (_this select 0) params ["_vehicle", "_turret", "_magazines"];

        (_magazines select 0) params ["_curMagazine", "_targetAmount"];

        private _curAmount = {(_x select 0) isEqualTo _curMagazine} count ((magazinesAllTurrets _vehicle) select {((_x select 1) isEqualTo _turret) && ((_x select 2) > 0)});

        private _modify = _targetAmount - _curAmount;

        If (_modify < 0) then {
            _vehicle removeMagazinesTurret [_curMagazine, _turret];
            for "_i" from 1 to (_curAmount - 1) do {
                _vehicle addMagazineTurret [_curMagazine, _turret];
            };
        };
        If (_modify > 0) then {
            _vehicle removeMagazinesTurret [_curMagazine, _turret];
            for "_i" from (_curAmount + 1) to 1 step -1 do {
                _vehicle addMagazineTurret [_curMagazine, _turret];
            };
        };
        If (abs _modify <= 1) then {
            _magazines deleteAt 0;
        };

        [_vehicle, _turret, _magazines] call BWA3_fnc_loadMagazines;
    },
    {
        [localize "STR_BWA3_Comp_Ace_loadingStopped", false, 5] call ace_common_fnc_displayText;
    },
    If (_addMagazine) then {
        format[localize "STR_BWA3_Comp_Ace_addMagazine", getText(configFile >> "CfgMagazines" >> _curMagazine >> "displayNameShort")];
    } else {
        format[localize "STR_BWA3_Comp_Ace_removeMagazine", getText(configFile >> "CfgMagazines" >> _curMagazine >> "displayNameShort")];
    },
    {
        [ACE_player, _vehicle] call ace_common_fnc_canInteractWith
    }
] call ace_common_fnc_progressBar;
