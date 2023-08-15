-- Ariel Camilo - Agosto 2023. 

-- CONFIGURACIÓN --
    local SCRIPT_MODULE     = true  --> Habilita o deshabilita el Script.
    local PROMO_LEVEL       = 80    --> El nivel al que se subirán los jugadores. Recuerda que la ropa que vas a regalar, tiene restricciones de nivel.
    local PROMOS_PER_ACCOUNT= 1     --> Promos por cuenta.
    local PROMOS_PER_IP     = 1     --> Promos por IP.
    local GIFT_BAG          = {give=true, id=51809, amount=1} --> Decide si regalar una bolsa o no, el ID de la bolsa y la cantidad.
    local GOLD              = 2500  --> Escribe la cantidad de ORO que vas a regalar por promoción.
    local TEACH_RIDING      = true  --> Define si vas a regalar también todas las habilidades de jinete, incluyendo Vuelo en clima frío.
    local NPC_ID            = 100000 --> El Entry del NPC que hablará con los jugadores.
    local DK_HELPER         = true  --> Sacar a los DK de manera legal de su zona de inicio, solo al hacer login.

--[[*NOTA DE SEGURIDAD* Es recomendable que PROMOS_PER_ACCOUNT y PROMOS_PER_IP tengan un mismo valor, ya que este Script
    almacena una IP del jugador al momento de recibir la promo, significa que si el jugador se cambia la IP,
    en cuentas nuevas podría recibir más promociones de las que se definen acá. 
    Para evitar esto, este Script hace un UPDATE a TODAS las IP que han recibido promo en una cuenta AL MOMENTO DE 
    QUE SE LOGEA CUALQUIER PERSONAJE DE ESA CUENTA, esto es extremadamente seguro frente a un cambio de IP para promos
    en una misma cuenta, pero si el valor de PROMOS_PER_IP es mayor, no resulta tan seguro si el jugador cambia de IP.
    VALORES RECOMENDADOS: 1 o 2 para ambas variables, máximo.

    --> Los personajes promocionados tendrán un GearScore de entre 3030 a 3099, lo justo para poder anotar heroicas.
    --> Recomiendo que el modelo de NPC que uses, tenga animaciones de casteo.]]
--------------------------------------------------------------------------------------------------------------------

local weapons = { -- IDs de las spells de armas en el juego.
    [1]={264,2567,200,266,5011,1180,201,202,196,197,198,199,227,15590,750}, --Guerrero
    [2]={200,201,202,196,197,198,199,750},                                  --Paladín
    [4]={264,2567,200,266,5011,227,1180,201,202,196,197,15590,8737},        --Cazador
    [8]={264,2567,266,5011,1180,201,196,198,15590},                         --Pícaro
    [16]={227,1180,198,5009},                                               --Sacerdote
    [32]={200,201,202,196,197,198,199},                                     --Caballero de la Muerte
    [64]={227,1180,196,197,198,199,15590,8737},                             --Chamán
    [128]={227,1180,201,5009},                                              --Mago
    [256]={227,1180,201,5009},                                              --Brujo
    [1024]={200,227,1180,198,199,15590}}                                    --Druida

local armor = { -- Contiene todo lo que es Equipamiento: {Entry, Slot}
    [100]={-- Tank
        [1]={{37135,0},{37689,1},{37635,2},{37728,14},{37658,4},{41116,8},{37862,9},{37379,5},{37292,6},{37618,7},{37257,10},{37186,11},{37638,12},{35590,17},{37162,16},{37260,15}},
        [2]={{37135,0},{37689,1},{37635,2},{37728,14},{37658,4},{37682,8},{37862,9},{37379,5},{37292,6},{37618,7},{37257,10},{37186,11},{37638,12},{38363,17},{37162,16},{37260,15}},
        [32]={{37135,0},{37689,1},{37814,2},{37728,14},{37658,4},{44341,8},{37862,9},{37801,5},{37292,6},{37618,7},{37257,10},{38617,11},{37638,12},{40714,17},{36984,16},{37179,15}},
        [1024]={{43403,0},{43282,1},{37593,2},{37728,14},{44405,4},{37183,8},{37678,9},{37243,5},{37890,6},{37841,7},{37257,10},{45809,11},{37220,12},{38365,17},{43409,15}}},
    [200]={-- Melee DPS
        [1]={{37849,0},{37397,1},{37627,2},{37647,14},{37722,4},{44038,8},{39262,9},{37826,5},{37263,6},{43402,7},{42642,10},{43178,11},{37723,12},{37050,17},{43281,15}},
        [2]={{41344,0},{37397,1},{37627,2},{37647,14},{37722,4},{37217,8},{37874,9},{37178,5},{37263,6},{37367,7},{39401,10},{37151,11},{37166,12},{38362,17},{37733,15}},
        [4]={{37726,0},{37861,1},{37679,2},{43406,14},{44406,4},{37656,8},{37614,9},{37648,5},{37262,6},{37870,7},{37624,10},{37685,11},{37166,12},{43284,17},{37848,15}},
        [8]={{37636,0},{37861,1},{37593,2},{43406,14},{37165,4},{37366,8},{37678,9},{37243,5},{37890,6},{37841,7},{37624,10},{37685,11},{37723,12},{37410,17},{37181,15},{37037,16}},
        [32]={{41344,0},{37397,1},{37627,2},{37647,14},{37722,4},{41355,8},{37874,9},{37826,5},{37263,6},{37367,7},{39401,10},{37151,11},{37166,12},{40822,17},{37871,16},{37871,15}},
        [64]={{43311,0},{37096,1},{37373,2},{37840,14},{37800,4},{37656,8},{37639,9},{37845,5},{37221,6},{37870,7},{37685,10},{36979,11},{37390,12},{40710,17},{37871,15}},
        [1024]={{37636,0},{37861,1},{37593,2},{37840,14},{37219,4},{37366,8},{37678,9},{37714,5},{37890,6},{37666,7},{37624,10},{37685,11},{37166,12},{37573,17},{37848,15}}},
    [300]={-- Spell DPS
        [16]={{37594,0},{37595,1},{37655,2},{37291,14},{37851,4},{37725,8},{37843,9},{37680,5},{37369,6},{37218,7},{37232,10},{43408,11},{37873,12},{37617,15},{37824,17}},
        [64]={{37592,0},{37595,1},{37875,2},{37291,14},{43410,4},{37365,8},{43212,9},{37868,5},{37818,6},{37654,7},{39389,10},{43177,11},{37873,12},{37377,15},{37061,16},{40708,17}},
        [128]={{37594,0},{37595,1},{37655,2},{37291,14},{37851,4},{37725,8},{37843,9},{37680,5},{37369,6},{37218,7},{37232,10},{43408,11},{37873,12},{37617,15},{37824,17}},
        [256]={{37594,0},{37595,1},{37655,2},{37291,14},{37851,4},{37725,8},{37843,9},{37680,5},{37369,6},{37218,7},{37232,10},{43408,11},{37873,12},{37617,15},{37824,17}},
        [1024]={{37180,0},{37595,1},{43258,2},{37291,14},{37236,4},{37634,8},{37858,9},{38616,5},{37389,6},{37070,7},{39389,10},{49123,11},{37873,12},{37617,15},{38360,17}}},
    [400]={-- Heal
        [2]={{44411,0},{37683,1},{37376,2},{37630,14},{37672,4},{37288,8},{37729,9},{37152,5},{37717,6},{43405,7},{35589,10},{37232,11},{37660,12},{37681,15},{39233,16},{38364,17}},
        [16]={{37594,0},{37290,1},{37655,2},{37630,14},{37641,4},{37613,8},{37843,9},{37637,5},{37369,6},{37730,7},{43408,10},{37232,11},{37660,12},{37384,15},{37824,17}},
        [64]={{37857,0},{37628,5},{37398,2},{37686,9},{37365,8},{37256,4},{37155,6},{37654,7},{43358,1},{37371,10},{43408,11},{49078,12},{37291,14},{40709,17},{37681,15},{44032,16}},
        [1024]={{36948,0},{43164,5},{37652,2},{37858,9},{37725,8},{37641,4},{37389,6},{37640,7},{37683,1},{37799,14},{39231,10},{37732,11},{40685,12},{40711,17},{37384,15}}}
}   
    -- Funciones para llamar luego ------------------------------------------------------------------------
    local function GOSSIP (Player, mesg, send, intid, bool, boxtext) 
        Player:GossipMenuAddItem(8, mesg, send, intid, bool, boxtext) 
    end

    local function LEARN_WEAPONS(Player, class) -- Enseñar habilidades de armas
        for id = 1, #weapons[class] do
            if not Player:HasSpell(weapons[class][id]) then Player:LearnSpell(weapons[class][id]) end
        end
        Player:AdvanceSkillsToMax()
    end ---------------------------------------------------------------------------------------------

    local function EQUIP (Player, build, class) ------------------------------------------------------------
        for i=0,38 do --> Elimina todo el equipo, incuyendo todo en el inventario.
            if Player:GetItemByPos(255,i) then 
                Player:RemoveItem(Player:GetItemByPos(255,i):GetEntry(), 1)	
            end 
        end
        for i=1, #armor[build][class] do --> Equipa los objetos de promoción.
            local entry_slot = armor[build][class][i]
            --Player:SendBroadcastMessage("Item: "..entry_slot[1].."  Slot: "..entry_slot[2]) DEBUG
            Player:EquipItem(entry_slot[1], entry_slot[2])
        end
        -- Objetos que no se pueden equipar sin ciertos talentos.
        if build==200 then -- DPS Melee
            if class==1 then Player:AddItem(43281) end       --> El Guerrero necesita empuñadura de titán.
            if class==4 then Player:AddItem(41165, 2000) end --> El Cazador necesita flechas.
            if class==64 then Player:AddItem(37871) end      --> El Chamán mejora necesita Doble empuñadura.
        end

        if GIFT_BAG.give then --> Bolsas de Regalo.

            if GIFT_BAG.amount >= 5 then --> Por si acaso se le ocurre a alguien poner más de 4 bolsas.
                bagAmount = 4 
            else 
                bagAmount = GIFT_BAG.amount 
            end

            for i=1, bagAmount do
                Player:EquipItem(GIFT_BAG.id, 18+i)
            end
        end
    end ----------------------------------------------------------------------------------------------------

local classRoles = { -- Definiciones de roles para las clases.
[1]     = { tank = true,    melee = true,   spell = false,  heal = false    },  -- Guerrero
[2]     = { tank = true,    melee = true,   spell = false,  heal = true     },  -- Paladín
[4]     = { tank = false,   melee = true,   spell = false,  heal = false    },  -- Cazador
[8]     = { tank = false,   melee = true,   spell = false,  heal = false    },  -- Pícaro
[16]    = { tank = false,   melee = false,  spell = true,   heal = true     },  -- Sacerdote
[32]    = { tank = true,    melee = true,   spell = false,  heal = false    },  -- Caballero de la Muerte
[64]    = { tank = false,   melee = true,   spell = true,   heal = true     },  -- Chamán
[128]   = { tank = false,   melee = false,  spell = true,   heal = false    },  -- Mago
[256]   = { tank = false,   melee = false,  spell = true,   heal = false    },  -- Brujo
[1024]  = { tank = true,    melee = true,   spell = true,   heal = true     }}  -- Druida   

local i,sub = { -- Iconos de ramas de talentos de clase, al fondo están el de Promo y Teletransporte a Dalaran.
    [1]= {
        [1] = 'ability_warrior_defensivestance',--> Protección
        [2] = 'ability_warrior_innerrage'},     --> Furia              
    [2]={
        [1] = 'spell_holy_devotionaura',        --> Protección
        [2] = 'spell_holy_auraoflight',         --> Reprensión 
        [4] = 'spell_holy_holybolt'},           --> Sagrado 
    [4]={[2] = 'ability_marksmanship'},         --> Puntería     
    [8]={[2] = 'ability_backstab'},             --> Combate    
    [16]={
        [3] = 'spell_shadow_shadowwordpain',    --> Magia Sombría
        [4] = 'spell_holy_holybolt'},           --> Sagrado
    [32]={
        [1] = 'spell_deathknight_frostpresence', --> Escarcha
        [2] = 'spell_deathknight_unholypresence'},--> Profano
    [64]={
        [2] = 'spell_nature_lightningshield',   --> Mejora
        [3] = 'spell_nature_lightning',         --> Elemental 
        [4] = 'spell_nature_magicimmunity'},    --> Restauración 
    [128]={[3] = 'spell_fire_flamebolt'},       --> Fuego
    [256]={[3] = 'spell_shadow_deathcoil'},     --> Aflicción
    [1024]={
        [1] = 'ability_racial_bearform',        --> Combate Feral/Oso
        [2] = 'ability_druid_catform',          --> Combate Feral/Felino
        [3] = 'spell_nature_starfall',          --> Equilibrio 
        [4] = 'spell_nature_healingtouch'},     --> Restauración
    [3] = "|TInterface\\Icons\\spell_holy_fanaticism:45:45:-21|t",        --> Icono de Promo
    [5] = "|TInterface\\Icons\\spell_arcane_teleportdalaran:45:45:-21|t", --> Teleporte a Dalaran 
}, '|TInterface\\Icons\\%s:45:45:-21|t' --> String para hacer sustitución.

local function Hello (E,P,U) -- Esta función abre la ventana de diálogo del NPC.

    if SCRIPT_MODULE then

        local IP, G, N, ACC = P:GetPlayerIP(), P:GetGUIDLow(), P:GetName(), P:GetAccountId()

        -- Consultas SQL para obtener información sobre las promociones. Solo declaración.
        local getPromosPerPlayer        = string.format("SELECT `promos` FROM `aa_promotion` WHERE `pguid` = %d", G)
        local getSumPromosPerAccount    = string.format("SELECT SUM(promos) FROM `aa_promotion` WHERE `account` = %d", ACC)
        local getSumPromosPerIP         = string.format("SELECT SUM(promos) FROM `aa_promotion` WHERE `ip` = '%s'", IP) 
        -- Recuperamos desde la DB. 
        local CHECK_CHARACTER = CharDBQuery(getPromosPerPlayer)      

        if CHECK_CHARACTER:GetInt8(0) ~= 0 then --> El jugador ya recibió una promoción.

            P:SendBroadcastMessage("|cffff0000Este personaje ya fue promocionado.")

            if P:GetLevel() >= PROMO_LEVEL then
                GOSSIP(P, i[5].."Aceptar teletransporte a Dalaran", 555, 0)
                P:GossipSendMenu(502, U)
            end
            U:PerformEmote(274)
            return --> CAAAASO CERRAAAADOOO WOO WOO!
        else
            -- El jugador no ha recibido promo, pero puede que con otro personaje de la misma cuenta sí. Verifiquemos.
            local CHECK_ACCOUNT = CharDBQuery(getSumPromosPerAccount)

            if CHECK_ACCOUNT:GetInt8(0) ~= 0 then --> El jugador ya recibió promo con otro personaje de la misma cuenta.

                if CHECK_ACCOUNT:GetInt8(0) >= PROMOS_PER_ACCOUNT then --> El jugador llegó al límite de promos por cuenta.

                    P:SendBroadcastMessage("|cffff0000Has llegado al límite de promociones en una misma cuenta.")

                    if P:GetLevel() >= PROMO_LEVEL then
                        GOSSIP(P,   i[5].."Aceptar teletransporte a Dalaran", 555, 0)
                        P:GossipSendMenu(503, U)
                    end
                    U:PerformEmote(274)
                    return --> CAAAASO CERRAAAADOOO WOO WOO! 
                else
                    -- El jugador no ha llegado al límite de promos por cuenta.
                    P:GossipClearMenu()      
                    GOSSIP(P, i[3].."¡Recibir mi promoción!", 1, 0)
                    P:GossipSendMenu(500, U)
                end           
            else -- El jugador no ha recibido promo con otro personaje de la cuenta, pero puede que con otra cuenta sí. Verifiquemos.
                
                local CHECK_IP = CharDBQuery(getSumPromosPerIP)

                if CHECK_IP:GetInt8(0) >= PROMOS_PER_IP then -- El jugador usó todas las promos disponibles.
                    
                    P:SendBroadcastMessage("|cffff0000Agotaste todas las promociones disponibles.")

                    if P:GetLevel() >= PROMO_LEVEL then
                        GOSSIP(P,   i[5].."Aceptar teletransporte a Dalaran", 555, 0)
                        P:GossipSendMenu(504, U)
                    end
                    U:PerformEmote(274)
                    return --> CAAAASO CERRAAAADOOO WOO WOO!
                else  -- El jugador aún no ha usado todas las promos disponibles.                
                    if CHECK_IP:GetInt8(0)==0 then --> El jugador no ha recibido promoción en otra cuenta.
                        P:GossipClearMenu()      
                        GOSSIP(P, i[3].."¡Recibir mi promoción!", 1, 0)
                        P:GossipSendMenu(500, U)
                    else 
                    -- El jugador recibió promo en otra cuenta, pero aún no llega al límite. 
                        P:GossipClearMenu()      
                        GOSSIP(P, i[3].."¡Recibir mi promoción!", 1, 0)
                        P:GossipSendMenu(500, U) 
                    end
                end        
            end
        end
    end          
end   RegisterCreatureGossipEvent(NPC_ID, 1, Hello)

local function Click (event, P, U, S, I) 

    if SCRIPT_MODULE then

        local L, C, R, N = P:GetLevel(), P:GetClassMask(), P:GetRaceMask(), P:GetName()
        local G, IP, AC = P:GetGUIDLow(), P:GetPlayerIP(), P:GetAccountId()

        if S==555 then  --> ¡Recibir mi promoción!

            if U:IsCasting() then --> No permitir otro teletransporte miestras que el NPC está casteando.
                P:GossipComplete() 
                U:SendUnitSay(N..", ¿Podrías esperar a que termine este hechizo?", 0)            
                return
            end

            U:CastSpell(P, 63826, false) --> El NPC Comienza a castear un Teleport de 10 segundos, pero este hechizo no hace nada.
    
            local function Visual (ev, d, r, pla) --> 8.76s luego, hacemos que salga un brillo del jugador (Solo visual).
                pla:CastSpell(pla, 42516, true) 
            end
            P:RegisterEvent(Visual,8760) --> Registramos la función Visual, que se desencadenará en 8.76 segundos.   

            local function Port (ev, d, r, O) --> 10s después, el jugador se teletransporta.
                O:Teleport(571, 5796.120117, 628.556101, 647.398621, 0.9089) 
            end        
            P:RegisterEvent(Port, 10000) --> Registramos la función Port, que se desencadenará en 10 segundos.   
            
            U:SendUnitSay("Una vez en Dalaran, recuerda colocar tu hogar allá. ¡Buen viaje "..N.."!", 0)
            P:GossipComplete()
            return
        end

        if (S+I==1) then --> Opciones de equipo de acuerdo al rol.

            local roles = classRoles[C]        
            local iT,iM = string.format(sub, i[C][1]), string.format(sub, i[C][2]) --> Strings de los íconos Tank y Melee
            local iS,iH = string.format(sub, i[C][3]), string.format(sub, i[C][4])
            local msg = "Primero tengo que eliminar todos tus objetos equipados y en inventario. ¿Deseas continuar?"

            P:GossipClearMenu()

            if roles.tank then
                GOSSIP(P,   iT.."Tanque",       100, C, false, msg)
            end
            if roles.melee then
                GOSSIP(P,   iM.."DPS Melee",    200, C, false, msg)
            end
            if roles.spell then
                GOSSIP(P,   iS.."DPS Mágico",   300, C, false, msg)
            end
            if roles.heal then
                GOSSIP(P,   iH.."Sanador",      400, C, false, msg)
            end
            P:GossipSendMenu(501, U)
        end 

        if S>=100 then --> Se accede aquí en todas las BUILDS.
            P:SetLevel(PROMO_LEVEL)
            LEARN_WEAPONS(P,C)
            EQUIP(P,S,C)
            P:ModifyMoney(GOLD * 10000)
            if TEACH_RIDING then 
                local ridingSpells = {33388, 33391, 34090, 34091, 54197}
                for i=1,5 do P:LearnSpell(ridingSpells[i]) end
            end
            P:GossipComplete()
            CharDBExecute("UPDATE `aa_promotion` SET `promos` = promos+1 WHERE `pguid` = "..G)
            P:SendBroadcastMessage("|cff00ff00¡Promoción registrada exitosamente!")
            U:PerformEmote(4)
        end
    end
end     RegisterCreatureGossipEvent(NPC_ID, 2, Click)

local function LogIn(e, P) --> Al logear.
    local N, G, A, I = P:GetName(), P:GetGUIDLow(), P:GetAccountId(), P:GetPlayerIP()
    local query = string.format("INSERT IGNORE INTO `aa_promotion` VALUES ('%s', %d, %d, '%s', 0)", N, G, A, I)
    CharDBExecute(query)
    CharDBExecute("UPDATE `aa_promotion` SET `ip` = '"..I.."' WHERE `account` = "..A) --> Actualizamos IP cada vez que se hace login.

    if DK_HELPER and (P:GetClassMask() == 32) and (P:GetLevel() == 55) then --> Solo para DKs recién nacidos.

        local RAZ = {[1]={12742}, [2]={12748}, [4]={12744}, [8]={12743}, [16]={12750}, 
        [32]={12739}, [64]={12745}, [128]={12749}, [512]={12747}, [1024]={12746}}

        local HO1 = {12593,12619,12842,12848,12636,12641,12657,12849,12850,12670,12678,12680,12679,12733,12687,12697,
                    12698,12700,12701,12706,12714,12716,12715,12719,12722,12720,12723,12724,12725,12727,12738}
        local AL1 = {12593,12619,12842,12848,12636,12641,12657,12849,12850,12670,12678,12680,12679,12733,12687,12697,
                    12698,12700,12701,12706,12714,12716,12715,12719,12722,12720,12723,12724,12725,12727,12738}
        local HO2 = {12751,12754,12755,12756,12757,12778,12779,12800,12801,13165,13166,13189}
        local AL2 = {12751,12754,12755,12756,12757,12778,12779,12800,12801,13165,13166,13188}

        local H, R = P:IsHorde(), P:GetRaceMask()
        local function Quests(ob,qq) ob:AddQuest(qq) ob:CompleteQuest(qq) ob:RewardQuest(qq) end

        local function delayed (Ev, del, rep, p)
            p:Say("Completando misiones...",0)
            if p:IsHorde() then   
                for i=1, #HO1 do 
                    Quests(p, HO1[i]) 
                end 
                Quests(p, RAZ[R][1])
                for i=1, #HO2 do 
                    Quests(p, HO2[i]) 
                end
                p:SetLevel(58) 
                p:Teleport(1, 1643.5269, -4411.58, 16.9977, 5.1409) 
            else    
                for i=1, #AL1 do 
                    Quests(p, AL1[i]) 
                end 
                Quests(p, RAZ[R][1]) 
                for i=1, #AL2 do 
                    Quests(p, AL2[i]) 
                end
                p:SetLevel(58) 
                p:Teleport(0, -8843.5966, 642.2538, 95.8736, 5.4346)
            end
            p:AddItem(38632, 1)
        end  
        P:RegisterEvent(delayed, 2000) 
    end
end     RegisterPlayerEvent(3,  LogIn)

local function LogOut(e, P) --> Al deslogear.
    local G = P:GetGUIDLow()
    local query = string.format("DELETE FROM `aa_promotion` WHERE `pguid` = %d AND `promos` = 0", G)
    CharDBExecute(query)
end     RegisterPlayerEvent(4,  LogOut)

local function ElunaReload(e) --> Al Eluna hacer reload.
    local q = "CREATE TABLE IF NOT EXISTS `aa_promotion` (`name` VARCHAR(14) NOT NULL, `pguid` MEDIUMINT(6) UNSIGNED NOT NULL, "
    .."`account` SMALLINT(5) UNSIGNED NOT NULL, `ip` VARCHAR(16) NOT NULL, `promos` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',  UNIQUE KEY `pguid` (`pguid`))"
    CharDBExecute(q)
end     RegisterServerEvent(33, ElunaReload)

--[[ DEBUG
local function equip(event, P, item, bag, slot)
    --DEBUG
    P:SendBroadcastMessage( "Slot "..slot..": "..GetItemLink(item:GetEntry(),7).." "..item:GetEntry())
end     RegisterPlayerEvent(29, equip)
]]
