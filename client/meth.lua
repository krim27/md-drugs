local QBCore = exports['qb-core']:GetCoreObject()
local amonia = nil
local tray = nil
local heated = nil
local active = nil

local function startcook()
	if amonia == nil then
		active = true
		TriggerServerEvent("wrp-drugs:server:startcook")
		MethCooking()
		amonia = true
	else
		Notify(Lang.meth.inside, "error")
	end
end

local function dials()
	if amonia == true then
		if not minigame(2, 8) then
			AddExplosion(1005.773, -3200.402, -38.524, 49, 10, true, false, true, true)
			ClearPedTasks(PlayerPedId())
			amonia = nil
			active = nil
		return end
		Notify(Lang.meth.increaseheat, "success")
		ClearPedTasks(PlayerPedId())
		heated = true	
	else
	end
end

local function smash()
if tray then
	tray = false
	DeleteObject(trays)
	local bucket = CreateObject(`bkr_prop_meth_bigbag_03a`, vector3(1012.85, -3194.29, -39.2), false, false, false)
	SetEntityHeading(bucket, 90.0)
	SmashMeth()

	local options = {
		{
			name = 'bucket',
			icon = 'fa-solid fa-car',
			label = 'Bag Meth',
			action = function()
				DeleteObject(bucket)
				amonia = nil
				heated = nil
				tray = nil
				active = nil
				BagMeth()
				TriggerServerEvent('wrp-drugs:server:getmeth')
				
			end,
			canInteract = function()
				local item = QBCore.Functions.HasItem('empty_meth_bag')
				if item then return true end
			end,

		}
	}
	local optionsox = {
		{
			name = 'bucket',
			icon = 'fa-solid fa-car',
			label = 'Bag Meth',
			onSelect = function()
				DeleteObject(bucket)
				amonia = nil
				heated = nil
				tray = nil
				active = nil
				BagMeth()
				TriggerServerEvent('wrp-drugs:server:getmeth')
				
			end,
			canInteract = function()
				local item = QBCore.Functions.HasItem('empty_meth_bag')
				if item then return true end
			end,

		}
	}
	if Config.oxtarget then
        exports.ox_target:addLocalEntity(bucket,  optionsox)
    else 
	    exports['qb-target']:AddTargetEntity(bucket, {options = options, distance = 2.0})
    end   
end	
end

local function trayscarry()
	if amonia then
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('anim@heists@box_carry@')
		while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
			Wait(7)
		end
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false,
			false)
		RequestModel("bkr_prop_meth_tray_02a")
		while not HasModelLoaded("bkr_prop_meth_tray_02a") do
			Wait(0)
		end
		 trays = CreateObject("bkr_prop_meth_tray_02a", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(trays, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.01, -0.2,
			-0.2, 20.0, 0.0, 0.0, true, true, false, true, 1, true)
		tray = true
	end
end
CreateThread(function()
	BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()
	BikerMethLab.Style.Set(BikerMethLab.Style.upgrade)
	BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
	BikerMethLab.Details.Enable(BikerMethLab.Details.production, true)
	RefreshInterior(BikerMethLab.interiorId)
end)

CreateThread(function()
	exports.interact:AddInteraction({
		coords = Config.MethTeleIn,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'methteleout', -- needed for removing interactions
		name = 'methteleout', -- optional
		options = {
			 {
				label = 'Enter Building',
				action = function()
					-- Fade out the screen
					DoScreenFadeOut(500)
					-- Wait for the fade out to complete
					Wait(500)
					
					-- Teleport the player to the specified coordinates
					local playerPed = PlayerPedId()
					local teleportCoords = Config.MethTeleOut
				
					-- Ensure that the coordinates are valid
					if teleportCoords then
						-- Set the player's ped to not be in any vehicle
						if IsPedInAnyVehicle(playerPed, false) then
							TaskLeaveVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 16)
							Wait(500)
						end
				
						-- Freeze the player to avoid falling animation
						FreezeEntityPosition(playerPed, true)
						SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z) -- Adjust Z-coordinate slightly
						Wait(1000) -- Give it some time for teleportation to complete
				
						-- Unfreeze the player
						FreezeEntityPosition(playerPed, false)
				
						-- Reset the player's state to avoid the falling over animation
						ClearPedTasksImmediately(playerPed)
					else
						print("Teleport coordinates are not set in the configuration.")
					end
				
					-- Wait for a moment before fading back in
					Wait(500)
					
					-- Fade the screen back in
					DoScreenFadeIn(500)
				end,
				canInteract = function()
					local item = QBCore.Functions.HasItem('meth_access')
					return item
				end,
			},
		}
	})
	exports.interact:AddInteraction({
		coords = Config.MethTeleOut,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'methtelein', -- needed for removing interactions
		name = 'methtelein', -- optional
		options = {
			 {
				label = 'Exit Building',
				action = function()
					-- Fade out the screen
					DoScreenFadeOut(500)
					-- Wait for the fade out to complete
					Wait(500)
					
					-- Teleport the player to the specified coordinates
					local playerPed = PlayerPedId()
					local teleportCoords = Config.MethTeleIn
				
					-- Ensure that the coordinates are valid
					if teleportCoords then
						-- Set the player's ped to not be in any vehicle
						if IsPedInAnyVehicle(playerPed, false) then
							TaskLeaveVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 16)
							Wait(500)
						end
				
						-- Freeze the player to avoid falling animation
						FreezeEntityPosition(playerPed, true)
						SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z) -- Adjust Z-coordinate slightly
						Wait(1000) -- Give it some time for teleportation to complete
				
						-- Unfreeze the player
						FreezeEntityPosition(playerPed, false)
				
						-- Reset the player's state to avoid the falling over animation
						ClearPedTasksImmediately(playerPed)
					else
						print("Teleport coordinates are not set in the configuration.")
					end
				
					-- Wait for a moment before fading back in
					Wait(500)
					
					-- Fade the screen back in
					DoScreenFadeIn(500)
				end,
				canInteract = function()
					local item = QBCore.Functions.HasItem('meth_access')
					return item
				end,
			},
		}
	})
	exports['qb-target']:AddBoxZone("maze", vector3(-95.55, -806.73, 44.04), 1.5, 1.75, { name = "maze", heading = 11.0, debugPoly = false, minZ = 44 - 2, maxZ = 44 + 2, }, {
		options = {
			{	name = 'die',	icon = "fas fa-sign-in-alt",	label = "dont click this",	action = function()		SetEntityCoords(PlayerPedId(), vector3(-75.36, -837.24, 318.93))	end},
		},
		distance = 2.5
	})
	local itemreqcook = { "ephedrine", "acetone" }
	exports.interact:AddInteraction({
		coords = vector3(1005.7, -3201.28, -38.55),
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'ingridientsmeth', -- needed for removing interactions
		name = 'ingridientsmeth', -- optional
		options = {
			{
				label = 'Cook Meth',
				item = itemreqcook,
				action = function() 	
					startcook()
				end,
				canInteract = function()
					if amonia == nil and active == nil then
						return true
					end
			  	end,
			},
			{ 
				label = "Grab Tray",  
				action = function() 	
					trayscarry() 
				end,
			  	canInteract = function()
					if heated and amonia and tray == nil then return true end
			  	end,
			},
		}
	})
	exports.interact:AddInteraction({
		coords = vector3(1012.15, -3194.04, -39.20),
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'boxmeth', -- needed for removing interactions
		name = 'boxmeth', -- optional
		options = {
			 {
				label = 'Box Up Meth',
				action = function() 	
					smash()
				end,
				canInteract = function()
					if tray then return true end
				end,
			},
		}
	})
	exports.interact:AddInteraction({
		coords = vector3(1007.89, -3201.17, -38.99),
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'adjustdials', -- needed for removing interactions
		name = 'adjustdials', -- optional
		options = {
			 {
				label = 'Adjust Dials',
				action = function() 	
					dials()
				end,
				canInteract = function()
					if amonia and heated == nil then return true end
				end,
			},
		}
	})

	if Config.MethHeist == false then
		for k, v in pairs (Config.MethEph) do 
			if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "methep"..k, -- needed for removing interactions
				name = 'methep', -- optional
				options = {
					 {
						label = 'Steal Ephedrine',
						event = 'wrp-drugs:client:stealeph',
						data = k,
						canInteract = function()
							if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
					},
				}
			})
		end
		for k, v in pairs (Config.Methace) do 
			if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "methace"..k, -- needed for removing interactions
				name = 'methace', -- optional
				options = {
					 {
						label = 'Steal Acetone',
						event = 'wrp-drugs:client:stealace',
						data = k,
						canInteract = function()
							if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
					},
				}
			})
		end
	end
end)

CreateThread(function()
if Config.MethHeist == false then
else
	local current = "g_m_y_famdnf_01"
	lib.requestModel(current, Config.RequestModelTime)
	local CurrentLocation = Config.MethHeistStart
	local methdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, false, false)
	FreezeEntityPosition(methdealer, true)
	SetEntityHeading(methdealer, 220.0)
	SetEntityInvincible(methdealer, true)
	exports['qb-target']:AddTargetEntity(methdealer, {
		options = {
			{
				label = "Get Mission",
				icon = "fas fa-eye",
				action = function()
					Notify(Lang.meth.mission, "success")
					SpawnMethCarPedChase()
				end,
			},
		}
	})
end
end)
RegisterNetEvent("wrp-drugs:client:stealeph", function(data)
	if not progressbar('Stealing Ephedrine', 4000, 'uncuff') then return end
	TriggerServerEvent("wrp-drugs:server:geteph", data.data)
end)

RegisterNetEvent("wrp-drugs:client:stealace", function(data)
	if not progressbar('Stealing Acetone', 4000, 'uncuff') then return end
	TriggerServerEvent("wrp-drugs:server:getace", data.data)
end)


