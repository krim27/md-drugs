local QBCore = exports['qb-core']:GetCoreObject()
local tableout = false


local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end




RegisterNetEvent("wrp-drugs:client:getlysergic", function(data) 
    if not minigame(2, 8) then return end
	if not progressbar(Lang.lsd.steallys, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:getlysergic",data.data)
end)


RegisterNetEvent("wrp-drugs:client:getdiethylamide", function(data) 
    if not minigame(2, 8) then return end
	if not progressbar(Lang.lsd.stealdie, 4000, 'uncuff') then return end
    TriggerServerEvent('wrp-drugs:server:getdiethylamide', data.data)
end)

local previewObject = nil
local rotation = 0.0

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
    local previewObj = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
    SetEntityAlpha(previewObj, 150, false)
    SetEntityCollision(previewObj, false, false)
    PlaceObjectOnGroundProperly(previewObj)
    return previewObj
end

-- Function to delete an object
function DeleteObject(obj)
    if DoesEntityExist(obj) then
        DeleteEntity(obj)
    end
end

-- Register the event for setting the LSD lab kit
RegisterNetEvent("wrp-drugs:client:setlsdlabkit")
AddEventHandler("wrp-drugs:client:setlsdlabkit", function()
    if tableout then 
        Notify(Lang.lsd.tableout, 'error')
        TriggerServerEvent('wrp-drugs:server:getlabkitback')
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
                    previewObject = CreatePreviewObject("v_ret_ml_tablea", hitCoords)
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
                    -- Place the actual lab kit object
                    local labkit = CreateObject("v_ret_ml_tablea", hitCoords.x, hitCoords.y, hitCoords.z, true, true, true)
                    SetEntityHeading(labkit, rotation)
                    PlaceObjectOnGroundProperly(labkit)

                    -- Set interaction options
                    local options = {
                        {
                            event = "wrp-drugs:client:heatliquid",
                            icon = "fa-solid fa-fire-flame-curved",
                            label = "Heat Liquid",
                            data = labkit,
                            canInteract = function()
                                local item1 = QBCore.Functions.HasItem('diethylamide')
                                local item2 = QBCore.Functions.HasItem('lysergic_acid')
                                return item1 and item2
                            end
                        },
                        {
                            event = "wrp-drugs:client:refinequalityacid",
                            icon = "fa-solid fa-flask",
                            label = "Refine",
                            data = labkit,
                            canInteract = function()
                                local item1 = QBCore.Functions.HasItem('lsd_one_vial')
                                return item1
                            end
                        },
                        {
                            event = "wrp-drugs:client:maketabpaper",
                            icon = "fa-solid fa-sheet-plastic",
                            label = "Dab Sheets",
                            data = labkit,
                            canInteract = function()
                                local item1 = QBCore.Functions.HasItem('tab_paper')
                                return item1
                            end
                        },
                        {
                            event = "wrp-drugs:client:getlabkitback",
                            icon = "fa-solid fa-hand",
                            label = "Pick Up",
                            data = labkit,
                            canInteract = function()
                                return not tableout
                            end
                        },
                    }

                    -- Add interaction options to the target system
                    if Config.oxtarget then
                        exports.ox_target:addLocalEntity(labkit, options)
                    else
                        exports['qb-target']:AddTargetEntity(labkit, { options = options })
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
                    TriggerServerEvent('wrp-drugs:server:getlabkitback')
                end
                break
            end
        end

        tableout = false
    end)
end)


RegisterNetEvent("wrp-drugs:client:getlabkitback", function(data) 
    if not progressbar(Lang.lsd.tablepack, 4000, 'uncuff') then return end
	DeleteObject(data.data)
	TriggerServerEvent('wrp-drugs:server:getlabkitback')
    tableout = false
end)

RegisterNetEvent("wrp-drugs:client:heatliquid", function(data) 
	local PedCoords = GetEntityCoords(PlayerPedId())
	dict = "scr_ie_svm_technical2"
    if not ItemCheck('lysergic_acid') then return end
    if not ItemCheck('diethylamide') then return end
	if not minigame(2, 8) then
        TriggerServerEvent("wrp-drugs:server:failheating")
		DeleteObject(data.data)
		local dirtylabkit = CreateObject("v_ret_ml_tablea", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, true,true)
		loadParticle(dict)
	    exitPtfx = StartParticleFxLoopedOnEntity("scr_dst_cocaine", dirtylabkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
		PlaceObjectOnGroundProperly(dirtylabkit)
        SetParticleFxLoopedAlpha(exitPtfx, 3.0)
		local options = {
            { event = "wrp-drugs:client:cleanlabkit", icon = "fas fa-box-circle-check", label = "Clean It", data = dirtylabkit, canInteract = function()
                local item1 = QBCore.Functions.HasItem('cleaningkit')
                
                if item1 then
                    return true
                else
                    return false
                end
            end},
        }
        if Config.oxtarget then
            exports.ox_target:addLocalEntity(dirtylabkit, options)
        else    
	        exports['qb-target']:AddTargetEntity(dirtylabkit, { options = options})
        end
        return end
    if not progressbar(Lang.lsd.heat, 7000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:heatliquid")
end)

RegisterNetEvent("wrp-drugs:client:cleanlabkit", function(data)
    if not ItemCheck('cleaningkit')  then return end
    if not progressbar(Lang.lsd.clean, 4000, 'clean') then return end
    tableout = false
	TriggerServerEvent("wrp-drugs:server:removecleaningkit", data.data)
end)


RegisterNetEvent("wrp-drugs:client:resetlsdkit", function(data) 
    DeleteObject(data)
    TriggerEvent("wrp-drugs:client:setlsdlabkit")
end)


RegisterNetEvent("wrp-drugs:client:refinequalityacid", function()
    if not ItemCheck('lsd_one_vial')  then return end 
    if not minigame(2, 8) then TriggerServerEvent("wrp-drugs:server:failrefinequality") return end
    if not progressbar(Lang.lsd.refine, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:refinequalityacid")
end)

RegisterNetEvent("wrp-drugs:client:maketabpaper", function()
    if not ItemCheck('tab_paper')  then return end 
    if not minigame(2, 8) then TriggerServerEvent("wrp-drugs:server:failtabs") return end
	if not progressbar(Lang.lsd.dip, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:maketabpaper")
end)

RegisterNetEvent("wrp-drugs:client:buytabs", function(data) 
	if not progressbar(Lang.lsd.buypaper, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:gettabpaper", data.data)
end)


RegisterNetEvent("wrp-drugs:client:buylabkit", function()
    if QBCore.Functions.HasItem('lsdlabkit') then Notify('You Have One Idiot', 'error') return end 
	if not progressbar(Lang.lsd.buykit, 4000, 'uncuff') then return end
	TriggerServerEvent("wrp-drugs:server:getlabkit")
end)
