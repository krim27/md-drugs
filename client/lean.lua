local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	local current = "s_m_m_doctor_01"
	lib.requestModel(current, Config.RequestModelTime)
	local SyrupLocation = CreatePed(0, current,Config.SyrupVendor.x,Config.SyrupVendor.y,Config.SyrupVendor.z-1, Config.SyrupVendor.w, false, false)
    FreezeEntityPosition(SyrupLocation, true)
    SetEntityInvincible(SyrupLocation, true)
    local options = {
        { type = "client", label = "Get Task", icon = "fas fa-eye", event = "wrp-drugs:client:getsyruplocationtobuy", distance = 2.0},
    }
    if Config.oxtarget then
        exports.interact:AddLocalEntityInteraction({
            entity = SyrupLocation,
            name = 'SyrupLocation', -- optional
            id = 'SyrupLocation', -- needed for removing interactions
            distance = 3.0, -- optional
            interactDst = 1.0, -- optional
            ignoreLos = false, -- optional ignores line of sight
            offset = vec3(0.0, 0.0, 0.0), -- optional
            options = options
        })
        --exports.ox_target:addLocalEntity(SyrupLocation, options)
    else
	    exports['qb-target']:AddTargetEntity(SyrupLocation, { options = options, distance = 2.0})
    end    
end)


RegisterNetEvent("wrp-drugs:client:getsyruplocationtobuy", function() 
Notify(Lang.Lean.marked, "success")
SpawnCarPedChase()
end)