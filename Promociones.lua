--[[
	Ariel Camilo // 15 de Junio 2022
	
	> Cambia los IDs por los items que quieras promocionar de acuerdo al slot (Sócalo o caída) en la variable GEAR.
	> El Oro se otorga solo 1 vez por Ip. Solo el primer personaje del jugador recibirá el oro.
]]
-------------------------------------------------------------------------------
local Level = 80 	 		 --> Nivel al que suben los jugadores al ser promocionados.
local NPC_ID = 200003 		 --> El ID del NPC que estará a cargo del Script.
local Promos = 2 	  		 --> Número de promociones permitidas por IP.
local Oro = {12500,'12,500'} --> Coloca la cantidad de Oro que desees regalar, y entre comillas su contraparte textual.
local Borrar_Items_DK = true --> Coloca true si quieres que al DK se le elimine todo el equipo de nacimiento y misiones de zona.

local GEAR = {
--Nota: Los slots que veas con ID 25 y 17, significa que estan vacíos, nunca coloques el Cero porque crashea el emulador.
--COLOCA LOS IDS DE LOS ITEMS QUE DESEAS REGALAR, DE ACUERDO AL ORDEN MENCIONADO ABAJO.
--ORDEN: {Cabeza,Hombro,Aba1,Aba2,Cuello,Pecho,Cintura,Piernas,Pies,Muñeca,Manos,Dedo1,Dedo2,Espalda,MainHand,OffHand,Rango-Reliquia,Camisa,Tabardo}
	[1]= {--Guerrero
		[1]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},  --|> 1=Tank , 2=Melee DPS , 3=Heal , 4=Spell DPS
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},	
	[2]={--Paladín
		[1]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[3]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}}, --|> Nota: El item ID 25 es una espada de una mano de calidad gris.
	[4]={--Cazador																		   --|>       Por esto, en el slot de arma principal, está el ID 17
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}}, --|>       para no equipar esta arma, el item ID 17 es una camisa,
	[8]={--Pícaro																		   --|>       por ende, no entra en el slot de arma.
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[16]={--Sacerdote
		[3]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[4]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[32]={--Caballero de la Muerte
		[1]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[64]={--Chamán
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[3]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[4]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[128]={--Mago
		[4]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[256]={--Brujo
		[4]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}},
	[1024]={--Druida
		[1]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[2]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[3]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25},
		[4]={25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 17, 25, 25, 25, 25}}}

----------------NO TOCAR NADA DESDE ESTA LINEA PARA ABAJO/ /NO SOY RESPONSABLE POR EL BUEN O MAL USO QUE LE DES A ESTE SCRIPT-------------------
local War,Pal,Hun,Rog,Pri,Dea,Sha,Mag,Loc,Dru,Tank,Mele,Heal,Spel = 1,2,4,8,16,32,64,128,256,1024,1,2,3,4

local CLASE_M = {[1]='|cffc49c79Guerrero',[2]='|cffff94f8Paladín',[4]='|cffa0c156Cazador',[8]='|cfff6f350Pícaro',[16]='|cffffffffSacerdote',
[32]='|cffe60000Caballero de la Muerte',[64]='|cff0066d3Chamán',[128]='|cff6ed4edMago',[256]='|cff9283c4Brujo',[1024]='|cffff7c0cDruida'}

local RAZA_M = {[1]='|cff00a6ffHumano',[2]='|cffff0000Orco',[4]='|cff00a6ffEnano',[8]='|cff00a6ffElfo de la noche',[16]='|cffff0000No-muerto',
[32]='|cffff0000Tauren',[64]='|cff00a6ffGnomo',[128]='|cffff0000Trol',[512]='|cffff0000Elfo de sangre',[1024]='|cff00a6ffDraenei'}

local CLASE_F = {[1]='|cffc49c79Guerrera',[2]='|cffff94f8Paladín',[4]='|cffa0c156Cazadora',[8]='|cfff6f350Pícara',[16]='|cffffffffSacerdotisa',
[32]='|cffe60000Caballero de la Muerte',[64]='|cff0066d3Chamán',[128]='|cff6ed4edMaga',[256]='|cff9283c4Bruja',[1024]='|cffff7c0cDruida'} 

local RAZA_F = {[1]='|cff00a6ffHumana',[2]='|cffff0000Orco',[4]='|cff00a6ffEnana',[8]='|cff00a6ffElfa de la noche',[16]='|cffff0000No-muerta',
[32]='|cffff0000Tauren',[64]='|cff00a6ffGnoma',[128]='|cffff0000Trol',[512]='|cffff0000Elfa de sangre',[1024]='|cff00a6ffDraenei'}

local build = {'Tanque','Dps','Sanador','Dps Mágico'}
local slot = {0,2,12,13,1,4,5,6,7,8,9,10,11,14,15,16,17,3,18}

local tele = {
	[1]={--Horda
		[1]={1,1973.1132,-4806.0541,56.9906,3.8756},
		[2]={1,1940.2440,-4135.4541,41.1504,1.9697},
		[4]={1,2099.4428,-4609.5781,58.7555,1.1808},
		[8]={1,1773.0922,-4285.6933,7.71330,2.4095},
		[16]={1,1454.6048,-4180.5722,44.2779,2.7446}, 
		[32]={0,2416.3181,-5527.8237,377.0371,2.2317},
		[64]={1,1932.6849,-4226.6005,42.3219,1.0272},
		[128]={1,1472.1286,-4219.9423,43.1862,0.6991},
		[256]={1,1841.8643,-4353.7744,-14.6552,0.1511},
		[1024]={1,-1042.2668,-281.67870,159.0306,6.2734}},
	[0]={--Alianza
		[1]={0,-8687.3671,323.9260,109.4382,2.8385},
		[2]={0,-8575.7675,880.1903,106.5188,2.2235},
		[4]={0,-8411.9501,548.7685,95.44980,6.1365},
		[8]={0,-8751.6669,379.6466,101.0565,4.3465},
		[16]={0,-8511.2675,860.1799,109.8404,1.9268},
		[32]={0,2416.3181,-5527.8237,377.0371,2.2317},
		[64]={0,-9030.5341,548.3551,72.46240,2.1439},
		[128]={0,-9010.0117,869.2788,29.6211,3.8402},
		[256]={0,-8980.4814,1038.5538,101.4043,1.3515},
		[1024]={0,-8775.5937,1097.5905,92.53930,1.7016}}}

local SKI = {--Habilidades con armas
	[1]={264,2567,200,266,5011,1180,201,202,196,197,198,199,227,15590},
	[2]={200,201,202,196,197,198,199},
	[4]={264,2567,200,266,5011,227,1180,201,202,196,197},
	[8]={264,2567,266,5011,1180,201,196,198},
	[16]={227,1180,198,5009},
	[32]={200,201,202,196,197,198,199},
	[64]={227,1180,196,197,198,199,15590},
	[128]={227,1180,201,5009},
	[256]={227,1180,201,5009},
	[1024]={200,227,1180,198,199,15590}}
---------------------------------------------------------------------------------------------------------------------------------------

local function Saludo(e,p,u)		local G, ip, acc, C = tonumber(p:GetGUIDLow()), p:GetPlayerIP(), p:GetAccountId(), p:GetClassMask()

	local count = AuthDBQuery("SELECT COUNT(promos) FROM `_promos` WHERE ip = '"..ip.."'")
	local X1 = count:GetInt8(0)

	local U = AuthDBQuery("SELECT SUM(promos) FROM _promos WHERE ip = '"..ip.."'")
	local X2 = U:GetInt8(0)

	if X2 == Promos then 
		u:SendUnitSay('Lo siento '..p:GetName()..', ya agostaste las promociones disponibles para ti.',0)
		p:SendBroadcastMessage("|cffff47f0Promociones recibidas: |cffff0000"..X2)
		return 
	end

	if X1 <= Promos then p:SendBroadcastMessage("|cffff47f0Promociones recibidas: |cff00ddff"..X2)
		p:GossipClearMenu()
		if C==War then p:GossipMenuAddItem(0,"Set Guerrero Protección", C,Tank)	p:GossipMenuAddItem(0,"Set Guerrero DPS" , C,Mele)
	elseif C==Pal then p:GossipMenuAddItem(0,"Set Paladín Protección", C,Tank) p:GossipMenuAddItem(0, "Set Paladín Reprensión", C,Mele) 
					   p:GossipMenuAddItem(0,"Set Paladín Sagrado", C,Heal)
	elseif C==Hun then p:GossipMenuAddItem(0,"Set Cazador",  C,Mele)
	elseif C==Rog then p:GossipMenuAddItem(0,"Set Pícaro",  C,Mele)
	elseif C==Pri then p:GossipMenuAddItem(0,"Set Sacerdote DPS",C,Spel) p:GossipMenuAddItem(0,"Set Sacerdote Sagrado",C,Heal)
	elseif C==Dea then p:GossipMenuAddItem(0,"Set Caballero de la Muerte Tank",C,Tank) p:GossipMenuAddItem(0,"Set Caballero de la Muerte DPS",C,Mele)		
	elseif C==Sha then p:GossipMenuAddItem(0,"Set Chamán Mejora",C,Mele) p:GossipMenuAddItem(0,"Set Chamán Elemental",C,Spel)
					   p:GossipMenuAddItem(0,"Set Chamán Restauración", C,Heal)
	elseif C==Mag then p:GossipMenuAddItem(0,"Set Mago",C,Spel)
	elseif C==Loc then p:GossipMenuAddItem(0,"Set Brujo",C,Spel)
	elseif C==Dru then p:GossipMenuAddItem(0,"Set Druida Feral/Oso", C,Tank) p:GossipMenuAddItem(0,"Set Druida Feral/Felino",  C,Mele)
					   p:GossipMenuAddItem(0,"Set Druida Balance",C,Spel) p:GossipMenuAddItem(0,"Set Druida Restauración", C,Heal)			
		end
		p:GossipSendMenu(1, u, MenuId)	
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local function MenuClick(e,p,u,s,int) p:GossipComplete() local R = p:GetRaceMask()

	if p:IsHorde() then F = 1 else F = 0 end
	if p:GetGender() == 0 then sex = 1 else sex = 0 end	
	--------------------------------------------------- 
	local ip,acc,N,Lev,C,G = p:GetPlayerIP(),p:GetAccountId(),p:GetName(),p:GetLevel(),tonumber(p:GetClassMask()),tonumber(p:GetGUIDLow())

	local Hom = '"|cff00ff04'..N..'|r"|cfff0edd5 '..RAZA_M[R]..' '..CLASE_M[C]..'|r, ha recibido su promoción! Rol: '..build[int]..'.'
	local Muj = '"|cff00ff04'..N..'|r"|cfff0edd5 '..RAZA_F[R]..' '..CLASE_F[C]..'|r, ha recibido su promoción! Rol: '..build[int]..'.'

	local Re = AuthDBQuery("SELECT promos FROM `_promos` WHERE ip = '"..ip.."' AND charguid = "..G.."")
	local veces = Re:GetInt8(0)

	local U = AuthDBQuery("SELECT SUM(promos) FROM _promos WHERE ip = '"..ip.."'")
	local X2 = U:GetInt8(0)
	---------------------------------------------------------------------------------------------------------------------------------------
	local function D()
		-- CUIDADO!!! Este bucle elimina absolutamente todo el equipo del jugador, incluyendo bolsas, usar con cuidado. Cuando veas D()
		for i=0,38 do if p:GetItemByPos(255,i)~=nil then p:RemoveItem( p:GetItemByPos(255,i):GetEntry() ,1)	end end
	end
	local function DD()	-- Este bucle solo elimina los items del equipamiento de personaje.	
		for i=0,18 do if p:GetItemByPos(255,i)~=nil then p:RemoveItem( p:GetItemByPos(255,i):GetEntry() ,1)	end end
	end
	local function Add(a,b,c,d) p:AddItem(a,1) p:AddItem(b,1) p:AddItem(c,1) p:AddItem(d,1) end --> Solo para DKs
	--------------------------------------------------------------------------------------------------------------------------------------
	if veces == 0 then

		if C~=32 then
			if Lev >= 11 then u:SendUnitSay("Debes ser de nivel 10 como máximo.", 0) return end
		else
			if Lev >= 56 then u:SendUnitSay("Debes ser de nivel 55.", 0) return end
		end

		p:SetLevel(Level)
		AuthDBExecute("UPDATE `_promos` SET promos = promos+1 WHERE ip = '"..ip.."' AND charguid = "..G.."")
		local function Timed(ev, del, rep, wp)
			if F == 1 then
				if sex == 1 then SendWorldMessage(Hom) else	SendWorldMessage(Muj) end
			else 
				if sex == 1 then SendWorldMessage(Hom) else SendWorldMessage(Muj) end
			end			
		end
		p:RegisterEvent(Timed, 300, 1)
		local pro = Promos-1

		if X2 == pro then 
			for y=1, #SKI[s] do p:LearnSpell(SKI[s][y]) end p:AdvanceSkillsToMax()
			if C==32 then if Borrar_Items_DK==true then D() Add(39208,40483,38674,38675) else DD() p:AddItem(4500,4) end else D() end 
			for i = 1, #GEAR[s][int] do p:EquipItem( GEAR[s][int][i] , slot[i] ) end
			u:SendUnitSay("¡Promoción registrada! Has agotado las promociones disponibles.", 0)
			for bol=19,22 do p:EquipItem(4500,bol) end												 
		else 
			for y=1, #SKI[s] do p:LearnSpell(SKI[s][y]) end p:AdvanceSkillsToMax()
			if C==32 then if Borrar_Items_DK==true then D() Add(39208,40483,38674,38675) else DD() p:AddItem(4500,4) end else D() end
			for i = 1, #GEAR[s][int] do p:EquipItem( GEAR[s][int][i] , slot[i] ) end
			u:SendUnitSay("¡Promoción registrada!", 0)			
			for bol=19,22 do p:EquipItem(4500,bol) end			
		end		
								
		if C==256 then p:AddItem(6265,5) end
		if C==32 then if Borrar_Items_DK==false then p:AddItem(38632,1) p:RemoveItem(38633,1) end end
		p:AddItem(6948,1)

		if X2 == nil then
			p:SendBroadcastMessage('La información de las promociones no se está '
				..'insertando correctamente en la Base de Datos, eleva este problema a un desarrollador.')	-- O escríbeme a ariel.cami.dos@gmail.com		
		else
			if X2==0 then 	
				local function Timed2(ev, del, rep, wp)
					wp:ModifyMoney( (Oro[1]*10000) )
					wp:SendBroadcastMessage('¡Has recibido |cff62fc03'..Oro[2]..'|r de oro como regalo!')
					wp:SendUnitSay("Mi entrenador me está invocando...",0)								
				end
				p:RegisterEvent(Timed2, 3000, 1)					
			else
				local function Timed3(evv, dell, repp, wpp)
					wpp:SendBroadcastMessage('|cfffc1c1cYa recibiste una colaboración monetaria con otro personaje.')
					wpp:SendUnitSay("Mi entrenador me está invocando...",0)								
				end
				p:RegisterEvent(Timed3, 3000, 1)						
			end
		end

		local function TeL(Ev,DeL,Rep,PJ)
			for t = 1, #tele[F][s] do 
				local map,xx,yy,zz,oo = table.unpack(tele[F][s]) 
				PJ:Teleport(map,xx,yy,zz,oo) 
			end			
		end
		p:RegisterEvent(TeL, 8000, 1)				

		if X2 == pro then aa = '|cffff0000' else aa = '|cff00ddff' end
		p:SendBroadcastMessage("|cffff47f0Promociones recibidas: "..aa..""..X2+1) return
	else		
		u:SendUnitSay("Disculpa "..N..", ya recibiste promoción.",0) return		
	end	
end 
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local function LogIn(e,p) --// Se activa cuando un jugador logea.
	local guid, ip = tonumber( p:GetGUIDLow() ), p:GetPlayerIP() 
	AuthDBExecute("INSERT IGNORE INTO `_promos` (`charguid`, `ip`, `promos`) VALUES ("..guid..", '"..ip.."' , 0)")
	AuthDBExecute("UPDATE `_promos` SET `ip` = '"..ip.."' WHERE `charguid` = "..guid.."") --> Por si cambian el IP
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local function LogOut(e,p)  --// Se activa cuando un jugador desloguea.
	local guid = tonumber( p:GetGUIDLow() )
	AuthDBExecute("DELETE FROM `_promos` WHERE `charguid` = "..guid.." AND promos = 0") 
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local function LuaLoad(e) --// Se activa al iniciar el Worldserver y también cada vez que el LuaEngine se refresca.
	AuthDBExecute("CREATE TABLE IF NOT EXISTS `_promos` (`charguid` INT NOT NULL UNIQUE, `ip` VARCHAR(20) NOT NULL, `promos` TINYINT NOT NULL)")
	--AuthDBExecute("DELETE FROM `_promos`")  --> Activa esta línea para limpiar el registro de promociones al escribir .reload eluna

--[[ 
	El código de abajo hará que las habilidades que enseñan los entrenadores sean gratuitas. 
	Si te interesa esto, activa las 2 líneas de código y cierra y abre el worldserver para que surta efecto.
	***GUARDA UNA COPIA DE SEGURIDAD de la tabla npc_trainer antes de aplicar esto, 
	el trabajo de poner todo por defecto sin tener una copia es bastante. 								]]

--	AuthDBExecute("UPDATE `npc_trainer` SET `MoneyCost` = 0 WHERE `ID` IN (200001,200002,200003,200004,200005,200006"..
--	..",200007,200008,200009,200010,200011,200012,200013,200014,200015,200016,200017,200018,200019,200020,200021)")
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local function LichKing(e,P,U) 		local C,R,L = P:GetClassMask(),P:GetRaceMask(),P:GetLevel()  	if P:IsHorde() then F = 1 else F = 2 end

	if C==32 then
		if L<=55 then	P:RemoveItem(41751,10)			

			local RAZ = {[1]={12742},[2]={12748},[4]={12744},[8]={12743},[16]={12750},[32]={12739},[64]={12745},[128]={12749},[512]={12747},[1024]={12746}}
			local HO1 = {12593,12619,12842,12848,12636,12641,12657,12849,12850,12670,12678,12680,12679,12733,12687,12697,12698,12700,12701,12706,
             			 12714,12716,12715,12719,12722,12720,12723,12724,12725,12727,12738}
			local AL1 = {12593,12619,12842,12848,12636,12641,12657,12849,12850,12670,12678,12680,12679,12733,12687,12697,12698,12700,12701,12706,
             			 12714,12716,12715,12719,12722,12720,12723,12724,12725,12727,12738}
			local HO2 = {12751,12754,12755,12756,12757,12778,12779,12800,12801,13165,13166,13189}
			local AL2 = {12751,12754,12755,12756,12757,12778,12779,12800,12801,13165,13166,13188}

			local function Quests(qq) P:AddQuest(qq) P:CompleteQuest(qq) P:RewardQuest(qq) end

			if F==1 then
				for i=1, #HO1 do Quests( HO1[i] ) end Quests( RAZ[R][1] )
                for i=1, #HO2 do Quests( HO2[i] ) end P:Teleport(1, -617.4874, -4252.6411, 38.8546, 0.1181)
			else 
				for i=1, #AL1 do Quests( AL1[i] ) end Quests( RAZ[R][1] ) 
                for i=1, #AL2 do Quests( AL2[i] ) end P:Teleport(0, -8953.1875, -132.3827, 83.3025, 0.031)
			end
		P:SetLevel(55)
		P:SetCoinage(0)
		else
			U:SendUnitSay('Debes ser de nivel 55.',0) return
		end
	else
		U:SendUnitSay('No eres un Caballero de la Muerte.',0) return
	end		
end
----------------------------------------------------------------------------------------------------------------------------
RegisterCreatureGossipEvent(NPC_ID, 1, Saludo) RegisterCreatureGossipEvent(NPC_ID, 2, MenuClick) RegisterPlayerEvent(3, LogIn)
RegisterPlayerEvent(4, LogOut) RegisterServerEvent(33, LuaLoad) RegisterCreatureGossipEvent(25462, 1, LichKing)