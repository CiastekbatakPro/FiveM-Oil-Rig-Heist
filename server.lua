local heist = {}


RegisterServerEvent("JustHeist:startheist")
AddEventHandler("JustHeist:startheist", function()
    heist[source] = 1
end)

RegisterServerEvent("JustHeist:checkifstarted")
AddEventHandler("JustHeist:checkifstarted", function()
    TriggerClientEvent("JustHeist:loadifstarted", source, heist)
    TriggerClientEvent("JustHeist:loadPolice", source, CountPolice())
end)

RegisterServerEvent("JustRigHeist:stopHeist")
AddEventHandler("JustRigHeist:stopHeist", function()
    heist = {}
end)

RegisterServerEvent("JustRigHeist:pdAnnounce")
AddEventHandler("JustRigHeist:pdAnnounce", function(typeNotif)
    AnnouncePolice(typeNotif)
end)

RegisterServerEvent("JustRigHeist:complete")
AddEventHandler("JustRigHeist:complete", function()
    heist = {}
    for i = 1, #Settings.Items do
        AddItem(source, Settings.Items[i].name, Settings.Items[i].count)
    end
end)