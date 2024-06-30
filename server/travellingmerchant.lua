local QBCore = exports['qb-core']:GetCoreObject()

local lastMerchantUpdate = os.time() -- Initialize with the current time
local updateInterval = 604800 -- 7 days in seconds
local merchantLocation = nil -- Variable to store the current location of the merchant

-- Function to update the merchant's location
local function updateMerchantLocation()
    local newLocation
    repeat
        newLocation = Config.Travellingmerchant[math.random(#Config.Travellingmerchant)]
    until not (merchantLocation and newLocation.x == merchantLocation.x and newLocation.y == merchantLocation.y and newLocation.z == merchantLocation.z)

    -- Print a log for debugging
    print("Travelling Merchant moved to:", newLocation)

    local locationData = json.encode(newLocation)
    exports.oxmysql:execute('INSERT INTO merchant_location (location, last_update) VALUES (@location, @last_update) ON DUPLICATE KEY UPDATE location=@location, last_update=@last_update', {
        ['@location'] = locationData,
        ['@last_update'] = os.time() -- Store the current time as last update time
    })

    merchantLocation = newLocation
    TriggerClientEvent("wrp-drugs:client:setMerchantLocation", -1, newLocation)
    TriggerClientEvent('wrp-drugs:client:hidemenus', -1)
end

-- Fetch the latest merchant location when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        exports.oxmysql:fetch('SELECT location, last_update FROM merchant_location ORDER BY id DESC LIMIT 1', {}, function(result)
            if result[1] and result[1].location then
                merchantLocation = json.decode(result[1].location)
                lastMerchantUpdate = tonumber(result[1].last_update) or os.time() -- Retrieve the last update time from the database
                TriggerClientEvent("wrp-drugs:client:setMerchantLocation", -1, merchantLocation)
            else
                updateMerchantLocation() -- If no location is found in the database, update to a new location
            end
        end)
    end
end)

-- Update the merchant's location periodically
CreateThread(function()
    while true do
        local currentTime = os.time()
        if currentTime - lastMerchantUpdate >= updateInterval then
            updateMerchantLocation()
            lastMerchantUpdate = currentTime
        end
        Wait(3600000) -- Check every hour
    end
end)

-- Handle request to fetch merchant location
RegisterNetEvent('wrp-drugs:server:getMerchantLocation', function()
    local src = source
    if merchantLocation then
        TriggerClientEvent("wrp-drugs:client:setMerchantLocation", src, merchantLocation)
    else
        updateMerchantLocation()
    end
end)

-- Handle item purchase from the merchant
RegisterNetEvent("wrp-drugs:server:travellingmerchantox", function(amount, item, cost, itemsTable, itemIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalCost = cost * amount

    if exports.ox_inventory:RemoveItem(src, 'dirtymoney', totalCost, false, 1, false) then
        Player.Functions.AddItem(item, amount)
        itemsTable[itemIndex].amount = itemsTable[itemIndex].amount - amount

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        TriggerClientEvent('QBCore:Notify', src, "You bought " .. amount .. " " .. QBCore.Shared.Items[item].label .. " for $" .. totalCost, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough dirty money", 'error')
    end
end)

