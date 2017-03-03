/*
 *  Author: Dorbedo
 *
 *  Description:
 *      missionsetting in the description.ext
 *
 */
#define CBA_OFF
#include "script_component.hpp"

onLoadMissionTime = 1;
onLoadName = LSTRING(NAME);
onLoadMission = LSTRING(NAME);
//loadScreen = QEPAAPATH(logo,logo_512);

author = CSTRING(AUTHOR);
//overviewPicture = QEPAAPATH(logo,logo_512);
overviewText = "";
overviewTextLocked = "";

/// respawn
respawn = 3;
respawnButton = 1;
respawnDelay = 5;
respawnDialog = 0;
respawnOnStart = 0;
respawnTemplates[] = {"MenuPosition"};

/// revive
ReviveMode = 0;

disabledAI = 1;
aiKills = 0;

//showHUD[] = {true,false,false,false,false,false,false,false};
ShowGPS = 0;
//showCompass = 1;
//showMap = 0;
//showNotePad = 0;
//showWatch = 1;
//showUAVFeed = 1;
showSquadRadar = 1;

class Header {
    gameType = Coop;
    minPlayers = 1;
    maxPlayers = 54;
};

disableChannels[] = {{0,true,true},{1,false,true},{2,true,true},{3,false,true},{4,true,true},{5,true,true},{6,false,true}};

joinUnassigned = 1;
skipLobby = 0;
allowFunctionsLog = 0;
enableDebugConsole = 1;

corpseManagerMode = 0;
wreckManagerMode = 0;

//forceRotorLibSimulation = 1;

saving = 0;
showGroupIndicator = 0;
scriptedPlayer = 1;
