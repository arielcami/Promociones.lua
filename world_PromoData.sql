-- EJECUTAR EN LA BASE DE DATOS WORLD. LO DEMÁS SE INSTALA DESDE EL SCRIPT AUTOMÁTICAMENTE.
SET
@ENTR0 = 500,
@TEXT0 = "¡Hola $n!\n\n¡Te doy la bienvenida formal al servidor!\nEstamos felices de tenerte y contar contigo.\n\nMi trabajo es regalarte tu equipo según la opción que elijas.\n\nElige tu rama de talentos y recibirás tu equipo de acuerdo a tu selección.\n\nUna vez recibas la promoción, esta quedará registrada en el sistema.\n\nQue te diviertas!!",
@ENTR1 = 501,
@TEXT1 = "Ahora debes elegir el equipo que vas a recibir de acuerdo a tu rol.\n\nSi eres Cazador, Pícaro, Mago, o Brujo, solo tendrás una opción.",
@ENTR2 = 502,
@TEXT2 = "¡Hola de nuevo $n!\n\nVeo que tu nombre figura en mis registros, en ese caso lo que puedo hacer por ti es ofrecerte un teletransporte gratuito a Dalaran.",
@ENTR3 = 503,
@TEXT3 = "¡Hola $n!\n\nConsta en mis registros que no hay más promociones disponibles para tu cuenta. En ese caso, solo puedo ofrecerte un teletransporte gratuito a Dalaran.",
@ENTR4 = 504,
@TEXT4 = "Hola $n.\n\nLamento comentarte que ya has agotado todas las promociones disponibles.\n\nAún así, puedo ofrecerte un teletransporte gratuito a Dalaran, ¿qué te parece?",

@NPC_ENTRY = 100000,
@NPC_NAME = "Siobahn Sombraluz",
@NPC_SUB = "Promoción de Bienvenida";

DELETE FROM `npc_text` WHERE `ID` IN (@ENTR0, @ENTR1, @ENTR2, @ENTR3, @ENTR4);

INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, 
`em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, 
`em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, 
`em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, 
`em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, 
`em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, 
`em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, 
`em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, 
`em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) 
VALUES 
(@ENTR0, @TEXT0, NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,
0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0),
(@ENTR1, @TEXT1, NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,
0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0),
(@ENTR2, @TEXT2, NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,
0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0),
(@ENTR3, @TEXT3, NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,
0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0),
(@ENTR4, @TEXT4, NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,
0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0);

DELETE FROM `creature_template` WHERE `entry` = @NPC_ENTRY;

INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, 
`KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, 
`gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, 
`speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, 
`BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, 
`trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, 
`PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, 
`ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, 
`mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(@NPC_ENTRY, 0, 0, 0, 0, 0, 21419, 0, 0, 0, @NPC_NAME, @NPC_SUB, "", 0, 80, 80, 2, 35, 1, 1.1, 1.14286, 1, 1, 20, 0.9, 3, 0, 1, 2000, 
2000, 1, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, "", 0, 1, 185, 185, 1, 1, 0, 0, 1, 0, 0, 0, "", 12340);
