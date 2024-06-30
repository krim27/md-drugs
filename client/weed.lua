local QBCore = exports['qb-core']:GetCoreObject()
local WeedPlant = {}
local exploded = nil
local dryingSpots = {} -- Table to track drying states for each spot
local tableout = false
function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 

RegisterNetEvent('weed:respawnCane', function(loc)
    local v = GlobalState.WeedPlant[loc]
    local hash = GetHashKey(v.model)
    if not HasModelLoaded(hash) then LoadModel(hash) end
    if not WeedPlant[loc] then
        WeedPlant[loc] = CreateObject(hash, v.location.x, v.location.y, v.location.z-3.5, true, true, true)
        SetEntityAsMissionEntity(WeedPlant[loc], true, true)
        FreezeEntityPosition(WeedPlant[loc], true)
        SetEntityHeading(WeedPlant[loc], v.heading)
		local options = {
			{
				label = "Pick Weed",
				icon = 'fa-solid fa-leaf',
				onSelect = function()
				   if not progressbar(Lang.Weed.pick, 4000, 'uncuff') then return end
					TriggerServerEvent("weed:pickupCane", loc)
				end,
				canInteract = function ()
                    local item = QBCore.Functions.HasItem('scissors')
                    return item
                end
			}
		}
		exports.ox_target:addLocalEntity(WeedPlant[loc], options)
    end
end)

RegisterNetEvent('weed:removeCane', function(loc)
    if DoesEntityExist(WeedPlant[loc]) then DeleteEntity(WeedPlant[loc]) end
    WeedPlant[loc] = nil
end)

RegisterNetEvent("weed:init", function()
    for k, v in pairs (GlobalState.WeedPlant) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            WeedPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z-3.5, true, true, true)
            SetEntityAsMissionEntity(WeedPlant[k], true, true)
            FreezeEntityPosition(WeedPlant[k], true)
            SetEntityHeading(WeedPlant[k], v.heading)
			local options = {
				{
					label = "Pick Weed",
					icon = 'fa-solid fa-leaf',
					onSelect = function()
					   if not progressbar(Lang.Weed.pick, 4000, 'uncuff') then return end
						TriggerServerEvent("weed:pickupCane", k)
					end,
					canInteract = function ()
						local item = QBCore.Functions.HasItem('scissors')
						return item
					end
				}
			}
			exports.ox_target:addLocalEntity(WeedPlant[k], options)
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('bkr_prop_weed_lrg_01b')
        TriggerEvent('weed:init')
    end
 end)
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('bkr_prop_weed_lrg_01b')
     TriggerEvent('weed:init')
 end)
 
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('bkr_prop_weed_lrg_01b'))
        for k, v in pairs(WeedPlant) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

CreateThread(function()
	for k, v in pairs(Config.WeedDry) do
		dryingSpots[k] = false -- Initialize drying state for each spot
	
		exports.interact:AddInteraction({
			coords = v,
			distance = 3.0, -- optional
			interactDst = 1.0, -- optional
			id = 'weeddry' .. k, -- needed for removing interactions
			name = "weeddry" .. k, -- optional
			options = {
				{
					name = 'dryweed',
					icon = "fas fa-sign-in-alt",
					label = "Dry Weed",
					distance = 1,
					items = "wetcannabis",
					action = function()
						local hasItem = QBCore.Functions.HasItem('wetcannabis')
						if dryingSpots[k] then
							Notify(Lang.Weed.busy, "error")
						elseif not hasItem then
							Notify("You do not have wet cannabis to dry", "error")
						else
							local loc = vector3(v.x, v.y, v.z)
							local weedplant = CreateObject("bkr_prop_weed_drying_01a", loc.x, loc.y + 0.2, loc.z, true, true, true)
							dryingSpots[k] = true
							FreezeEntityPosition(weedplant, true)
							Notify("Wait a little bit to dry at spot " .. k, "success")
							TriggerServerEvent('wrp-drugs:server:putoutweed')
							
							Citizen.SetTimeout(math.random(30000, 120000), function()
								Notify("Take down the weed from spot " .. k, "success")
								local options = {
									{
										icon = "fas fa-sign-in-alt",
										label = "Pick Up Weed",
										action = function()
											DeleteEntity(weedplant)
											TriggerServerEvent('wrp-drugs:server:dryoutweed')
											dryingSpots[k] = false
										end,
										canInteract = function()
											if Config.Joblock then
												return QBCore.Functions.GetPlayerData().job.name == Config.weedjob
											else
												return true
											end
										end,
									}
								}
	
								local optionsox = {
									{
										icon = "fas fa-sign-in-alt",
										label = "Pick Up Weed",
										onSelect = function()
											DeleteEntity(weedplant)
											TriggerServerEvent('wrp-drugs:server:dryoutweed')
											dryingSpots[k] = false
										end,
										canInteract = function()
											if Config.Joblock then
												return QBCore.Functions.GetPlayerData().job.name == Config.weedjob
											else
												return true
											end
										end,
									}
								}
	
								if Config.oxtarget then
									exports.ox_target:addLocalEntity(weedplant, optionsox)
								else
									exports['qb-target']:AddTargetEntity(weedplant, { options = options })
								end
							end)
						end
					end,
					canInteract = function()
						if Config.Joblock then
							if QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
								return not dryingSpots[k]
							end
						else
							return not dryingSpots[k]
						end
						return false
					end,
				},
			},
		})    
	end
	


	exports.interact:AddInteraction({
	    coords = Config.Telein,
	    distance = 3.0, -- optional
	    interactDst = 1.0, -- optional
	    id = 'teleinweed', -- needed for removing interactions
	    name = 'teleinweed', -- optional
	    options = {
	         {
	            label = "Enter Building",
				action = function()
					-- Fade out the screen
					DoScreenFadeOut(500)
					-- Wait for the fade out to complete
					Wait(500)
					
					-- Teleport the player to the specified coordinates
					local playerPed = PlayerPedId()
					local teleportCoords = Config.Teleout
				
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
					local item = QBCore.Functions.HasItem('weed_access')
					return item
				end,
	        },
	    }
	})
	exports.interact:AddInteraction({
	    coords = Config.Teleout,
	    distance = 3.0, -- optional
	    interactDst = 1.0, -- optional
	    id = 'teleinweedout', -- needed for removing interactions
	    name = 'teleinweedout', -- optional
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
					local teleportCoords = Config.Telein
				
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
					local item = QBCore.Functions.HasItem('weed_access')
					return item
				end,
	        },
	    }
	})
	-- Register the context menu
	lib.registerContext({
		id = 'drug_menu',
		title = 'Edibles',
		options = {
		  	{
				title = 'Make Butter',
				description = 'Requires: mdbutter, grindedweed',
				onSelect = function()
					if not (ItemCheck('mdbutter') and ItemCheck('grindedweed')) then return end
					if not minigame(2, 8) then return end
					if not progressbar(Lang.Weed.canna, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makebutter")
				end,
		  	},
		  	{
				title = 'Make Brownies',
				description = 'Requires: cannabutter, flour, chocolate',
				onSelect = function()
					if not (ItemCheck('cannabutter') and ItemCheck('flour') and ItemCheck('chocolate')) then return end
					if not minigame(2, 8) then return end
					if not progressbar(Lang.Weed.brown, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makebrownies")
				end,
		  	},
		 	{
				title = 'Make Cookies',
				description = 'Requires: cannabutter, flour',
				onSelect = function()
					if not (ItemCheck('cannabutter') and ItemCheck('flour')) then return end
					if not minigame(2, 8) then return end
					if not progressbar(Lang.Weed.cook, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makecookies")
				end,
		  	},
		  	{
				title = 'Make Chocolate',
				description = 'Requires: cannabutter, chocolate',
				onSelect = function()
					if not (ItemCheck('cannabutter') and ItemCheck('chocolate')) then return end
					if not minigame(2, 8) then return end
					if not progressbar(Lang.Weed.choc, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makechocolate")
				end,
		  	},
		  	{
				title = 'Make Muffin',
				description = 'Requires: cannabutter, flour',
				onSelect = function()
					if not (ItemCheck('cannabutter') and ItemCheck('flour')) then return end
					if not minigame(2, 8) then return end
					if not progressbar(Lang.Weed.muff, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makemuffin")
				end,
		  	},
		}
  	})
  
  -- Add interaction to show the context menu
  	exports.interact:AddInteraction({
		coords = Config.MakeButter,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'MakeButter', -- needed for removing interactions
		name = 'MakeButter', -- optional
		options = {
		  	{
				label = "Cook Edibles",
				action = function()
				  lib.showContext('drug_menu')
				end,
		  	},
		}
  	})
  
	  
	  
	-- Register the context menu for making oil
	lib.registerContext({
		id = 'oil_menu',
		title = 'Cook Dab',
		options = {
		  	{
				title = 'Make Dab Oil',
				description = 'Requires: butane, grindedweed',
				onSelect = function()
					if not (ItemCheck('butane') and ItemCheck('grindedweed')) then return end
					if not minigame(2, 8) then
					  local explosion = math.random(1, 100)
					  local loc = GetEntityCoords(PlayerPedId())
					  if explosion <= 99 then
						AddExplosion(loc.x, loc.y, loc.z, 49, 10, true, false, true, true)
						exploded = true
						QBCore.Functions.Notify(Lang.Weed.stovehot, "error")
						Wait(1000 * 30)
						exploded = nil
					  end
					  return
					end
					if not progressbar(Lang.Weed.shat, 4000, 'uncuff') then return end
					TriggerServerEvent("wrp-drugs:server:makeoil")
				end,
				canInteract = function()
				  if exploded == nil then return true end
				end,
		  	},
		}
  	})
  
  -- Add interaction to show the context menu
  	exports.interact:AddInteraction({
		coords = Config.MakeOil,
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		id = 'makeoil', -- needed for removing interactions
		name = 'makeoil', -- optional
		options = {
		  	{
				label = "Cook Dab",
				action = function()
				  lib.showContext('oil_menu')
				end,
		  	},
		}
  	})
  

end)

RegisterNetEvent("wrp-drugs:client:getWeedTableBack", function(data) 
    if not progressbar(Lang.lsd.tablepack, 4000, 'uncuff') then return end
	DeleteObject(data.data)
	TriggerServerEvent('wrp-drugs:server:getWeedTableBack')
    tableout = false
end)

RegisterNetEvent("wrp-drugs:client:resetweedkit", function(data) 
	DeleteObject(data)
	TriggerEvent("wrp-drugs:client:setWeedTable")
end)
local isBaggingWeedActive = false
RegisterNetEvent("wrp-drugs:client:bagweed", function(data)
    -- Check if the progress bar is already active
    if isBaggingWeedActive then 
		lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'empty_crack_bag'
    if not ItemCheck('empty_weed_bag') then 
        return 
    end

    -- Set the progress bar status to active
    isBaggingWeedActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Weed.bagweed, 4000, 'uncuff') then 
        isBaggingWeedActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process bagging crack
    TriggerServerEvent("wrp-drugs:server:bagweed", data.data)

    -- Reset the progress bar status after completion
    isBaggingWeedActive = false
end)

local previewObject = nil
local rotation = 0.0

-- Register the event for setting the weed table
RegisterNetEvent("wrp-drugs:client:setWeedTable")
AddEventHandler("wrp-drugs:client:setWeedTable", function()
    if tableout then 
        Notify("Table is already out", 'error')
        TriggerServerEvent('wrp-drugs:server:getWeedTableBack')
        return
    end

    tableout = true

    -- Start the placement process
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            -- Perform raycast from camera to get hit coordinates
            local hit, hitCoords = RaycastFromCamera(10.0) -- Adjust distance as needed

            -- Update or create the preview object based on raycast
            if hit then
                if not previewObject then
                    previewObject = CreatePreviewObject("bkr_prop_weed_table_01a", hitCoords)
                else
                    SetEntityCoords(previewObject, hitCoords.x, hitCoords.y, hitCoords.z, false, false, false, true)
                    SetEntityHeading(previewObject, rotation)
                    PlaceObjectOnGroundProperly(previewObject)
                end
            end

            -- Rotate the object with the scroll wheel
            if IsControlJustPressed(0, 241) then -- Scroll wheel up
                rotation = rotation + 5.0
                if rotation >= 360.0 then rotation = 0.0 end
                if previewObject then
                    SetEntityHeading(previewObject, rotation)
                end
            elseif IsControlJustPressed(0, 242) then -- Scroll wheel down
                rotation = rotation - 5.0
                if rotation < 0.0 then rotation = 355.0 end
                if previewObject then
                    SetEntityHeading(previewObject, rotation)
                end
            end

            -- Check for key press (E) to place the object
            if IsControlJustReleased(0, 38) then -- E key
                if hit then
                    -- Place the actual weed table object
                    local weedTable = CreateObject("bkr_prop_weed_table_01a", hitCoords.x, hitCoords.y, hitCoords.z, true, true, true)
                    SetEntityHeading(weedTable, rotation)
                    PlaceObjectOnGroundProperly(weedTable)

                    -- Set interaction options
                    local options = {
                        {
                            event = "wrp-drugs:client:getWeedTableBack",
                            icon = "fa-solid fa-hand",
                            label = "Pick Up",
                            data = weedTable,
                            canInteract = function()
                                return not tableout
                            end
                        },
						{
                            event = "wrp-drugs:client:bagweed",
                            icon = "fa-solid fa-hand",
                            label = "Bag cannabis",
                        }
                    }

                    -- Add interaction options to the target system
                    if Config.oxtarget then
                        exports.ox_target:addLocalEntity(weedTable, options)
                    else
                        exports['qb-target']:AddTargetEntity(weedTable, { options = options })
                    end

                    -- Delete the preview object
                    DeleteObject(previewObject)
                    previewObject = nil

                    -- Exit the placement loop
                    break
                else
                    -- Notify the player if no valid surface was detected
                    Notify("No valid surface detected!", 'error')
                end
            end

            -- Check for key press (X) to cancel placement
            if IsControlJustReleased(0, 73) then -- X key
                if previewObject then
                    DeleteObject(previewObject)
                    previewObject = nil
                    TriggerServerEvent('wrp-drugs:server:getWeedTableBack')
                end
                break
            end
        end

        tableout = false
    end)
end)


CreateThread(function()
    BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()
    BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
    BikerWeedFarm.Security.Set(BikerWeedFarm.Security.upgrade)
    BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, true)
    BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.chairs, BikerWeedFarm.Details.drying}, true)
	BikerWeedFarm.Plant1.Clear(false)
    BikerWeedFarm.Plant2.Clear(false)
    BikerWeedFarm.Plant3.Clear(false)
    BikerWeedFarm.Plant4.Clear(false)
    BikerWeedFarm.Plant5.Clear(false)
    BikerWeedFarm.Plant6.Clear(false)
    BikerWeedFarm.Plant7.Clear(false)
    BikerWeedFarm.Plant8.Clear(false)
    BikerWeedFarm.Plant9.Clear(false)
    RefreshInterior(BikerWeedFarm.interiorId)
	stove = CreateObject("prop_cooker_03",vector3(1045.49, -3198.46, -38.15-1), true, false)
	SetEntityHeading(stove, 270.00)
	FreezeEntityPosition(stove, true)
	stove2 = CreateObject("prop_cooker_03",vector3(1038.90, -3198.66, -38.17-1), true, false)
	SetEntityHeading(stove2, 90.00)
	FreezeEntityPosition(stove2, true)
end)

RegisterNetEvent('wrp-drugs:client:bluntwraps', function(args)
  lib.registerContext({
    id = 'bluntroll',
    title = 'Blunt Types',
    menu = 'bluntroll',
    options = {
    	{ title = 'Roll Blunt',  description = 'Roll A Regular Blunt',  icon = 'check',  serverEvent = 'wrp-drugs:server:rollblunt'},
		{ title = 'Dip Blunt Wrap In Lean', description = 'Roll A Lean Blunt', icon = 'check', serverEvent = 'wrp-drugs:server:rollleanblunt'},
		{ title = 'Dip Blunt Wrap In Dextro',  description = 'Roll A Dextro Blunt',  icon = 'check',  serverEvent = 'wrp-drugs:server:rolldextroblunt'},
		{ title = 'Roll A Chewy Blunt',  description = 'Roll A Chewy Blunt',  icon = 'check',  serverEvent = 'wrp-drugs:server:rollchewyblunt'},
  	},
  })
  lib.showContext('bluntroll')
end)

RegisterNetEvent("wrp-drugs:client:rollanim", function()
if not progressbar(Lang.Weed.roll, 4000, 'uncuff') then return end
end)
RegisterNetEvent("wrp-drugs:client:grind", function()
	if not progressbar("grinding", 4000, 'uncuff') then return end
end)
	


RegisterNetEvent("wrp-drugs:client:dodabs", function()
TriggerEvent('animations:client:EmoteCommandStart', {'bong2'}) 
AlienEffect()
end)

CreateThread(function()
	local WeedShop = {}
	local current = "u_m_m_jesus_01"

	lib.requestModel(current, Config.RequestModelTime)
	local CurrentLocation = vector3(1030.46, -3203.63, -38.2)
	local WeedGuy = CreatePed(0,current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.h, false, false)
    FreezeEntityPosition(WeedGuy, true)
    SetEntityInvincible(WeedGuy, true)
	SetEntityHeading(WeedGuy, 270.0)
	exports.interact:AddEntityInteraction({
		netId = WeedGuy,
		name = 'WeedGuy', -- optional
		id = 'WeedGuy', -- needed for removing interactions
		distance = 3.0, -- optional
		interactDst = 1.0, -- optional
		ignoreLos = false, -- optional ignores line of sight
		offset = vec3(0.0, 0.0, 0.0), -- optional
		options = {
            {
				label = "Weed Shop",
				action = function() lib.showContext('WeedShop')end},
        }
	})
for k, v in pairs (Config.Weed.items) do 
	WeedShop[#WeedShop + 1] = {
		icon =  GetImage(v.name),
		 title = QBCore.Shared.Items[v.name].label,
		 description = '$'.. v.price,
		 event = "wrp-drugs:client:travellingmerchantox",
		 args = {
			item = v.name,
			cost = v.price,
		   	amount = v.amount,
		   	table = Config.Weed.items,
		  	 num = k,
		 }
	 }
 	lib.registerContext({id = 'WeedShop',title = "Weed Shop", options = WeedShop})
	end
end)
