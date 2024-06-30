local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local cuttingcoke = nil
local baggingcoke = nil
local isProgressActive = false

RegisterNetEvent('coke:respawnCane', function(loc)
    local v = GlobalState.CocaPlant[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not CocaPlant[loc] then
        CocaPlant[loc] = CreateObject(hash, v.location.x, v.location.y, v.location.z, true, true, true)
        SetEntityAsMissionEntity(CocaPlant[loc], true, true)
        FreezeEntityPosition(CocaPlant[loc], true)
        SetEntityHeading(CocaPlant[loc], v.heading)
        local options = {
            {
                label = "pick Cocaine",
                icon = 'fa-solid fa-leaf',
                onSelect = function()
                    if not progressbar(Lang.Coke.picking, 8000, 'garden') then return end
                    TriggerServerEvent("coke:pickupCane", loc)   
                end,
                canInteract = function ()
                    local item = QBCore.Functions.HasItem('trowel')
                    return item
                end
            },
        }
        exports.ox_target:addLocalEntity(CocaPlant[loc], options)
    end
end)

RegisterNetEvent('coke:removeCane', function(loc)
    if DoesEntityExist(CocaPlant[loc]) then DeleteEntity(CocaPlant[loc]) end
    CocaPlant[loc] = nil
end)

RegisterNetEvent("coke:init", function()
    for k, v in pairs (GlobalState.CocaPlant) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            CocaPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, true, true, true)
            SetEntityAsMissionEntity(CocaPlant[k], true, true)
            FreezeEntityPosition(CocaPlant[k], true)
            SetEntityHeading(CocaPlant[k], v.heading)
            local options = {
                {
                    label = "pick Cocaine",
                    icon = 'fa-solid fa-leaf',
                    onSelect = function()
                        if not progressbar(Lang.Coke.picking, 8000, 'garden') then  return end
                        TriggerServerEvent("coke:pickupCane", k)
                    end,
                    canInteract = function ()
                        local item = QBCore.Functions.HasItem('trowel')
                        return item
                    end
                },
            }
            exports.ox_target:addLocalEntity(CocaPlant[k], options)
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('prop_plant_01a')
        TriggerEvent('coke:init')
    end
 end)
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_plant_01a')
     TriggerEvent('coke:init')
 end)
 
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_plant_01a'))
        for k, v in pairs(CocaPlant) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)



-- Register a client-side event for making powder from coca leaves
RegisterNetEvent("wrp-drugs:client:makepowder", function(data)
    -- Check if the progress bar is already active
    if isProgressActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'coca_leaf'
    if not ItemCheck('coca_leaf') then 
        return 
    end
    
    -- Set the progress bar status to active
    isProgressActive = true
    
    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Coke.makepow, 4000, 'uncuff') then 
        isProgressActive = false  -- Reset the status if progress bar fails
        return 
    end
    
    -- Trigger a server-side event to process making powder
    TriggerServerEvent("wrp-drugs:server:makepowder", data.data)
    
    -- Reset the progress bar status after completion
    isProgressActive = false
end)


-- Initialize variables to track the progress bar status
local isCuttingCokeActive = false
local isBaggingCokeActive = false

-- Register a client-side event for cutting coke
RegisterNetEvent("wrp-drugs:client:cutcokeone", function()
    -- Check if the progress bar is already active
    if isCuttingCokeActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'bakingsoda'
    if not ItemCheck('bakingsoda') then 
        return 
    end

    -- Set the progress bar status to active
    isCuttingCokeActive = true

    -- Handle animations or progress bar
    if Config.FancyCokeAnims then
        CutCoke()
    else
        if not progressbar(Lang.Coke.cutting, 5000, 'uncuff') then 
            isCuttingCokeActive = false  -- Reset the status if progress bar fails
            return 
        end
    end

    -- Trigger a server-side event to process cutting coke
    TriggerServerEvent("wrp-drugs:server:cutcokeone")

    -- Reset the progress bar status after completion
    isCuttingCokeActive = false
end)

-- Register a client-side event for bagging coke
RegisterNetEvent("wrp-drugs:client:bagcoke", function() 
    -- Check if the progress bar is already active
    if isBaggingCokeActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'empty_coke_bag'
    if not ItemCheck('empty_coke_bag') then 
        return 
    end

    -- Set the progress bar status to active
    isBaggingCokeActive = true

    -- Handle animations or progress bar
    if Config.FancyCokeAnims then
        BagCoke()
    else
        if not progressbar(Lang.Coke.bagging, 5000, 'uncuff') then 
            isBaggingCokeActive = false  -- Reset the status if progress bar fails
            return 
        end
    end

    -- Trigger a server-side event to process bagging coke
    TriggerServerEvent("wrp-drugs:server:bagcoke")

    -- Reset the progress bar status after completion
    isBaggingCokeActive = false
end)


CreateThread(function()
	local options = {
		{ type = "client", event = "wrp-drugs:client:cutcokeone", icon = "fas fa-sign-in-alt", label = "cut up", canInteract = function()
				if cuttingcoke == nil and baggingcoke == nil then return true end
			end			
		},
	}
    local options2 = {
		{ type = "client", event = "wrp-drugs:client:bagcoke", icon = "fas fa-sign-in-alt", label = "bagging", canInteract = function()
				if baggingcoke == nil and cuttingcoke == nil then return true end end }, }
    if Config.oxtarget then
        exports.interact:AddInteraction({
            coords = vector3(1093.17, -3195.74, -39.19),
            distance = 4.0, -- optional
            interactDst = 1.0, -- optional
            id = "cutcokepowder", -- needed for removing interactions
            name = "cutcokepowder", -- optional
            options = {
                {
                    action = function()
                        TriggerEvent('wrp-drugs:client:cutcokeone')
                    end,
                    label = "cut up", 
                    canInteract = function()
                        
                        local item1 = QBCore.Functions.HasItem('bakingsoda')
                        local item2 = QBCore.Functions.HasItem('coke')
                        local item3 = QBCore.Functions.HasItem('cokestagetwo')
                        local item4 = QBCore.Functions.HasItem('cokestagethree')
                    
                        if item1 and (item2 or item3 or item4) then
                            return true
                        else
                            return false
                        end
                        
                    end
                    
                },
                
            }
        })
        exports.interact:AddInteraction({
            coords = vector3(1090.3503417969, -3195.7060546875, -39.191955566406),
            distance = 4.0, -- optional
            interactDst = 1.0, -- optional
            id = "bagcokepowder", -- needed for removing interactions
            name = "bagcokepowder", -- optional
            options = {
                {
                    action = function()
                        TriggerEvent('wrp-drugs:client:bagcoke')
                    end,
                    label = "bagging", 
                    canInteract = function()
                        local item1 = QBCore.Functions.HasItem('empty_coke_bag')
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
        })
        --exports.ox_target:addBoxZone({coords = vector3(1093.17, -3195.74, -39.19 -1), size = vec3(1,1,1), options = options})
        --exports.ox_target:addBoxZone({coords = vector3(1093.17, -3195.74, -39.19 -1), size = vec3(1,1,1), options = options2})
    else
        exports['qb-target']:AddBoxZone("cutcokepowder",vector3(1093.17, -3195.74, -39.19 -1),1.5, 1.75, {name = "cutcokepowder", minZ = -40.0,maxZ = -38.0,}, { options = options, distance = 2.0 })
	    exports['qb-target']:AddBoxZone("bagcokepowder",vector3(1090.29, -3195.66, -39.13 - 1),1.5, 1.75, {name = "bagcokepowder", minZ = -40, maxZ = -38,}, {options = options2, distance = 2.0})
    end
    if Config.FancyCokeAnims == false then 
        for k, v in pairs (Config.CuttingCoke) do 
            if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
             local options = {
                {	type = "client",	event = "wrp-drugs:client:cutcokeone",	icon = "fas fa-sign-in-alt",	label = "Cut Coke", data = k,  distance = 2.0,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
                },
            }
            if Config.oxtarget then
                exports.interact:AddInteraction({
                    coords = v.loc,
                    distance = 4.0, -- optional
                    interactDst = 1.0, -- optional
                    id = "cutcoke", -- needed for removing interactions
                    name = "cutcoke"..k, -- optional
                    options = options
                })
               -- exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
            else
                exports['qb-target']:AddBoxZone("cutcoke"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="cutcoke"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
            end
        end
        for k, v in pairs (Config.BaggingCoke) do 
            if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
             local options = {
                {	type = "client",	event = "wrp-drugs:client:bagcoke",	icon = "fas fa-sign-in-alt",	label = "Bag Coke", data = k,  distance = 2.0,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
                },
            }
            if Config.oxtarget then
                exports.interact:AddInteraction({
                    coords = v.loc,
                    distance = 4.0, -- optional
                    interactDst = 1.0, -- optional
                    id = "bagcoke", -- needed for removing interactions
                    name = "bagcoke"..k, -- optional
                    options = options
                })
                --exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
            else
                exports['qb-target']:AddBoxZone("bagcoke"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="bagcoke"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
            end
        end
    end
end)