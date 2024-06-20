local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()

if Config.oxtarget then
	coketelein = exports.interact:AddInteraction({
		coords = Config.CokeTeleIn,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'teleout', -- needed for removing interactions
		name = 'teleout', -- optional
		options = {
			 {
				label = "Enter Building",
				action = function()
					-- Fade out the screen
					DoScreenFadeOut(500)
					-- Wait for the fade out to complete
					Wait(1000)
					
					-- Teleport the player to the specified coordinates
					local playerPed = PlayerPedId()
					local teleportCoords = Config.CokeTeleOut
				
					-- Ensure that the coordinates are valid
					if teleportCoords then
						-- Set the player's ped to not be in any vehicle
						if IsPedInAnyVehicle(playerPed, false) then
							TaskLeaveVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), 16)
							Wait(500)
						end
				
						-- Freeze the player to avoid falling animation
						FreezeEntityPosition(playerPed, true)
						SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z + 1.0) -- Adjust Z-coordinate slightly
						Wait(1000) -- Give it some time for teleportation to complete
				
						-- Unfreeze the player
						FreezeEntityPosition(playerPed, false)
				
						-- Reset the player's state to avoid the falling over animation
						ClearPedTasksImmediately(playerPed)
					else
						print("Teleport coordinates are not set in the configuration.")
					end
				
					-- Wait for a moment before fading back in
					Wait(1000)
					
					-- Fade the screen back in
					DoScreenFadeIn(500)
				end,
				
				canInteract = function ()
					local item = QBCore.Functions.HasItem('cocaine_lab_key')
					return item
				end
			},
		}
	})
	coketeleout = exports.interact:AddInteraction({
		coords = Config.CokeTeleOut,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'teleout', -- needed for removing interactions
		name = 'teleout', -- optional
		options = {
			 {
				label = "Exit Building",
				action = function()
					-- Fade out the screen
					DoScreenFadeOut(500)
					-- Wait for the fade out to complete
					Wait(500)
					
					-- Teleport the player to the specified coordinates
					local playerPed = PlayerPedId()
					local teleportCoords = Config.CokeTeleIn
				
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
				
				canInteract = function ()
					local item = QBCore.Functions.HasItem('cocaine_lab_key')
					return item
				end
			},
		}
	})
else
	exports['qb-target']:AddBoxZone("coketelein",Config.CokeTeleIn,1.5, 1.75, { name = "coketelein",heading = 156.0,debugPoly = false,minZ = Config.CokeTeleIn.z-2,maxZ = Config.CokeTeleIn.z+2,}, {
		options = {
			{
				name = 'teleout',
				icon = "fas fa-sign-in-alt",
				label = "Enter Building",
				action = function()
					 DoScreenFadeOut(500)
					Wait(500)
					SetEntityCoords(PlayerPedId(),Config.CokeTeleOut)
					 Wait(500)
					 DoScreenFadeIn(500)
				end,
	
			},
		},
	})
	exports['qb-target']:AddBoxZone("CokeTeleOut",Config.CokeTeleOut,1.5, 1.75, {name = "CokeTeleOut",heading = 156.0,debugPoly = false,minZ = Config.CokeTeleOut.z-2,maxZ = Config.CokeTeleOut.z+2,}, {
		options = {
				{
					name = 'teleout',
					icon = "fas fa-sign-in-alt",
					label = "Exit Building",
					action = function()
						DoScreenFadeOut(500)
						Wait(500)
						SetEntityCoords(PlayerPedId(),Config.CokeTeleIn)
						Wait(500)
							DoScreenFadeIn(500)
					end,
	
				},
			},
		})
end	
	-- cocaine ( Bagging and Cutting is in Cocaine.lua due to globals used :))
	for k, v in pairs (Config.MakePowder) do 
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		 local options = {
			{	type = "client",	event = "md-drugs:client:makepowder",	icon = "fas fa-sign-in-alt",	label = "chop it up", data = k,  distance = 2.0,
				canInteract = function()
					local item = QBCore.Functions.HasItem('coca_leaf')
					return item
				end
			},
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 3.0, -- optional
				id = 'makepowder', -- needed for removing interactions
				name = "makepowder"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makepowder"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makepowder"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
		end
	end
	------------- lsd
	for k, v in pairs (Config.lysergicacid) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:getlysergic",	icon = "fas fa-sign-in-alt",	label = "stealing", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'getlysergic', -- needed for removing interactions
				name = "getlysergic"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false, rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("getlysergic"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="getlysergic"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.diethylamide) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:getdiethylamide",	icon = "fas fa-sign-in-alt",	label = "stealing", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'getdiethylamide', -- needed for removing interactions
				name = "getdiethylamide"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("getdiethylamide"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="getdiethylamide"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.gettabs) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:buytabs",	icon = "fas fa-sign-in-alt",	label = "Buy Tabs", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'buytabs', -- needed for removing interactions
				name = "buytabs"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("buytabs"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="buytabs"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------ heroin
	for k, v in pairs (Config.dryplant) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:dryplant",	icon = "fas fa-sign-in-alt",	label = "Dry Poppies", data = k,
				canInteract = function ()
					local item = QBCore.Functions.HasItem('poppyresin')
					return item
				end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'dryplant', -- needed for removing interactions
				name = "dryplant"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("dryplant"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="dryplant"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.cutheroinone) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:cutheroin",	icon = "fas fa-sign-in-alt",	label = "Cut Heroin", data = k,
				canInteract = function()
					local item1 = QBCore.Functions.HasItem('bakingsoda')
					local item2 = QBCore.Functions.HasItem('heroin')
					local item3 = QBCore.Functions.HasItem('heroinstagetwo')
					local item4 = QBCore.Functions.HasItem('heroinstagethree')

					if item1 and (item2 or item3 or item4) then
						return true
					else
						return false
					end
				end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'cutheroin', -- needed for removing interactions
				name = "cutheroin"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("cutheroin"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="cutheroin"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.fillneedle) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:fillneedle",	icon = "fas fa-sign-in-alt",	label = "Fill Needles", data = k,
				canInteract = function()
					local item1 = QBCore.Functions.HasItem('needle')
					local item2 = QBCore.Functions.HasItem('heroinvial')
					local item3 = QBCore.Functions.HasItem('heroinvialstagetwo')
					local item4 = QBCore.Functions.HasItem('heroinvialstagethree')

					if item1 and (item2 or item3 or item4) then
						return true
					else
						return false
					end
				end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'fillneedle', -- needed for removing interactions
				name = "fillneedle"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("fillneedle"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="fillneedle"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------- crack
	for k, v in pairs (Config.makecrack) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:makecrackone",	icon = "fas fa-sign-in-alt",	label = "Cook Crack", data = k, distance = 2.0,
				canInteract = function()
					local item1 = QBCore.Functions.HasItem('bakingsoda')
					local item2 = QBCore.Functions.HasItem('loosecoke')
					local item3 = QBCore.Functions.HasItem('loosecoketwo')
					local item4 = QBCore.Functions.HasItem('loosecokethree')

					if item1 and (item2 or item3 or item4) then
						return true
					else
						return false
					end
				end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'makecrackone', -- needed for removing interactions
				name = "makecrackone"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makecrackone"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makecrackone"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.bagcrack) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:bagcrack",	icon = "fas fa-sign-in-alt",	label = "Bag Crack", data = k, distance = 2.0,
				canInteract = function()
					local item1 = QBCore.Functions.HasItem('empty_weed_bag')
					local item2 = QBCore.Functions.HasItem('crackrock')
					local item3 = QBCore.Functions.HasItem('crackrocktwo')
					local item4 = QBCore.Functions.HasItem('crackrockthree')
				
					if item1 and (item2 or item3 or item4) then
						return true
					else
						return false
					end
				end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'bagcrack', -- needed for removing interactions
				name = "bagcrack"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("bagcrack"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="bagcrack"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------- pharma
	for k, v in pairs (Config.FillPrescription) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:fillprescription",	icon = "fas fa-sign-in-alt",	label = "Fill Prescription", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = 'fillprescription', -- needed for removing interactions
				name = "fillprescription"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("fillprescription"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="fillprescription"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	-------- oxy runs
	local options2 = {
		{	event = "md-drugs:client:getoxytruck",	icon = "fas fa-sign-in-alt",	label = "Pay For Truck",},
	}
	if Config.oxtarget then
		exports.interact:AddInteraction({
			coords = Config.Payfortruck,
			distance = 3.0, -- optional
			interactDst = 1.0, -- optional
			id = "payfortruck", -- needed for removing interactions
			name = "payfortruck", -- optional
			options = options2
		})
		--exports.ox_target:addBoxZone({coords = Config.Payfortruck, size = vec3(1,1,1),debugPoly = false,rotation = 90.0, options = options2,})
	else
		exports['qb-target']:AddBoxZone("payfortruck" ,Config.Payfortruck, 1.0, 1.0, {name ="payfortruck", heading = 156.0,minZ = Config.Payfortruck.z-2, maxZ = Config.Payfortruck.z+2, }, {options = options2, distance = 1.5})	
	end
	------------ mescaline
	local options3 = {
		{	type = "client",	event = "md-drugs:client:drymescaline",	icon = "fas fa-sign-in-alt",	label = "Dry Out"},
	}
	if Config.oxtarget then
		exports.interact:AddInteraction({
			coords = Config.DryOut,
			distance = 3.0, -- optional
			interactDst = 1.0, -- optional
			id = "DryOut", -- needed for removing interactions
			name = "DryOut", -- optional
			options = options3
		})
		--exports.ox_target:addBoxZone({coords = Config.DryOut, size = vec3(1,1,1),debugPoly = false,rotation = 90.0, options = options3,})
	else
		exports['qb-target']:AddBoxZone("DryOut" ,Config.DryOut, 1.0, 1.0, {name ="DryOut", heading = 156.0,minZ = Config.DryOut.z-2, maxZ = Config.DryOut.z+2, }, {options = options3, distance = 1.5})	
	end
	------ XTC
	for k, v in pairs (Config.isosafrole) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:stealisosafrole",	icon = "fas fa-sign-in-alt",	label = "Steal Isosafrole", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "stealisosafrole", -- needed for removing interactions
				name = "stealisosafrole"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stealisosafrole"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stealisosafrole"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.mdp2p) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:stealmdp2p",	icon = "fas fa-sign-in-alt",	label = "Steal MDP2P", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "stealmdp2p", -- needed for removing interactions
				name = "stealmdp2p"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stealmdp2p"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stealmdp2p"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end

	for k, v in pairs (Config.rawxtcloc) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:makingrawxtc",	icon = "fas fa-sign-in-alt",	label = "Make Raw XTC", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "makingrawxtc", -- needed for removing interactions
				name = "makingrawxtc"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makingrawxtc"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makingrawxtc"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	local options4 = {
		{	type = "client",	event = "md-drugs:client:buypress",	icon = 'fas fa-eye',	label = 'Buy Press',},
	}
	if Config.oxtarget then
		exports.interact:AddInteraction({
			coords = Config.buypress,
			distance = 3.0, -- optional
			interactDst = 1.0, -- optional
			id = "buypress", -- needed for removing interactions
			name = "buypress", -- optional
			options = options4
		})
		exports.ox_target:addBoxZone({ coords = Config.buypress, size = vec3(2,2,2), debugPoly = false, rotation = 45, options = options4})
	else
		exports['qb-target']:AddBoxZone("buypress" ,Config.buypress, 1.0, 1.0, {name ="buypress", heading = 156.0,minZ = Config.buypress.z-2, maxZ = Config.buypress.z+2, }, {options = options4, distance = 1.5})	
	end
	for k, v in pairs(Config.stamp) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{type = "client",   event = "md-drugs:client:stampwhite",   icon = 'fas fa-eye',    label = 'Stamp Pills',	data = k, canInteract = function() if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end },
			
		}
	
		if Config.oxtarget then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 3.0, -- optional
				interactDst = 1.0, -- optional
				id = "stampxtc", -- needed for removing interactions
				name = "stampxtc"..k, -- optional
				options = options
			})
			--exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stampxtc"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stampxtc"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end	

end)
