local QBCore = exports['qb-core']:GetCoreObject()
local xtcpress = false


RegisterNetEvent("wrp-drugs:client:setpress", function(type)
    
    if xtcpress then 
        Notify(Lang.xtc.out, 'error')
    else
        local PedCoords = GetEntityCoords(PlayerPedId())
        xtcpress = true
	    progressbar('Setting Press On The Ground', 4000, 'uncuff')
	    local press = CreateObject("bkr_prop_coke_press_01aa", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	    PlaceObjectOnGroundProperly(press)
	
        local options = {
            {   
                icon = "fas fa-eye",
                label = "Make XTC",
                action = function() 
                    TriggerEvent("wrp-drugs:client:XTCMenu", type) 
                end,   
                canInteract = function()
                    if xtcpress then return true end end
            },
            {     
                icon = "fas fa-eye",    
                label = "Pick Up",   
                action = function()  
                    TriggerEvent("wrp-drugs:client:GetPressBack", type, press) 
                end,  
                canInteract = function()        
                    if xtcpress then return true end end 
            },
        }
        local optionsox = {
            {   
                icon = "fas fa-eye",
                label = "Make XTC",
                onSelect = function() 
                    TriggerEvent("wrp-drugs:client:XTCMenu", type) 
                end,   
                canInteract = function()
                    if xtcpress then return true end end
            },
            {     
                icon = "fas fa-eye",    
                label = "Pick Up",   
                onSelect = function()  
                    TriggerEvent("wrp-drugs:client:GetPressBack", type, press) 
                end,  
                canInteract = function()        
                    if xtcpress then return true end end 
            },
        }
        if Config.oxtarget then
            exports.ox_target:addLocalEntity(press,  optionsox)
        else
            exports['qb-target']:AddTargetEntity(press, { options = options})
        end
    end
end)    

RegisterNetEvent("wrp-drugs:client:XTCMenu", function(type)
    lib.registerContext({
        id = 'XTCmenu',
        title = 'XTC Menu',
        options = {
          {
            icon = GetImage('white_xtc'),
            title = 'White XTC',
            description = '1 X Raw XTC',
            event = "wrp-drugs:client:MakeXTC",
            args = { data = type, color = 'white'}
          },
          {
            icon = GetImage('red_xtc'),
            title = 'Red XTC',
            description = '1 X Raw XTC and 1 X Loose Coke',
            event = "wrp-drugs:client:MakeXTC",
            args = { data = type, color = 'red'}
          },
          {
            icon = GetImage('orange_xtc'),
            title = 'Orange XTC',
            description = '1 X Raw XTC and 1 X Heroin Vial',
            event = "wrp-drugs:client:MakeXTC",
            args = { data = type, color = 'orange'}
          },
          {
            icon = GetImage('blue_xtc'),
            title = 'Blue XTC',
            description = '1 X Raw XTC and 1 X Crack Rock',
            event = "wrp-drugs:client:MakeXTC",
            args = { data = type, color = 'blue'}
          },
          
        }
      }) 
      lib.showContext('XTCmenu')
end)

RegisterNetEvent("wrp-drugs:client:GetPressBack", function(type, press)
    if not progressbar('Packing Up The Press', 5000, 'uncuff') then return end
    DeleteObject(press)
    xtcpress = false
    TriggerServerEvent("wrp-drugs:server:getpressback", type)
end)

RegisterNetEvent("wrp-drugs:client:stealisosafrole", function(data) 
    if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
    if not progressbar(Lang.xtc.iso, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:stealisosafrole",data.data)
end)


RegisterNetEvent("wrp-drugs:client:stealmdp2p", function(data) 
    if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
    if not progressbar(Lang.xtc.mdp2p, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:stealmdp2p", data.data)   
end)


RegisterNetEvent("wrp-drugs:client:makingrawxtc", function(data) 
    if not ItemCheck('isosafrole') then return end 
    if not ItemCheck('mdp2p') then return end
    if not progressbar(Lang.xtc.raw, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:makingrawxtc",data.data)
end)

RegisterNetEvent("wrp-drugs:client:MakeXTC", function(data) 
    if not ItemCheck('raw_xtc') then return end
    if not progressbar(Lang.xtc.pressing, 4000, 'uncuff') then return end
    TriggerServerEvent("wrp-drugs:server:makextc",data)
end)

------------------------------------------------------------------ Stamping

RegisterNetEvent("wrp-drugs:client:stampwhite", function(data) 
    lib.registerContext({
    id = 'stampxtc',
    title = 'Stamp XTC Menu',
    options = {
      {
        icon = GetImage('white_xtc'),
        title = 'White XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping White Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("wrp-drugs:server:stampwhite",data.data)
        end      
      },
      {
        icon = GetImage('red_xtc'),
        title = 'Red XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Red Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("wrp-drugs:server:stampred", data.data)
        end
      },
      {
        icon = GetImage('orange_xtc'),
        title = 'Orange XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Orange Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("wrp-drugs:server:stamporange", data.data)
        end,
      },
      {
        icon = GetImage('blue_xtc'),
        title = 'Blue XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Blue Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("wrp-drugs:server:stampblue", data.data)
        end
      },
      
    }
  }) 
  lib.showContext('stampxtc')
end)


RegisterNetEvent("wrp-drugs:client:getsinglepress", function() 
    if not progressbar('Buying Press', 4000, 'uncuff') then return end
	TriggerServerEvent("wrp-drugs:server:buypress")
end)


RegisterNetEvent("wrp-drugs:client:exchangepresses", function(data) 
   if not progressbar('Buying Press', 4000, 'uncuff') then return end
	TriggerServerEvent("wrp-drugs:server:upgradepress", data.data)
end)

RegisterNetEvent("wrp-drugs:client:buypress", function() 
    local img = GetImage('singlepress'),
     lib.registerContext({
	 id = 'buypresses',
	 title = 'Purchase Presses',
	 options = {
        {    title  = 'Single Press',                description  = 'Buy a single press for 20k',                                       icon = img,    event = 'wrp-drugs:client:getsinglepress'},
        {    title  = 'Exchange Single For Dual',    description  = '20 of each unstamped single stack pill and your single press ',    icon = img,    event = 'wrp-drugs:client:exchangepresses', args = {data = 'dual'}},
        {    title  = 'Exchange Dual For Triple',    description  = '50 of each unstamped dual stack pill and your dual press ',        icon = img,    event = 'wrp-drugs:client:exchangepresses', args = {data = 'triple'}},
        {    title  = 'Exchange Triple For Quad',    description  = '150 of each unstamped Triple stack pill and your triple press ',   icon = img,    event = 'wrp-drugs:client:exchangepresses', args = {data = 'quad'}} 
	}	
    })
  lib.showContext('buypresses')	
end)

