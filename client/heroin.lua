local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local PoppyPlants = {}
local herointable = false

-- Initialize a table to track active progress bars for poppy plant interactions
local interactingWithPoppy = {}

-- Initialize variables to track the progress bar status
local isDryingPlantActive = false
local isCuttingHeroinActive = false
local isBuyingHeroinLabKitActive = false

-- Initialize a variable to track the progress bar status
local isHeatingLiquidHeroinActive = false

-- Initialize a variable to track the progress bar status
local isCleaningHeroinLabKitActive = false

-- Initialize a variable to track the progress bar status
local isGettingHeroinKitBackActive = false

-- Initialize a variable to track the progress bar status
local isFillingNeedleActive = false

local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

-- Register a client-side event for respawning poppy plants
RegisterNetEvent('heroin:respawnCane', function(loc)
    local v = GlobalState.PoppyPlants[loc]
    local hash = GetHashKey(v.model)

    if not PoppyPlants[loc] then
        PoppyPlants[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(PoppyPlants[loc], true, true)
        FreezeEntityPosition(PoppyPlants[loc], true)
        SetEntityHeading(PoppyPlants[loc], v.heading)
        local options = {
            {
                label = "Pick Poppies",
                icon = 'fa-solid fa-leaf',
                onSelect = function()
                    -- Check if already interacting with this poppy plant
                    if interactingWithPoppy[loc] then
                        lib.notify({
                            title = 'Nerd',
                            description = 'Stop Spamming nerd',
                            type = 'error',
                            position = 'bottom'
                        })
                        return
                    end

                    -- Check if player has the required item 'trowel'
                    local item = QBCore.Functions.HasItem('trowel')
                    if not item then
                        return
                    end

                    -- Set the interaction as active
                    interactingWithPoppy[loc] = true

                    -- Show a progress bar for 4 seconds with the action 'uncuff'
                    if not progressbar(Lang.Heroin.pick, 4000, 'uncuff') then
                        interactingWithPoppy[loc] = false
                        return
                    end

                    -- Trigger server event to pick poppies
                    TriggerServerEvent("heroin:pickupCane", loc)

                    -- Reset interaction status after completion
                    interactingWithPoppy[loc] = false
                end,
                canInteract = function()
                    local item = QBCore.Functions.HasItem('trowel')
                    return item
                end
            },
        }
        exports.ox_target:addLocalEntity(PoppyPlants[loc], options)
    end
end)

RegisterNetEvent('heroin:removeCane', function(loc)
    if DoesEntityExist(PoppyPlants[loc]) then DeleteEntity(PoppyPlants[loc]) end
    PoppyPlants[loc] = nil
end)

-- Register a client-side event for initializing poppy plants
RegisterNetEvent("heroin:init", function()
    for k, v in pairs(GlobalState.PoppyPlants) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then
            LoadModel(hash)
        end
        if not v.taken then
            PoppyPlants[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(PoppyPlants[k], true, true)
            FreezeEntityPosition(PoppyPlants[k], true)
            SetEntityHeading(PoppyPlants[k], v.heading)
            local options = {
                {
                    label = "Pick Poppies",
                    icon = 'fa-solid fa-leaf',
                    onSelect = function()
                        -- Check if already interacting with this poppy plant
                        if interactingWithPoppy[k] then
                            return
                        end

                        -- Check if player has the required item 'trowel'
                        local item = QBCore.Functions.HasItem('trowel')
                        if not item then
                            return
                        end

                        -- Set the interaction as active
                        interactingWithPoppy[k] = true

                        -- Show a progress bar for 4 seconds with the action 'uncuff'
                        if not progressbar(Lang.Heroin.pick, 4000, 'uncuff') then
                            interactingWithPoppy[k] = false
                            return
                        end

                        -- Trigger server event to pick poppies
                        TriggerServerEvent("heroin:pickupCane", k)

                        -- Reset interaction status after completion
                        interactingWithPoppy[k] = false
                    end,
                    canInteract = function()
                        local item = QBCore.Functions.HasItem('trowel')
                        return item
                    end
                },
            }
            exports.ox_target:addLocalEntity(PoppyPlants[k], options)
        end
    end
end)


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('prop_plant_01b')
        TriggerEvent('heroin:init')
    end
 end)
 
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_plant_01b')
     TriggerEvent('heroin:init')
 end)
 
 AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_plant_01b'))
        for k, v in pairs(PoppyPlants) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
	DeleteObject(heroinlabkit)
	DeleteObject(dirtylabkitheroin)
end)

-- Register a client-side event for drying plant
RegisterNetEvent("wrp-drugs:client:dryplant", function(data) 
    -- Check if the progress bar is already active
    if isDryingPlantActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Set the progress bar status to active
    isDryingPlantActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.dryout, 4000, 'uncuff') then 
        isDryingPlantActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process drying plant
    TriggerServerEvent("wrp-drugs:server:dryplant", data.data)

    -- Reset the progress bar status after completion
    isDryingPlantActive = false
end)

-- Register a client-side event for cutting heroin
RegisterNetEvent("wrp-drugs:client:cutheroin", function(data) 
    -- Check if the progress bar is already active
    if isCuttingHeroinActive then 
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
    isCuttingHeroinActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.cutting, 4000, 'uncuff') then 
        isCuttingHeroinActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process cutting heroin
    TriggerServerEvent("wrp-drugs:server:cutheroin", data.data)

    -- Reset the progress bar status after completion
    isCuttingHeroinActive = false
end)

-- Register a client-side event for buying heroin lab kit
RegisterNetEvent("wrp-drugs:client:buyheroinlabkit", function()
    -- Check if the progress bar is already active
    if isBuyingHeroinLabKitActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Set the progress bar status to active
    isBuyingHeroinLabKitActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.secret, 4000, 'uncuff') then 
        isBuyingHeroinLabKitActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process buying heroin lab kit
    TriggerServerEvent("wrp-drugs:server:getheroinlabkit")

    -- Reset the progress bar status after completion
    isBuyingHeroinLabKitActive = false
end)


-- Function to perform a raycast from the player's camera
function RaycastFromCamera(distance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local cameraRot = GetGameplayCamRot(2)
    local cameraCoords = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRot)
    local destination = vector3(cameraCoords.x + direction.x * distance, cameraCoords.y + direction.y * distance, cameraCoords.z + direction.z * distance)

    local rayHandle = StartShapeTestRay(cameraCoords.x, cameraCoords.y, cameraCoords.z, destination.x, destination.y, destination.z, -1, playerPed, 0)
    local _, hit, hitCoords, _, _ = GetShapeTestResult(rayHandle)

    return hit, hitCoords
end

-- Function to convert rotation to direction vector
function RotationToDirection(rotation)
    local adjustedRotation = { x = math.rad(rotation.x), y = math.rad(rotation.y), z = math.rad(rotation.z) }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

-- Function to create and return a preview object
function CreatePreviewObject(modelName, coords)
    local modelHash = GetHashKey(modelName)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local previewObject = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
    SetEntityAlpha(previewObject, 150, false) -- Set transparency for preview
    SetEntityCollision(previewObject, false, false) -- Disable collision for preview
    PlaceObjectOnGroundProperly(previewObject) -- Snap to ground
    return previewObject
end

-- Function to delete an object
function DeleteObject(obj)
    if DoesEntityExist(obj) then
        DeleteEntity(obj)
    end
end

-- Register the event for setting the Heroin lab kit
RegisterNetEvent("wrp-drugs:client:setheroinlabkit")
AddEventHandler("wrp-drugs:client:setheroinlabkit", function()
    local herointable = false -- Track if heroin lab kit is placed
    if herointable then 
        Notify(Lang.Heroin.tableout, 'error')
        return
    end

    herointable = true

    -- Start the placement process
    CreateThread(function()
        local previewObject = nil
        local model = "v_ret_ml_tablea"
        local rotation = 0.0

        while true do
            Wait(0)

            -- Perform raycast from camera to get hit coordinates
            local hit, hitCoords = RaycastFromCamera(10.0) -- Adjust distance as needed

            -- Update or create the preview object based on raycast
            if hit then
                if not previewObject then
                    previewObject = CreatePreviewObject(model, hitCoords)
                else
                    SetEntityCoords(previewObject, hitCoords.x, hitCoords.y, hitCoords.z, false, false, false, true)
                    SetEntityHeading(previewObject, rotation)
                    PlaceObjectOnGroundProperly(previewObject) -- Ensure it snaps to the ground
                end
            end

            -- Rotate the object with the scroll wheel
            if IsControlJustPressed(0, 241) then -- Scroll wheel up
                rotation = rotation + 5.0
                if rotation >= 360.0 then rotation = 0.0 end
            elseif IsControlJustPressed(0, 242) then -- Scroll wheel down
                rotation = rotation - 5.0
                if rotation < 0.0 then rotation = 355.0 end
            end

            -- Check for key press (E) to place the object
            if IsControlJustReleased(0, 38) then -- E key
                if hit then
                    local heroinlabkit = CreateObject(model, hitCoords.x, hitCoords.y, hitCoords.z, true, true, true)
                    SetEntityHeading(heroinlabkit, rotation)
                    PlaceObjectOnGroundProperly(heroinlabkit) -- Snap to ground

                    -- Define interaction options
                    local options = {
                        {
                            event = "wrp-drugs:client:heatliquidheroin",
                            icon = "fa-solid fa-fire-flame-curved",
                            label = "Cook Heroin",
                            data = heroinlabkit,
                            canInteract = function()
                                local item1 = QBCore.Functions.HasItem('emptyvial')
                                local item2 = QBCore.Functions.HasItem('heroincut')
                                local item3 = QBCore.Functions.HasItem('heroincutstagetwo')
                                local item4 = QBCore.Functions.HasItem('heroincutstagethree')
                                return item1 and (item2 or item3 or item4)
                            end
                        },
                        {
                            event = "wrp-drugs:client:getheroinkitback",
                            icon = "fa-solid fa-hand",
                            label = "Pick Up",
                            data = heroinlabkit,
                            canInteract = function()
                                return not herointable
                            end
                        },
                    }

                    -- Add interaction options to the target system
                    if Config.oxtarget then
                        exports.ox_target:addLocalEntity(heroinlabkit, options)
                    else
                        exports['qb-target']:AddTargetEntity(heroinlabkit, {options = options})
                    end

                    -- Delete the preview object and exit the loop
                    DeleteObject(previewObject)
                    previewObject = nil
                    break
                else
                    Notify("No valid surface detected!", 'error')
                end
            end

            -- Check for key press (X) to cancel placement
            if IsControlJustReleased(0, 73) then -- X key
                if previewObject then
                    DeleteObject(previewObject)
                    previewObject = nil
                    TriggerServerEvent("wrp-drugs:server:getheroinlabkitback")
                end
                break
            end
        end

        herointable = false
    end)
end)

-- Register a client-side event for heating liquid heroin
RegisterNetEvent("wrp-drugs:client:heatliquidheroin", function(data) 
    -- Check if the progress bar is already active
    if isHeatingLiquidHeroinActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    local PedCoords = GetEntityCoords(PlayerPedId())

    -- Check if the player has the required item 'emptyvial'
    if not ItemCheck('emptyvial') then 
        return 
    end

    -- Perform the minigame check
    if not minigame(2, 8) then
        TriggerServerEvent("wrp-drugs:server:failheatingheroin")
        DeleteObject(data.data)
        Wait(100)
        local dirtylabkitheroin = CreateObject("v_ret_ml_tablea", PedCoords.x + 1, PedCoords.y + 1, PedCoords.z - 1, true, true, true)
        loadParticle("core")
        heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", dirtylabkitheroin, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
        SetParticleFxLoopedAlpha(heroinkit, 3.0)
        SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
        local options = {
            {
                event = "wrp-drugs:client:cleanheroinlabkit",
                icon = "fas fa-box-circle-check",
                label = "Clean It",
                data = dirtylabkitheroin,
                canInteract = function()
                    local item1 = QBCore.Functions.HasItem('cleaningkit')
                    if item1 then
                        return true
                    else
                        return false
                    end
                end
            }
        }
        if Config.oxtarget then
            exports.ox_target:addLocalEntity(dirtylabkitheroin, options)
        else
            exports['qb-target']:AddTargetEntity(dirtylabkitheroin, {options = options})
        end
        return
    end

    -- Set the progress bar status to active
    isHeatingLiquidHeroinActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.success, 4000, 'uncuff') then 
        isHeatingLiquidHeroinActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process heating liquid heroin
    TriggerServerEvent("wrp-drugs:server:heatliquidheroin")

    -- Reset the progress bar status after completion
    isHeatingLiquidHeroinActive = false
end)

-- Register a client-side event for cleaning heroin lab kit
RegisterNetEvent("wrp-drugs:client:cleanheroinlabkit", function(data)
    -- Check if the progress bar is already active
    if isCleaningHeroinLabKitActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'cleaningkit'
    if not ItemCheck('cleaningkit') then 
        return 
    end

    -- Set the progress bar status to active
    isCleaningHeroinLabKitActive = true

    -- Show a progress bar for 4 seconds with the action 'clean'
    if not progressbar(Lang.Heroin.clean, 4000, 'clean') then 
        isCleaningHeroinLabKitActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process cleaning the heroin lab kit
    TriggerServerEvent("wrp-drugs:server:removecleaningkitheroin", data.data)

    -- Reset the progress bar status after completion
    isCleaningHeroinLabKitActive = false
end)


RegisterNetEvent("wrp-drugs:client:deletedirtyheroin", function(data) 
    DeleteObject(data)
    herointable = false
    Wait(1000)
    TriggerEvent("wrp-drugs:client:setheroinlabkit")
end)

-- Register a client-side event for getting heroin kit back
RegisterNetEvent("wrp-drugs:client:getheroinkitback", function(data)
    -- Check if the progress bar is already active
    if isGettingHeroinKitBackActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Set the progress bar status to active
    isGettingHeroinKitBackActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.pickup, 4000, 'uncuff') then 
        isGettingHeroinKitBackActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Reset the table status and delete the object
    herointable = false
    DeleteObject(data.data)

    -- Trigger a server-side event to process getting heroin kit back
    TriggerServerEvent("wrp-drugs:server:getheroinlabkitback")

    -- Reset the progress bar status after completion
    isGettingHeroinKitBackActive = false
end)

-- Register a client-side event for filling needle
RegisterNetEvent("wrp-drugs:client:fillneedle", function(data)
    -- Check if the progress bar is already active
    if isFillingNeedleActive then 
        lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Perform the minigame check
    if not minigame(2, 8) then
        TriggerServerEvent("wrp-drugs:server:failheroin", data.data)
        return 
    end

    -- Set the progress bar status to active
    isFillingNeedleActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Heroin.needles, 4000, 'uncuff') then 
        isFillingNeedleActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process filling the needle
    TriggerServerEvent("wrp-drugs:server:fillneedle", data.data)

    -- Reset the progress bar status after completion
    isFillingNeedleActive = false
end)



