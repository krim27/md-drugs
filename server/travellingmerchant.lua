local QBCore = exports['qb-core']:GetCoreObject()

local lastMerchantUpdate = os.time() -- Initialize with the current time
local updateInterval = 30 -- 7 days in seconds
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
                lastMerchantUpdate = tonumber(result[1].last_update) or os.time() -- Retrieve the last update time from the database or default to the current time
            else
                updateMerchantLocation()
            end
            -- Trigger client event to set the merchant's location
            TriggerClientEvent("wrp-drugs:client:setMerchantLocation", -1, merchantLocation)
        end)
    end
end)

-- Update merchant location every 7 days
CreateThread(function()
    while true do
        Wait(1000) -- Check every second

        local currentTime = os.time()
        print("Current Time:", currentTime)
        print("Last Merchant Update:", lastMerchantUpdate)
        print("Time Difference:", currentTime - lastMerchantUpdate)
        print("Update Interval:", updateInterval)
        -- Make sure lastMerchantUpdate is a valid number
        if lastMerchantUpdate and (currentTime - lastMerchantUpdate >= updateInterval) then
            updateMerchantLocation()
            lastMerchantUpdate = currentTime -- Update the lastMerchantUpdate to the current time
        end
    end
end)

-- Event to handle item purchase from the travelling merchant
RegisterServerEvent("wrp-drugs:server:travellingmerchantox")
AddEventHandler("wrp-drugs:server:travellingmerchantox", function(amount, item, price, table, num)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if table[num].name ~= item then return end
    if exports.ox_inventory:RemoveItem(src, 'dirtymoney', tonumber(price) * tonumber(amount), false, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
        Player.Functions.AddItem(item, amount)
        -- Play purchase animations for the ped and player
        TriggerClientEvent("wrp-drugs:client:playPurchaseAnimations", src)
    end
end)

-- Event to get the merchant's location from the server
RegisterServerEvent("wrp-drugs:server:getMerchantLocation")
AddEventHandler("wrp-drugs:server:getMerchantLocation", function()
    local src = source
    TriggerClientEvent("wrp-drugs:client:setMerchantLocation", src, merchantLocation)
end)
