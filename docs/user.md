---
title: users
layout: brigade
---
# User-Documentation
If you want to know, how to use the features of this mission, you can receive the informations here.

#### [ACRE-Frequency Overview](#gui_acre)    
#### [Grouptracker](#grouptracker)    
#### [Vehicle-Spawns](#gui_spawn)    
#### [Whitelist](#whitelist)    
#### [Logistics](#logistics)    
#### [Doorbreach](#doorbreach)    
#### [Cratespawner](#gui_crate)    
#### [Missionobjects](#mission)    
#### [Parachting](#parachuting)    
<hr>


## <a name="gui_acre"></a>ACRE-Frequency Overview
This GUI is designed to give the players an Overview over the other squads and their radios.
The Feature is not connected to your currently used radios. This is done on purpose. The goal was to give an overview, not to reduce the usage of ACRE into just clicking a button.

### Treeview
The Treeview shows the groups of your side. Each Group can have Group-radios and each player can have his own radios displayed.
For Example:
´´´
Group 1 uses AN/PRC 343 - Block 1 Channel 2 as an internal radio.
The group receive their orders over an AN/PRC 152 - Channel 10.
In addition, a JTAC named Dieter follows this squad an carrys an AN/PRC 117F on Channel CAS to connect to the Air-Support.

The way, this is ment to be used is:
1. The Squadleader defines the groupradios AN/PRC 343 and AN/PRC 152 for the group
2. The JTAC defines his Radio for him personally.

Now the Tree should show the following:
-WEST
--Group 1
--- AN/PRC 343 - B1/C2
--- AN/PRC 152 - Channel 10
---- Dieter
----- AN/PRC 117F - CAS
```

### Defining radios
The defining radios of groups is similar to defining radios for yourself
Only the leader of the squad can define radios for the group while every player can define his own radios.
You can spot, if you are defining the group or the personal radios by taking a look at the watermark.

The dialog contains of 3 lists:
1. All possible radios
2. Your currently selected radios
3. the properties of the radio selected in the 2nd List

If you want to add a new radio, you can just drag a radio from List 1 into List 2. The removal of radios follows the same principle.
After you have added a radio, you can change the properties of the radio on the right side. The combobox can be used to choose a preset-channel.
These presets are identified by the system. If another User has the same values inside one of his presets, the preset is automatically identified.
If the choses values don't match a preset, there will no preset be displayed. This way, it takes more time to idenfify the right options.
So it is recommended to use the presets. If you don't like them, you can change the values into whatever you like.

After you have chosen the preset, you have to save it by pressing the save-button.
The delete Button only discards the changed values. It won't delete the list. So if you want to clean the list, you have to drag the radios and save afterwards.

<hr>
## <a name="grouptracker"></a>Grouptracker
The grouptracker show the squads of your own side on the map.
The symbol changes acording to the vehicle, the leader is using.
The dots are indicating the amount of players, the squad consists of

The small delay and the update intervall are on purpose.

<hr>
## <a name="gui_spawn"></a>Vehicle-Spawns
The vehicles spawns can be used to create vehicles.
The display consits of the list with possible vehicles, the 3D-view of the model and some additional informations.
The minus button can be used to clear the spawn are. The add button creates the vehicle at the spawn point.


<hr>
## <a name="whitelist"></a>Whitelist
The CAS-Vehicles are whitelisted. If you are not allowed to fly this vehicle, you can't use the Pilot and Co-Pilot slots.
The Whitelist is based on a Database

<hr>
## <a name="logistics"></a>Logistics
The logistics Feature adds some immersion to logistics. The containers can be loaded via ACE-Menu on/into the vehicles.
There is one simple rule: If it doesn't fit by view, it won't fit.
The main advantage is, that you can stack objects inside the loading space of a vehicle.
The system also supports Airdrop. The Pilot/Co-Pilot can drop the cargo while they are flying.
To make it possible for the Pilot to fly and drop by himself, it is possible to define a custom key for dropping the Items via CBA.
Otherwise he has to use the ACE-self interact menu.

<hr>
## <a name="doorbreach"></a>Doorbreach
It is possible to breach through doors with a M113 charge. If you want to do this, you have to have a M113 inside your inventory.
Then you move towards a door and plant the charge via ACE-interact. The you have 10 Seconds until the charge explodes and opens the door.

<hr>
## <a name="gui_crate"></a>Cratespawner
This feature was done to create custom filled containers during mission. Your can spawn containers with your personal special gear. These compositions can be saved, to be restored later.

<hr>
## <a name="mission"></a>Missionobjects
Needs to be documented


<hr>
## <a name="player_para"></a>Parachuting
You can parachute with a backpack. This can be done via ACE-self interact menu.



<hr>
