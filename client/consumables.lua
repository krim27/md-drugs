local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('wrp-drugs:client:consumedrugs', function(time, effect, anim, progresstext, status, statval, item)
	if not progressbar(progresstext .. QBCore.Shared.Items[item].label .. "!", time, anim ) then return end
	TriggerServerEvent('wrp-drugs:server:removeconsum', item)
	if status == "armor" then 
		TriggerServerEvent('hospital:server:SetArmor', statval)
       	TriggerServerEvent('consumables:server:useArmor')
       	SetPedArmour(PlayerPedId(), statval)
	else	
		TriggerServerEvent('wrp-drugs:server:updatestatus', status, statval)	
	end
	TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
	if effect == "alien" then AlienEffect() elseif effect == "ecstacy" then EcstasyEffect() elseif effect == "meth" then MethBagEffect() elseif effect == "coke" then CokeBaggyEffect() elseif effect == "trevor" then TrevorEffect() else end
	if status == nil then return end
end)

