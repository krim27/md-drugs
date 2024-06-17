local QBCore = exports['qb-core']:GetCoreObject()
-- Initialize variables to track the progress bar status
local isMakingCrackActive = false
local isBaggingCrackActive = false

-- Register a client-side event for making crack
RegisterNetEvent("md-drugs:client:makecrackone", function(data)
    -- Check if the progress bar is already active
    if isMakingCrackActive then 
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

    -- Perform the minigame check
    if not minigame(2, 8) then 
        TriggerServerEvent("md-drugs:server:failcrackone", data.data)
        return 
    end

    -- Set the progress bar status to active
    isMakingCrackActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Crack.cookcrack, 4000, 'uncuff') then 
        isMakingCrackActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process making crack
    TriggerServerEvent("md-drugs:server:makecrackone", data.data)

    -- Reset the progress bar status after completion
    isMakingCrackActive = false
end)

-- Register a client-side event for bagging crack
RegisterNetEvent("md-drugs:client:bagcrack", function(data)
    -- Check if the progress bar is already active
    if isBaggingCrackActive then 
		lib.notify({
            title = 'Nerd',
            description = 'Stop Spamming nerd',
            type = 'error',
            position = 'bottom'
        })
        return 
    end

    -- Check if the player has the required item 'empty_crack_bag'
    if not ItemCheck('empty_crack_bag') then 
        return 
    end

    -- Set the progress bar status to active
    isBaggingCrackActive = true

    -- Show a progress bar for 4 seconds with the action 'uncuff'
    if not progressbar(Lang.Crack.bagcrack, 4000, 'uncuff') then 
        isBaggingCrackActive = false  -- Reset the status if progress bar fails
        return 
    end

    -- Trigger a server-side event to process bagging crack
    TriggerServerEvent("md-drugs:server:bagcrack", data.data)

    -- Reset the progress bar status after completion
    isBaggingCrackActive = false
end)


