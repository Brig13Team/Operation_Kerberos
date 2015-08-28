/*
	Author: Dorbedo
	
	Description:

*/
#include "script_component.hpp"
SCRIPT(addbriefing);
player createDiaryRecord ["Diary", ["Credits",format["
	<br/>Author %1
	<br/>Translations (English): Cypherstalker, Kiwa
	<br/>Fortification-Design: Maverick2044
	<br/>Base-Design: Dagobert
	----------------
	Used Scripts:
	----------------
	<br/>R3F - Logistics
	<br/>http://forums.bistudio.com/showthread.php?180049-R3F-Logistics
	<br/>
	<br/>CH View Distance
	<br/>http://forums.bistudio.com/showthread.php?185770-CH-View-Distance-Script
	<br/>
	<br/>VCOM Driving
	<br/>http://forums.bistudio.com/showthread.php?187450-VCOM-AI-Driving-Mod
",localize "STR_DORB_AUTHOR"]]];
player createDiaryRecord ["Diary", ["Informationen",format["
	===================
	<br />
	%1 
	<br />
	-------------------
	<br />
	%2
	<br />
	===================
	<br />
	%3
	<br />
	-------------------
	<br />
	%4
	<br />
	===================  
	<br />
	%5
	<br />
	-------------------
	<br />
	%6
	<br />
	===================
	<br />
	%7
	<br />
	-------------------
	<br />
	%8
	<br />
	===================
	<br />
	%9
	<br />
	-------------------
	<br />
	%10
  ",localize "STR_DORB_BRIEF_SETTING",localize "STR_DORB_BRIEF_SETTING_DESC",
   localize "STR_DORB_BRIEF_VEHICLES",localize "STR_DORB_BRIEF_VEHICLES_DESC",
   localize "STR_DORB_BRIEF_RESPAWN",localize "STR_DORB_BRIEF_RESPAWN_DESC",
   localize "STR_DORB_BRIEF_HALO",localize "STR_DORB_BRIEF_HALO_DESC",
   localize "STR_DORB_BRIEF_SQUAD",localize "STR_DORB_BRIEF_SQUAD_DESC",
   localize "STR_DORB_BRIEF_TFR",localize "STR_DORB_BRIEF_TFR_DESC"

  ]
  ]];


player createDiaryRecord ["Diary", ["Changelog","
<br/>Achtung Sprache vom Changelog nur Denglisch
<br/>SChreibFehler köennt ihr behalltEn
<br/>
<br/>Github: https://github.com/Dorbedo/Operation_Kerberos
<br/>
<br/>===================
<br/>Version 0.16
<br/>-------------------
<br/>Removed: Igiload
<br/>Added: Neues Logistiksystem - ersetzt Igiload
<br/>Added: Save Funktion für Cratespawner
<br/>Added: Whitelist-system
<br/>Fixed: Prototyp-Heli kann nun abgegeben werden
<br/>Fixed: Diverse kleinere Fehler
<br/>
<br/>===================
<br/>Version 0.15
<br/>-------------------
<br/>Removed: Commandvehicle
<br/>Added: Nebenmissionen
<br/>Added: Nebenmissionsrewards
<br/>Added: Commander (Kontrolliert nun die gesamten Verstärkungen und wählt passenden Konterangriff aus)
<br/>       Bspw.: Kein Panzerangriff mehr auf Einzelne Einheiten ; Kombinierter Angriff auf größere Spielerverbände
<br/>Added: Water Patrols
<br/>Added: Mine-Fields
<br/>Added: City 2.0 (Straßensperren, MGs in Häusern, Patroullien, IED, Stolperdrahtminen)
<br/>Added: Flugzeuge
<br/>Added: RHS: MHQ (ACE Medical Items, autodetection für advanced/basic medical),FHQ (LongRangeFunkgerät)
<br/>Added: Kompatibilität zu N'Ziwasogo, Panthera
<br/>Added: Mod Autodetection für RDS, BWA3
<br/>Added: Möglichkeit für East vs West
<br/>Added: Neue Makros für befestigte Stellungen (an günstigen Stellen platziert)
<br/>Added: Mission SCARAB: Missiontimer
<br/>Changed: Function-Makros
<br/>Changed: Vanilla Crews removed
<br/>Changed: Entferung vom Attackspawn
<br/>Changed: VCOM Update (1.03)
<br/>Improved: Examine
<br/>Improved: Mission SCARAB
<br/>Fixed: diverse kleinere Bugs
<br/>Fixed: NVG's nicht für Independent
<br/>Fixed: JIP-Probleme bei Intel-Missionen
<br/>
<br/>===================
<br/>Version 0.14.5
<br/>-------------------
<br/>Removed: SHK_Taskmaster
<br/>Fixed: Mission Intel
<br/>Fixed: Mission Device
<br/>Fixed: Localization (Sprache)
<br/>
<br/>===================
<br/>Version 0.14.4
<br/>-------------------
<br/>Added: Erlaubter Mod: 9LinerandNotepad
<br/>Added: Gegner hat nun NVG
<br/>Added: Taskhandler
<br/>Changed: Code Cleanup
<br/>Changed: Spieleranzahl
<br/>Changed: Benutzung von XEH anstatt BIS-EH
<br/>Changed: Neue Debugfunktion
<br/>Fixed: Fehlender String
<br/>Fixed: Localization (Taskdescription noch ausstehend)
<br/>Fixed: Defend-Mission: Vehicle-Attack
<br/>Removed: Alte Funktionen
<br/>Removed: Alte Makros
<br/>Removed: Medevac-Spieler bei Basic-Medical
<br/>
<br/>===================
<br/>Version 0.14.3
<br/>-------------------
<br/>Added: Englische Sprache (Übersetzungen von Cypherstalker) Hinweis: Einfach das eigene Profil auf deutsch umstellen, wenn ihr kein Deutsch mehr habt.
<br/>Added: Erste Version Kistenspawner(Arbeitstitel)
<br/>Changed: *Prevent Instant Death* Eingeschaltet
<br/>Changed: VCOM Update
<br/>Removed: Virtuelles Arsenal auf Fahrzeugmunition
<br/>Fixed: Div kleinere Schönheitsfehler im Code
<br/>
<br/>===================
<br/>Version 0.14.2
<br/>-------------------
<br/>Changed: Anzahl Einheiten in der AO reduziert (RHS mag im Moment meine HC nicht: stürzen ab, sobald eine RHS Raktet(Tow, javelin, ... abgefeuert wird))
<br/>Changed: *Prevent Instant Death* abgeschaltet (ACE3-Bug führt sonst dazu, dass die Gegner nahezu unverwundbar werden)
<br/>Fixed: Div kleinere Schönheitsfehler im Code
<br/>
<br/>===================
<br/>Version 0.14.1
<br/>-------------------
<br/>Added: ACE3
<br/>Changed: UI
<br/>Removed: AGM
<br/>
<br/>
<br/>===================
<br/>Version 0.14
<br/>-------------------
<br/>Added: Krankenhaus (medical Facility)
<br/>Added: Mission SCARAB
<br/>Added: Mission Device: Erdbeben
<br/>Added: Headless Client (bis zu 3x, Autodetection, verteilt die Last  zum Spawnzeitpunkt)
<br/>Changed: Gegnergruppen HC-Kompatibel gemacht
<br/>Changed: Mission Device: Device
<br/>Changed: Missionsauswahl überarbeitet -> vorbereitung von Adminkonsole
<br/>Changed: Einheitenmenge bei vielen Spielern
<br/>Changed: Spawnpads (GUI + Scripts)
<br/>Changed: Basis-Marker
<br/>Changed: Nur Piloten können fliegen scharfgeschalten
<br/>Fixed: Verhören
<br/>Fixed: Grouptracker - kleinere Fehler
<br/>
<br/>
<br/>===================
<br/>Version 0.13.1
<br/>-------------------
<br/>Changed: Spawn von Helikoptern und Jets bei vielen Spielern deaktiviert - Kommandofahrzeug Radar davon unbeeindruckt
<br/>Changed: Spz können per Heli transportiert werden
<br/>Fixed: TFR-Übersicht
<br/>
<br/>
<br/>===================
<br/>Version 0.13
<br/>-------------------
<br/>Added: Kommandofahrzeug AI
<br/>Added: Kommandofahrzeug Mech
<br/>Added: Kommandofahrzeug Specops
<br/>Changed: Kommandofahrzeug Panzer (Wechsel von Gruppen zu einzelnen Einheiten)
<br/>Changed: Kommandofahrzeug Artillerie (Schießt häufiger und mehr)
<br/>Changed: Kommandofahrzeug Airdrop (Abstand der Springer verkürzt)
<br/>Changed: Teleport zum Squadleader (Bedingungen, Spawnort)
<br/>Changed: Missionswahrscheinlichkeiten
<br/>Changed: Mission Verteidigung - Spawnentferung
<br/>Changed: Mission Verteidigung - Helikopter kommen leicht versetzt
<br/>Changed: Zusammensetzung der Gegner (mehr Infanterie)
<br/>Changed: Grundlegende Codeveränderungen
<br/>Changed: Wechsel zu CBA-Funktionen
<br/>Changed: Makros
<br/>Changed: Funktionsbibilothek
<br/>Changed: Komplett Multilingual (Vorbereitet - Übersetzung steht aus)
<br/>Fixed: Spawnlisten
<br/>Fixed: Logistiker
<br/>Fixed: Taskforce - Bug
<br/>Fixed: Einheitenspawn
<br/>Fixed: TFR-Übersicht - zu kurze Anzeige
<br/>Fixed: Admin hat abbruchsmöglichkeit der Verteidigungsmission
<br/>Removed: Respawn-Vehicle
<br/>
<br/>
<br/>===================
<br/>Version 0.12
<br/>-------------------
<br/>Added: RHS 0.3.7
<br/>Added: Respawn-Vehicle (CH-47F,M1078A1P2)
<br/>Added: Teleport zum Squadleader
<br/>Added: Kommandofahrzeuge (rufen Unterstützung)
<br/>Added: Kommandofahrzeug Artillerie
<br/>Added: Kommandofahrzeug Fallschirmjäger
<br/>Added: Kommandofahrzeug Panzer
<br/>Changed: Fabrik benötigt Logistiker
<br/>Fixed: Div kleinere Bugs
<br/>
<br/>
<br/>===================
<br/>Version 0.11
<br/>-------------------
<br/>Added: Airdrop
<br/>Added: Variabler Gegnerspawn (abhängig von Spieleranzahl)
<br/>Changed: Defend-Mission (Wellen)
<br/>Fixed: Mission POW
<br/>Fixed: Mission Destroy Tower
<br/>
<br/>
<br/>===================
<br/>Version 0.10
<br/>-------------------
<br/>Added: Vorbereitungen für ACE3
<br/>Added: Grouptracker
<br/>Added: New Units (MARKSMEN)
<br/>Added: BIS - dynamicGroups (Squadmanagement - Öffen mit Taste U)
<br/>Added: TFR - Frequenzübersicht
<br/>Added: Tarus, Comanche, Wildcat zum Airspawn
<br/>Added: Briefing
<br/>Changed: Name - -Operation Kerberos-
<br/>Changed: Spawnlisten werden von vom Server verwaltet (schneller für langsame PC)
<br/>Fixed: Rechtschreibfehler
<br/>Fixed: Symbol von -Retten-
<br/>Fixed: Schönwettergewitter
<br/>Fixed: GroupTracker
<br/>
<br/>
<br/>===================
<br/>Version 0.07
<br/>-------------------
<br/>
<br/>Changed: Squadmanagementool Anpassung zwecks Marksmen DLC
<br/>Changed: Missionsbenachrichtigung
<br/>
<br/>
<br/>===================
<br/>Version 0.06
<br/>-------------------
<br/>Added: R3F-Logistik
<br/>Added: Neues Debuglog
<br/>Added: Mörser 
<br/>Added: Artillerie
<br/>Added: Tower
<br/>Changed: Vorbereitung für mehrere Sprachen
<br/>Changed: RTB nun keine Aufgabe mehr, Radius auf 2,5km um Respawn
<br/>Changed: Basis rumballern nun wieder aktiv (50m Radius)
<br/>Fixed: Spawnlocation von Angriffen
<br/>
<br/> 
<br/>===================
<br/>Version 0.05
<br/>-------------------
<br/>Added: Benachrichtigungen
<br/>Added: Kovoi Startmarker
<br/>Added: Verhören
<br/>Changed: GUI (diverses)
<br/>Changed: Halo
<br/>Changed: CSE zu AGM in Erwartung von ACE3
<br/>Changed: Spawnlistengenerierung
<br/>Fixed: Servicepunkt
<br/>Removed: IED
<br/>Removed: Missionmarker
<br/>Removed: R3F-Logistiks
<br/>
<br/>
<br/>===================
<br/>Version 0.04
<br/>-------------------
<br/>Added: Missionstyp: Gefangenentransport überfallen
<br/>Added: Missionstyp: Militärkonvoi zerstören
<br/>Added: Missionstyp: Fahrzeug erobern
<br/>Added: Missionmarker
<br/>Added: Nach Respawn wird die Ausrüstung wiederhergestellt
<br/>Changed: Anzahl der Einheiten
<br/>Changed: Spawnradius verringert
<br/>Changed: Verteidigung nun gegen Wellen
<br/>Changed: Basis ein wenig herumgeschoben
<br/>Fixed: Einheitenspawn innerhalb einer Stadt
<br/>Fixed: Nachricht bei Verteidigung
<br/>
<br/>
<br/>===================
<br/>Version 0.03
<br/>-------------------
<br/>Added: Gegner: Heli Patroullie
<br/>Added: Gegner: Statische Geschütze
<br/>Added: Gegner: IED (CSE)
<br/>Added: Wetteränderung
<br/>Fixed: Positionierung der Tower
<br/>Fixed: Tower und Device nur durch Sprengstoff zerstörbar
<br/>Removed: Zivilverkehr
<br/>Removed: CES-Overheating
<br/>
<br/>
<br/>===================
<br/>Version 0.02
<br/>-------------------
<br/>Added: Missiontyp Sonstiges: Device
<br/>Added: Missiontyp Sonstiges: Radiotower
<br/>Added: Missiontyp Militär: Erobern
<br/>Added: Missiontyp Militär: Verteidigen
<br/>Added: Halo
<br/>Added: Zivilverkehr
<br/>Changed: Spawns enthalten CSE-Boxen
<br/>Changed: Spawns kreieren nun in jedem Huron Medic und Hemtt Medic ein CSE-Lazarett
<br/>Fixed: Version -Simple Squadmanagement- aktualisiert.
<br/>Removed: -Nur Piloten können fliegen-
<br/>
<br/>
<br/>===================
<br/>Version 0.01
<br/>-------------------
<br/>Added: Vehicle-Spawns
<br/>Added: CSE
<br/>Added: Teleport in Basis
<br/>Added: Missiontyp Stadt: Intel
<br/>Added: Missiontyp Stadt: Commander
<br/>Added: Missiontyp Stadt: Geiseln
<br/>Added: Missiontyp Stadt: Waffenversteck
<br/>Added: Gegner: Farzeugpatroullie, Infanteriepatroullien, Specops, Infanterie in Gebäuden
<br/>Added: Gegner: Infanterieparoullie
<br/>Added: Gegner: Specops (Sniperteam, Dronenteam (UGV, UAV(klein))
<br/>Added: Gegner: Farzeugpatroullie
<br/>Added: Gegner: Infanterie in Gebäuden
"]];

