local QBCore = exports['qb-core']:GetCoreObject()
local WeedPlant = {}
local exploded = nil
local dryingSpots = {} -- Table to track drying states for each spot
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
							TriggerServerEvent('md-drugs:server:putoutweed')
							
							Citizen.SetTimeout(math.random(30000, 120000), function()
								Notify("Take down the weed from spot " .. k, "success")
								local options = {
									{
										icon = "fas fa-sign-in-alt",
										label = "Pick Up Weed",
										action = function()
											DeleteEntity(weedplant)
											TriggerServerEvent('md-drugs:server:dryoutweed')
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
											TriggerServerEvent('md-drugs:server:dryoutweed')
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
					SetEntityCoords(PlayerPedId(),Config.Teleout)

				end,
				canInteract = function()
				if Config.Joblock then
					if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
						return true end
					else
					return true end 
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
					SetEntityCoords(PlayerPedId(),Config.Telein)
				end,
				canInteract = function()
				if Config.Joblock then
					if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
						return true end
				else
				return true end end,
	        },
	    }
	})
	-- Butter, Brownies, Cookies, Chocolate, Muffin Interactions
	exports.interact:AddInteraction({
	    coords = Config.MakeButter,
	    distance = 3.0, -- optional
	    interactDst = 1.0, -- optional
	    id = 'MakeButter', -- needed for removing interactions
	    name = 'MakeButter', -- optional
	    options = {
	        {
	            label = "Make Butter",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 10 then
	                    if not ItemCheck('mdbutter') and not ItemCheck('grindedweed') then return end
	                    if not minigame(2, 8) then return end
	                    if not progressbar(Lang.Weed.canna, 4000, 'uncuff') then return end
	                    TriggerServerEvent("md-drugs:server:makebutter")
	                else
	                    QBCore.Functions.Notify("Not high enough level (10)", "error")
	                end
	            end,
	        },
	        {
	            label = "Make Brownies",
	            item = "cannabutter",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 20 then
	                    if not ItemCheck('cannabutter') and not ItemCheck('flour') and not ItemCheck('chocolate') then return end
	                    if not minigame(2, 8) then return end
	                    if not progressbar(Lang.Weed.brown, 4000, 'uncuff') then return end
	                    TriggerServerEvent("md-drugs:server:makebrownies")
	                else
	                    QBCore.Functions.Notify("Not high enough level (20)", "error")
	                end
	            end,
	        },
	        {
	            label = "Make Cookies",
	            item = "cannabutter",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 15 then
	                    if not ItemCheck('cannabutter') and not ItemCheck('flour') then return end
	                    if not minigame(2, 8) then return end
	                    if not progressbar(Lang.Weed.cook, 4000, 'uncuff') then return end
	                    TriggerServerEvent("md-drugs:server:makecookies")
	                else
	                    QBCore.Functions.Notify("Not high enough level (15)", "error")
	                end
	            end,
	        },
	        {
	            label = "Make Chocolate",
	            item = "cannabutter",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 25 then
	                    if not ItemCheck('cannabutter') and not ItemCheck('chocolate') then return end
	                    if not minigame(2, 8) then return end
	                    if not progressbar(Lang.Weed.choc, 4000, 'uncuff') then return end
	                    TriggerServerEvent("md-drugs:server:makechocolate")
	                else
	                    QBCore.Functions.Notify("Not high enough level (25)", "error")
	                end
	            end,
	        },
	        {
	            label = "Make Muffin",
	            item = "cannabutter",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 30 then
	                    if not ItemCheck('cannabutter') and not ItemCheck('flour') then return end
	                    if not minigame(2, 8) then return end
	                    if not progressbar(Lang.Weed.muff, 4000, 'uncuff') then return end
	                    TriggerServerEvent("md-drugs:server:makemuffin")
	                else
	                    QBCore.Functions.Notify("Not high enough level (30)", "error")
	                end
	            end,
	        },
	    }
	})

	-- Oil Interaction
	exports.interact:AddInteraction({
	    coords = Config.MakeOil,
	    distance = 3.0, -- optional
	    interactDst = 1.0, -- optional
	    id = 'makeoil', -- needed for removing interactions
	    name = 'makeoil', -- optional
	    options = {
	        {
	            label = "Make Oil",
	            action = function()
	                local skillLevel = exports.evolent_skills:getSkillLevel('weed')
	                if skillLevel >= 50 then
	                    if not ItemCheck('butane') and not ItemCheck('grindedweed') then return end
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
	                    TriggerServerEvent("md-drugs:server:makeoil")
	                else
	                    QBCore.Functions.Notify("Not high enough level (50)", "error")
	                end
	            end,
	            canInteract = function()
	                if exploded == nil then return true end
	            end,
	        },
	    }
	})

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

RegisterNetEvent('md-drugs:client:bluntwraps', function(args)
  lib.registerContext({
    id = 'bluntroll',
    title = 'Blunt Types',
    menu = 'bluntroll',
    options = {
    	{ title = 'Roll Blunt',  description = 'Roll A Regular Blunt',  icon = 'check',  serverEvent = 'md-drugs:server:rollblunt'},
		{ title = 'Dip Blunt Wrap In Lean', description = 'Roll A Lean Blunt', icon = 'check', serverEvent = 'md-drugs:server:rollleanblunt'},
		{ title = 'Dip Blunt Wrap In Dextro',  description = 'Roll A Dextro Blunt',  icon = 'check',  serverEvent = 'md-drugs:server:rolldextroblunt'},
		{ title = 'Roll A Chewy Blunt',  description = 'Roll A Chewy Blunt',  icon = 'check',  serverEvent = 'md-drugs:server:rollchewyblunt'},
  	},
  })
  lib.showContext('bluntroll')
end)

RegisterNetEvent("md-drugs:client:rollanim", function()
if not progressbar(Lang.Weed.roll, 4000, 'uncuff') then return end
end)
RegisterNetEvent("md-drugs:client:grind", function()
	if not progressbar("grinding", 4000, 'uncuff') then return end
end)
	


RegisterNetEvent("md-drugs:client:dodabs", function()
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
		 event = "md-drugs:client:travellingmerchantox",
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
