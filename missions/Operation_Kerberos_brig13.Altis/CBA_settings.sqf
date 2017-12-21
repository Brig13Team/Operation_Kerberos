force dorb_grouptracker_active = true;
force dorb_grouptracker_Intervall = 5;
force dorb_grouptracker_delayAmount = 3;
force dorb_grouptracker_AiIsVisible = true;
force dorb_mod_tfar_AICanHearPlayer = true;
force dorb_viewrestriction_active = false;
force dorb_viewrestriction_forcealwaysFirst = false;
force dorb_viewrestriction_forcefoot = true;
force dorb_viewrestriction_forcevehicle = true;
force dorb_viewrestriction_forceair = false;
force dorb_viewrestriction_forceship = true;
force dorb_whitelist_onlyPilotsFly = true;
force dorb_whitelist_whitelistenabled = true;
force dorb_gui_teleport_to_lead_active = true;
force dorb_gui_arsenal_level = 2;
force dorb_gui_arsenal_allowedradius = 25;
force dorb_ai_skill_active = true;
force dorb_ai_skill_general = 0.9;
force dorb_ai_skill_accuracy = 0.6;
force dorb_ai_skill_handling = 0.65;
force dorb_ai_skill_spotting = 0.6;

// ACE advanced ballistic
force ace_advanced_ballistics_enabled = true;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_simulationInterval = 0.05;
// ACE advanced fatigue
force ace_advanced_fatigue_enabled = true;
ace_advanced_fatigue_enableStaminaBar = true;
force ace_advanced_fatigue_performanceFactor = 1;
force ace_advanced_fatigue_recoveryFactor = 1;
force ace_advanced_fatigue_loadFactor = 1;
force ace_advanced_fatigue_terrainGradientFactor = 1;
// ACE advanced throwing
ace_advanced_throwing_enabled = true;
ace_advanced_throwing_showThrowArc = true;
ace_advanced_throwing_showMouseControls = true;
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;
// ACENAL
ace_arsenal_camInverted = false;
ace_arsenal_enableModIcons = true;
ace_arsenal_fontHeight = 4.5;
ace_arsenal_allowDefaultLoadouts = true;
ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_EnableRPTLog = false;
// ace captives
force ace_captives_allowHandcuffOwnSide = true;
force ace_captives_requireSurrender = 0;
force ace_captives_allowSurrender = true;
force ace_captives_requireSurrenderAi = false;
// ACE Common
force ace_common_checkPBOsAction = 2;
force ace_common_checkPBOsCheckAll = true;
force ace_common_checkPBOsWhitelist = "['dorb_main','dorb_common','dorb_composition','dorb_artillery','dorb_database','dorb_headless','dorb_headquarter','dorb_intercept','dorb_mission','dorb_spawn','dorb_worlds','asr_ai3_cfgammo','asr_ai3_cfgcamouflage','asr_ai3_cfgvehicles','asr_ai3_cfgweapons','asr_ai3_greenrico','asr_ai3_incognito','asr_ai3_main','asr_ai3_rhs_gr_c','asr_ai3_rhs_gr_camo_c','asr_ai3_rhs_ru_c','asr_ai3_rhs_ru_camo_c','asr_ai3_rhs_us_c','asr_ai3_rhs_us_camo_c','asr_ai3_rhs_saf_c','asr_ai3_rhs_saf_camo_c','asr_ai3_bwa3_c','asr_ai3_bwa3_camo_c','asr_ai3_niarms_c','cba_diagnostic_enable_perf_loop','cba_diagnostic_logging','cba_cache_disable','cba_diagnostic_disable_xeh_logging','Disable_XEH_Logging','cba_diagnostic_enable_logging'
#define MOD_BWA3 'BWA3_EnablePIPOptics','BWA3_EnablePIPOptics','extdb3','kerb_main','kerb_man','kerb_vehicles']";
ace_common_settingFeedbackIcons = 1;
ace_common_settingProgressBarLocation = 0;
ace_common_displayTextColor = [0,0,0,0.1];
ace_common_displayTextFontColor = [1,1,1,1];
// ace Explosives
force ace_explosives_requireSpecialist = true;
force ace_explosives_punishNonSpecialists = true;
force ace_explosives_explodeOnDefuse = true;
// ACE Cookoff
force ace_cookoff_enable = true;
force ace_cookoff_enableAmmobox = true;
force ace_cookoff_enableAmmoCookoff = true;
force ace_cookoff_ammoCookoffDuration = 1;
force ace_cookoff_probabilityCoef = 1;
// ACE Fragmantation
force ace_frag_enabled = true;
force ace_frag_spallEnabled = true;
force ace_frag_reflectionsEnabled = true;
force ace_frag_maxTrack = 10;
force ace_frag_maxTrackPerFrame = 10;
// ACE Pointing
force ace_finger_enabled = true;
force ace_finger_maxRange = 4;
force ace_finger_indicatorForSelf = true;
ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
// ACE googles
force ace_goggles_effects = 2;
force ace_goggles_showInThirdPerson = true;
// ACE hearing
force ace_hearing_enableCombatDeafness = true;
force ace_hearing_earplugsVolume = 0.5;
force ace_hearing_unconsciousnessVolume = 0.4;
ace_hearing_disableEarRinging = false;
force ace_hearing_enabledForZeusUnits = true;
force ace_hearing_autoAddEarplugsToUnits = true;
// ace interaction
force ace_interaction_enableTeamManagement = false;
force ace_interaction_enableMagazinePassing = true;
force ace_interaction_disableNegativeRating = false;
// ace interaction menu
ace_interact_menu_alwaysUseCursorSelfInteraction = false;
ace_interact_menu_cursorKeepCentered = false;
ace_interact_menu_alwaysUseCursorInteraction = false;
ace_interact_menu_useListMenu = false;
ace_interact_menu_colorTextMax = [1,1,1,1];
ace_interact_menu_colorTextMin = [1,1,1,0.25];
ace_interact_menu_colorShadowMax = [0,0,0,1];
ace_interact_menu_colorShadowMin = [0,0,0,0.25];
ace_interact_menu_textSize = 2;
ace_interact_menu_shadowSetting = 2;
ace_interact_menu_actionOnKeyRelease = true;
ace_interact_menu_menuBackground = 0;
ace_interact_menu_addBuildingActions = false;
ace_interact_menu_menuAnimationSpeed = 0;
// ace cargo
force ace_refuel_rate = 1;
force ace_refuel_hoseLength = 12;
ace_repair_displayTextOnRepair = true;
force ace_repair_engineerSetting_repair = 1;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_repairDamageThreshold = 0.6;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_consumeItem_toolKit = 0;
force ace_repair_fullRepairLocation = 3;
force ace_repair_engineerSetting_fullRepair = 2;
force ace_repair_addSpareParts = true;
force ace_repair_wheelRepairRequiredItems = 1;
force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force ace_cargo_enable = true;
force ace_cargo_paradropTimeCoefficent = 2.5;
// ace magazine repack
force ace_magazinerepack_timePerAmmo = 1.5;
force ace_magazinerepack_timePerMagazine = 2;
force ace_magazinerepack_timePerBeltLink = 8;
// ace Map
force ace_map_BFT_Interval = 1;
force ace_map_BFT_Enabled = false;
force ace_map_BFT_HideAiGroups = false;
force ace_map_BFT_ShowPlayerNames = false;
force ace_map_mapIllumination = true;
force ace_map_mapGlow = true;
force ace_map_mapShake = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShowCursorCoordinates = false;
force ace_map_defaultChannel = 1;
force ace_map_gestures_enabled = true;
force ace_map_gestures_maxRange = 7;
// ace map gestures
ace_map_gestures_interval = 0.03;
ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];
ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
ace_map_gestures_defaultColor = [1,0.88,0,0.7];
// ace map tools
ace_maptools_rotateModifierKey = 1;
ace_maptools_drawStraightLines = true;
// ace map markers
force ace_markers_movableMarkersEnabled = true;
force ace_markers_moveRestriction = 0;
// ace medical
force ace_medical_blood_enabledFor = 1;
force ace_medical_level = 2;
force ace_medical_medicSetting = 2;
force ace_medical_increaseTrainingInLocations = true;
force ace_medical_enableFor = 0;
force ace_medical_enableOverdosing = true;
force ace_medical_bleedingCoefficient = 1.2;
force ace_medical_painCoefficient = 1;
force ace_medical_enableAdvancedWounds = true;
force ace_medical_enableVehicleCrashes = true;
force ace_medical_enableScreams = true;
force ace_medical_playerDamageThreshold = 1;
force ace_medical_AIDamageThreshold = 1;
force ace_medical_enableUnconsciousnessAI = 0;
force ace_medical_remoteControlledAI = true;
force ace_medical_preventInstaDeath = true;
force ace_medical_enableRevive = 1;
force ace_medical_maxReviveTime = 1200;
force ace_medical_amountOfReviveLives = -1;
force ace_medical_allowDeadBodyMovement = false;
ace_medical_allowLitterCreation = true;
ace_medical_litterSimulationDetail = 3;
ace_medical_litterCleanUpDelay = 0;
force ace_medical_medicSetting_basicEpi = 0;
force ace_medical_medicSetting_PAK = 1;
force ace_medical_medicSetting_SurgicalKit = 2;
force ace_medical_consumeItem_PAK = 1;
force ace_medical_consumeItem_SurgicalKit = 1;
force ace_medical_useLocation_basicEpi = 0;
force ace_medical_useLocation_PAK = 3;
force ace_medical_useLocation_SurgicalKit = 0;
force ace_medical_useCondition_PAK = 0;
force ace_medical_useCondition_SurgicalKit = 1;
force ace_medical_keepLocalSettingsSynced = true;
force ace_medical_healHitPointAfterAdvBandage = true;
force ace_medical_painIsOnlySuppressed = true;
ace_medical_painEffectType = 0;
force ace_medical_allowUnconsciousAnimationOnTreatment = true;
force ace_medical_moveUnitsFromGroupOnUnconscious = false;
ace_medical_menuTypeStyle = 0;
ace_medical_delayUnconCaptive = 3;
force ace_medical_ai_enabledFor = 0;
ace_medical_menu_allow = 1;
ace_medical_menu_useMenu = 0;
ace_medical_menu_openAfterTreatment = true;
ace_medical_menu_maxRange = 3;
// ace mortar
force ace_mk6mortar_airResistanceEnabled = true;
force ace_mk6mortar_allowComputerRangefinder = false;
force ace_mk6mortar_allowCompass = false;
force ace_mk6mortar_useAmmoHandling = true;
// ace nametags
ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
ace_nametags_showPlayerNames = 1;
force ace_nametags_showPlayerRanks = false;
ace_nametags_showVehicleCrewInfo = true;
ace_nametags_showNamesForAI = false;
ace_nametags_showCursorTagForVehicles = false;
ace_nametags_showSoundWaves = 1;
ace_nametags_playerNamesViewDistance = 5;
ace_nametags_playerNamesMaxAlpha = 0.8;
ace_nametags_tagSize = 2;
// ace nightvision
force ace_nightvision_disableNVGsWithSights = false;
force ace_nightvision_fogScaling = 1;
force ace_nightvision_effectScaling = 1;
// ace overheating
ace_overheating_displayTextOnJam = true;
ace_overheating_showParticleEffects = true;
ace_overheating_showParticleEffectsForEveryone = false;
force ace_overheating_overheatingDispersion = true;
force ace_overheating_unJamOnreload = true;
force ace_overheating_unJamFailChance = 0.2;
force ace_overheating_enabled = true;
// ace pylons
force ace_pylons_enabled = true;
force ace_pylons_rearmNewPylons = false;
force ace_pylons_searchDistance = 15;
force ace_pylons_timePerPylon = 5;
force ace_pylons_requireEngineer = false;
force ace_pylons_requireToolkit = true;
// ace quickmount
ace_quickmount_enabled = false;
ace_quickmount_distance = 3;
ace_quickmount_speed = 18;
ace_quickmount_priority = 0;
// ace rearm
force ace_rearm_level = 2;
force ace_rearm_supply = 1;
// ace respawn
force ace_respawn_savePreDeathGear = true;
force ace_respawn_removeDeadBodiesDisconnected = true;
force ace_respawn_bodyRemoveTimer = 120;
// ace scopes
force ace_scopes_enabled = true;
force ace_scopes_forceUseOfAdjustmentTurrets = false;
force ace_scopes_correctZeroing = true;
force ace_scopes_overwriteZeroRange = false;
force ace_scopes_defaultZeroRange = 100;
force ace_scopes_zeroReferenceTemperature = 15;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force ace_scopes_zeroReferenceHumidity = 0;
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = false;
ace_scopes_useLegacyUI = false;
force ace_scopes_simplifiedZeroing = false;
// ace spectator
force ace_spectator_enableAI = false;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;
// ace switch units
force ace_switchunits_enableSwitchUnits = false;
force ace_switchunits_switchToWest = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_enableSafeZone = false;
force ace_switchunits_safeZoneRadius = 100;
// ace tagging
force ace_tagging_quickTag = 0;
// ace UI
ace_ui_allowSelectiveUI = true;
ace_ui_soldierVehicleWeaponInfo = true;
ace_ui_vehicleRadar = true;
ace_ui_vehicleCompass = true;
ace_ui_commandMenu = true;
ace_ui_groupBar = false;
ace_ui_weaponName = true;
ace_ui_weaponNameBackground = true;
ace_ui_firingMode = true;
ace_ui_ammoType = true;
ace_ui_ammoCount = false;
ace_ui_magCount = true;
ace_ui_throwableName = true;
ace_ui_throwableCount = true;
ace_ui_zeroing = true;
ace_ui_weaponLowerInfoBackground = true;
ace_ui_stance = true;
ace_ui_staminaBar = true;
ace_ui_gunnerWeaponName = true;
ace_ui_gunnerWeaponNameBackground = true;
ace_ui_gunnerFiringMode = true;
ace_ui_gunnerAmmoType = true;
ace_ui_gunnerAmmoCount = true;
ace_ui_gunnerMagCount = true;
ace_ui_gunnerLaunchableName = true;
ace_ui_gunnerLaunchableCount = true;
ace_ui_gunnerZeroing = true;
ace_ui_gunnerWeaponLowerInfoBackground = true;
ace_ui_vehicleName = true;
ace_ui_vehicleNameBackground = true;
ace_ui_vehicleFuelBar = true;
ace_ui_vehicleSpeed = true;
ace_ui_vehicleAltitude = true;
ace_ui_vehicleDamage = true;
ace_ui_vehicleInfoBackground = true;
// ace vehiclelock
ace_vehiclelock_defaultLockpickStrength = 10;
ace_vehiclelock_lockVehicleInventory = false;
ace_vehiclelock_vehicleStartingLockState = -1;
// ace viewdistance
force ace_viewdistance_enabled = true;
ace_viewdistance_viewDistanceOnFoot = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_limitViewDistance = 10000;
force ace_viewdistance_objectViewDistanceCoeff = 6;
// ace weapons
force ace_laserpointer_enabled = true;
force ace_reload_displayText = true;
force ace_common_persistentLaserEnabled = true;
// ace weather
force ace_weather_enabled = true;
force ace_weather_updateInterval = 60;
force ace_weather_windSimulation = true;
// ace wind
force ace_winddeflection_enabled = true;
force ace_winddeflection_vehicleEnabled = true;
force ace_winddeflection_simulationInterval = 0.05;
// ace Zeus
force ace_zeus_zeusAscension = false;
force ace_zeus_zeusBird = false;
force ace_zeus_remoteWind = false;
force ace_zeus_radioOrdnance = false;
force ace_zeus_revealMines = 0;
force ace_zeus_autoAddObjects = false;
// ACEX sitting
force acex_sitting_enable = true;
// ACEX viewrestriction
force acex_viewrestriction_mode = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveSea = 0;
force acex_volume_enabled = false;
// ACEX Volume
acex_volume_reduction = 5;
acex_volume_fadeDelay = 1;
acex_volume_lowerInVehicles = false;
acex_volume_showNotification = true;
acex_volume_remindIfLowered = false;
// aceX Headless
force acex_headless_enabled = true;
force acex_headless_delay = 15;
force acex_headless_endMission = 0;
force acex_headless_log = false;
// ace uncathegorized
force ace_inventory_inventoryDisplaySize = 0;
force ace_laser_dispersionCount = 2;
ace_weaponselect_displayText = true;
force ace_microdagr_mapDataAvailable = 1;
ace_movement_useImperial = false;
ace_optionsmenu_showNewsOnMainMenu = true;
ace_overpressure_distanceCoefficient = 1;
ace_gestures_showOnInteractionMenu = 2;
ace_noradio_enabled = true;
ace_parachute_hideAltimeter = true;
force ace_gforces_enabledFor = 2;
force ace_hitreactions_minDamageToTrigger = 0.1;
