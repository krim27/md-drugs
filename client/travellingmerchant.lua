local QBCore = exports['qb-core']:GetCoreObject()
local currentPed = nil -- Variable to store the current merchant ped
local phoneProp = nil -- Variable to store the phone prop
local merchantLocation = nil -- Variable to store the current location of the merchant
local pedModel = "g_m_y_famdnf_01"
local phoneModel = GetHashKey("prop_phone_ing")

-- Function to create or update the merchant ped and attach the phone prop
local function createMerchantPed(location)
    -- Check if location is valid
    if not location or not location.x or not location.y or not location.z or not location.w then
        print("Error: Invalid location data.")
        return
    end

    if currentPed and phoneProp then
        local pedCoords = GetEntityCoords(currentPed)
        local newCoords = vector3(location.x, location.y, location.z - 1)
        if #(pedCoords - newCoords) < 1.0 then
            return
        end
        DeleteObject(phoneProp)
        phoneProp = nil
        DeletePed(currentPed)
        currentPed = nil
    end

    lib.requestModel(pedModel, Config.RequestModelTime)
    while not HasModelLoaded(pedModel) do
        Wait(500)
    end
    currentPed = CreatePed(0, pedModel, location.x, location.y, location.z - 1, location.w, false, false)
    FreezeEntityPosition(currentPed, true)
    SetEntityInvincible(currentPed, true)
    SetBlockingOfNonTemporaryEvents(currentPed, true)

    local animDict = "amb@world_human_stand_mobile@male@text@base"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(500)
    end
    TaskPlayAnim(currentPed, animDict, "base", 8.0, 0.0, -1, 49, 0, false, false, false)

    RequestModel(phoneModel)
    while not HasModelLoaded(phoneModel) do
        Wait(500)
    end
    phoneProp = CreateObject(phoneModel, location.x, location.y, location.z - 1, true, true, true)
    AttachEntityToEntity(phoneProp, currentPed, GetPedBoneIndex(currentPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    SetEntityAlpha(phoneProp, 255, 0)

    local targetOptions = {
        { label = "Drug Market", icon = "fas fa-eye", action = function() lib.showContext('travellingmerchant') end },
    }
    if Config.oxtarget then
        exports.interact:AddLocalEntityInteraction({
            entity = currentPed,
            name = 'travellingmerchant',
            id = 'travellingmerchant',
            distance = 3.0,
            interactDst = 1.0,
            ignoreLos = false,
            offset = vec3(0.0, 0.0, 0.0),
            options = targetOptions
        })
    else
        exports['qb-target']:AddTargetEntity(currentPed, {
            options = targetOptions
        })
    end
end

-- Initial setup and event handling
CreateThread(function()
    -- Register event to set the merchant's location
    RegisterNetEvent("wrp-drugs:client:setMerchantLocation", function(location)
        if location then
            merchantLocation = location
            createMerchantPed(location) -- Create or update the merchant ped and phone prop
        else
            print("Error: No location data received.")
        end
    end)

    -- Trigger initial merchant location fetch
    TriggerServerEvent("wrp-drugs:server:getMerchantLocation")
end)

-- Context menu setup
CreateThread(function()
    local ShopMenu = {}
    for category, data in pairs(Config.Items.categories) do
        local categoryIcon = data.icon or "fas fa-cube"
        table.insert(ShopMenu, {
            title = category,
            icon = categoryIcon,
            event = "wrp-drugs:client:showCategory",
            args = { category = category, items = data.items }
        })
    end

    lib.registerContext({
        id = 'travellingmerchant',
        title = "Travelling Merchant",
        options = ShopMenu
    })
end)

-- Show category menu
RegisterNetEvent("wrp-drugs:client:showCategory", function(data)
    local CategoryMenu = {}
    for k, v in pairs(data.items) do
        CategoryMenu[#CategoryMenu + 1] = {
            icon = GetImage(v.name),
            description = '$'.. v.price.. ' Dirty Money',
            title = QBCore.Shared.Items[v.name].label,
            event = "wrp-drugs:client:travellingmerchantox",
            args = {
                item = v.name,
                cost = v.price,
                amount = v.amount,
                table = data.items,
                num = k
            }
        }
    end

    lib.registerContext({
        id = 'category_' .. data.category,
        title = data.category,
        options = CategoryMenu,
        menu = 'travellingmerchant'
    })
    lib.showContext('category_' .. data.category)
end)

-- Handle item purchase
RegisterNetEvent("wrp-drugs:client:travellingmerchantox", function(data)
    local price = data.cost
    local settext = "Amount: " .. data.amount .. " | Cost: $" .. price
    local max = data.amount
    local dialog = exports.ox_lib:inputDialog(data.item .. "!", {
        { type = 'number', label = "Amount to Buy", description = settext, min = 0, max = max, default = 1 },
    })

    if dialog and dialog[1] then
        if data.cost == "Free" then data.cost = 0 end
        TriggerServerEvent("wrp-drugs:server:travellingmerchantox", dialog[1], data.item, data.cost, data.table, data.num)
    else
        lib.notify({
            title = "Error",
            description = "You must enter an amount!",
            type = "error"
        })
    end
end)

RegisterNetEvent('wrp-drugs:client:hidemenus', function()
    lib.hideContext()
    lib.closeInputDialog()
    lib.notify({
        title = 'Moving',
        description = 'Merchant Has Moved',
        type = 'error'
    })
end)

-- Clean up phone prop and merchant ped on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        -- Delete the phone prop if it exists
        if phoneProp then
            DeleteObject(phoneProp)
            phoneProp = nil
        end
        
        -- Delete the merchant ped if it exists
        if currentPed then
            DeletePed(currentPed)
            currentPed = nil
        end
    end
end)
