if Settings.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif Settings.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Settings.Framework == 'vrp' then
    local Proxy = module('vrp','lib/Proxy')
    vRP = Proxy.getInterface('vRP')
elseif Settings.Framework == 'custom' then

end

AnnouncePolice = function(typeNotif)

    if Settings.Framework == 'esx' then

        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer then
                if xPlayer.getJob().name == Settings.PoliceJob then
                    if typeNotif == 1 then
                        TriggerClientEvent("JustRigHeist:policeNotification", xPlayers[i])
                    elseif typeNotif == 2 then
                        TriggerClientEvent("JustRigHeist:policeNotification2", xPlayers[i])
                    elseif typeNotif == 3 then
                        TriggerClientEvent("JustRigHeist:policeNotification3", xPlayers[i])
                    end
                end
            end
        end

    elseif Settings.Framework == 'qb' then
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.type == Settings.PoliceJob then
                if typeNotif == 1 then
                    TriggerClientEvent("JustRigHeist:policeNotification", v)
                elseif typeNotif == 2 then
                    TriggerClientEvent("JustRigHeist:policeNotification2", v)
                elseif typeNotif == 3 then
                    TriggerClientEvent("JustRigHeist:policeNotification3", v)
                end
            end
        end

    elseif Settings.Framework == 'vrp' then
        police = vRP.getUsersByGroup({Settings.PoliceJob})
        for i, v in pairs(police) do
            local thePlayer = vRP.getUserSource({v})
            if typeNotif == 1 then
                TriggerClientEvent("JustRigHeist:policeNotification", thePlayer)
            elseif typeNotif == 2 then
                TriggerClientEvent("JustRigHeist:policeNotification2", thePlayer)
            elseif typeNotif == 3 then
                TriggerClientEvent("JustRigHeist:policeNotification3", thePlayer)
            end            
        end
    end
end

CountPolice = function()
    local xPlayers = ESX.GetPlayers()
    local nr = 0

    if Settings.Framework == 'esx' then
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer then
                if xPlayer.getJob().name == Settings.PoliceJob then
                    nr = nr + 1
                end
            end
        end
    elseif Settings.Framework == 'qb' then
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.type == Settings.PoliceJob then
                nr = nr + 1
            end
        end
    elseif Settings.Framework == 'vrp' then
        police = vRP.getUsersByGroup({Settings.PoliceJob})
        nr = #police
    end

    Wait(20)

    return nr
end

AddItem = function(source, item, count)
    if Settings.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item, count)
    elseif Settings.Framework == 'qb' then
        local ply = QBCore.Functions.GetPlayer(source)
        ply.Functions.AddItem(item, count)
    elseif Settings.Framework == 'vrp' then
        local player = vRP.getUserSource({playerId})
        vRP.giveInventoryItem({player, item, count})
    end
end