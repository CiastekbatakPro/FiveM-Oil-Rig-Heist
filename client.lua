local trenutnekorde, blipa, blipRobbery
local timer = 0
local pdCount = 0
local robb = false
local inMenu = false
local startedJob = false
local stvorenblip = false
local sendednotif = false
local heist = {}
local idiots = {}
local Goons = {}

RegisterNetEvent("JustHeist:loadifstarted")
AddEventHandler("JustHeist:loadifstarted", function(tab)
    heist = tab
end)

RegisterNetEvent("JustHeist:loadPolice")
AddEventHandler("JustHeist:loadPolice", function(c)
    pdCount = tonumber(c)
end)

RegisterNetEvent("JustRigHeist:policeNotification")
AddEventHandler("JustRigHeist:policeNotification", function()
    blipRobbery = AddBlipForCoord(Settings.RobbLocation)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 0.6)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
    Notify(Settings.Strings['police_message'])
end)

RegisterNetEvent("JustRigHeist:policeNotification2")
AddEventHandler("JustRigHeist:policeNotification2", function()
    RemoveBlip(blipRobbery)
    Notify(Settings.Strings['robb_ended'])
end)

RegisterNetEvent("JustRigHeist:policeNotification3")
AddEventHandler("JustRigHeist:policeNotification3", function()
    RemoveBlip(blipRobbery)
    Notify(Settings.Strings['robb_stopped'])
end)

CreateThread(function()
    Wait(5000)
    local ped_hash = GetHashKey(Settings.BossSettings.bossPed)
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end	
    BossNPC = CreatePed(1, ped_hash,Settings.BossSettings.bossCoords, Settings.BossSettings.bossHeading, false, true)
    SetBlockingOfNonTemporaryEvents(BossNPC, true)
    SetPedDiesWhenInjured(BossNPC, false)
    SetPedCanPlayAmbientAnims(BossNPC, true)
    SetPedCanRagdollFromPlayerImpact(BossNPC, false)
    SetEntityInvincible(BossNPC, true)
    FreezeEntityPosition(BossNPC, true)
end)


if Settings.Ox.target == true then
    exports.ox_target:addModel(Settings.BossSettings.bossPed, {
        label = 'Rig Heist',
        distance = 5.0,
        onSelect = function()
            SendNUIMessage({ 
                message = 'showUI'
            })
            SetNuiFocus(true, true)
        end
    })
else
    CreateThread(function()
        while true do
            Wait(0)
            local sleep = true
            local playerPed = PlayerPedId()
            local playercoords = GetEntityCoords(PlayerPedId())
            local distance = #(Settings.BossSettings.bossCoords - playercoords)
    
            if distance < 5 then
                sleep = false
                HelpNotify(Settings.Strings['press_e_to_talk'])
                if IsControlJustPressed(0, 38) then
                    SendNUIMessage({ 
                        message = 'showUI'
                    })
                    SetNuiFocus(true, true)
                end
            end
    
            if sleep then
                Wait(2000)
            end
        end
    end)
end



RegisterNUICallback("startJob", function()
    TriggerServerEvent("JustHeist:checkifstarted")
    Wait(200)
    if not next(heist) then
        if pdCount >= Settings.MinimalPolice then
            local playerPed = PlayerPedId()
            trenutnekorde = GetEntityCoords(PlayerPedId())
            local player = PlayerPedId()
            local anim_lib = "missheistdockssetup1ig_5@base"
            local anim_dict = "workers_talking_base_dockworker1"
            RequestAnimDict(anim_lib)
            while not HasAnimDictLoaded(anim_lib) do
                Citizen.Wait(0)
            end
            FreezeEntityPosition(playerPed, true)
            TaskPlayAnim(player,anim_lib,anim_dict,1.0,0.5,-1,31,1.0,0,0)
            ProggressBar(Settings.Strings['talking'], 7000)
            ClearPedTasks(player)
            ClearPedSecondaryTask(player)
            DoScreenFadeOut(2000)
            while not IsScreenFadedOut() do
                Wait(100)
            end
            DoScreenFadeIn(2000)
            FreezeEntityPosition(playerPed, true)
            SetEntityVisible(playerPed, false)
            SetEntityCoords(playerPed, vector3(-2677.93, 6654.56, 36.72))
            inMenu = true 
        else
            Notify(Settings.Strings['no_cops'])
        end
    else
        Notify(Settings.Strings['already_robbing'])
    end
end)

RegisterNUICallback("closeMenu", function()
    SetNuiFocus(false, false)
end)


CreateThread(function()
    while true do
        Wait(0)
        local sleep = true
        local playerPed = PlayerPedId()

        if inMenu == true then
            sleep = false
            HelpNotification("~INPUT_MP_TEXT_CHAT_TEAM~ " ..Settings.Strings['to_accept'] .. "\n~INPUT_PUSH_TO_TALK~ " ..Settings.Strings['to_deny'])
            scrText(Settings.Strings['info'])
            if IsControlJustPressed(0,249) then
                FreezeEntityPosition(playerPed, false)
                SetEntityVisible(playerPed, true)
                SetEntityCoords(playerPed, trenutnekorde)
                Notify(Settings.Strings['deny'])
                inMenu = false
            elseif IsControlJustPressed(0, 246) then
                DoScreenFadeOut(2000)
                while not IsScreenFadedOut() do
                    Wait(100)
                end
                Wait(500)

                spawnSecurities()

                Wait(500)

                DoScreenFadeIn(2000)
                FreezeEntityPosition(playerPed, false)
                SetEntityVisible(playerPed, true)
                SetEntityCoords(playerPed, trenutnekorde)
                Notify(Settings.Strings['accept'])
                TriggerServerEvent("JustHeist:startheist")
                startedJob = true
                -- start mission
                inMenu = false
            end
        end


        if sleep then
            Wait(2000)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local sleep = true
        local playerPed = PlayerPedId()
        if startedJob == true then
            sleep = false
            
            if stvorenblip == false then
                blipa = AddBlipForCoord(Settings.RobbLocation)
                SetBlipSprite(blipa, 84)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Settings.BlipText)
                EndTextCommandSetBlipName(blipa)  
                SetBlipScale(blipa, 0.6)
                SetBlipColour(blipa, 1)
                SetBlipAlpha(blipa, 255)
                SetBlipRoute(blipa, true)
                Notify(Settings.Strings['located'])
                stvorenblip = true
            end
            
            if IsPedDeadOrDying(playerPed) then
                TriggerServerEvent("JustRigHeist:stopHeist")
                Notify(Settings.Strings['dead'])
                for i = 1, #idiots, 1 do
                    DeletePed(idiots[i])
                end
                RemoveBlip(blipa)
                blipa = nil
                startedJob = false
                trenutnekorde = nil
                inMenu = false
                stvorenblip = false
                sendednotif = false
                heist = {}
                idiots = {}
                Goons = {}
                robb = false
            end

            if checkDeadPeds() == true then
                if sendednotif == false then
                    sendednotif = true
                    Notify(Settings.Strings['all_peds_dead'])
                end

                local distance = #(GetEntityCoords(playerPed) - Settings.RobbLocation)                
                if distance < 5 and robb == false then
                    DrawMarker(29, Settings.RobbLocation, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 50, false, true, 2, nil, nil, false)
                    HelpNotification(Settings.Strings['press_e_to_robb'])
                    if IsControlJustPressed(0, 38) then
                        Notify(Settings.Strings['started_robbery'])
                        timer = Settings.RobbTime
                        robb = true
                        TriggerServerEvent("JustRigHeist:pdAnnounce", 1)
                    end
                end

                if robb == true then

                    if distance > 50 then
                        TriggerServerEvent("JustRigHeist:stopHeist")
                        Notify(Settings.Strings['too_far'])
                        for i = 1, #idiots, 1 do
                            DeletePed(idiots[i])
                        end
                        RemoveBlip(blipa)
                        blipa = nil
                        startedJob = false
                        trenutnekorde = nil
                        inMenu = false
                        stvorenblip = false
                        sendednotif = false
                        heist = {}
                        idiots = {}
                        Goons = {}
                        robb = false
                        TriggerServerEvent("JustRigHeist:pdAnnounce", 3)
                    end

                    if timer > 0 then
                        robText(Settings.Strings['time_left'] .. ' ~r~' .. timer .. '~w~s.')
                    end

                    if timer == 0 then
                        TriggerServerEvent("JustRigHeist:pdAnnounce", 2)
                        TriggerServerEvent("JustRigHeist:complete")
                        Notify(Settings.Strings['complete'])
                        for i = 1, #idiots, 1 do
                            DeletePed(idiots[i])
                        end
                        RemoveBlip(blipa)
                        blipa = nil
                        startedJob = false
                        trenutnekorde = nil
                        inMenu = false
                        stvorenblip = false
                        sendednotif = false
                        heist = {}
                        idiots = {}
                        Goons = {}
                        robb = false
                        aktovka = true
                    end
                end
            end

        end

        if sleep then
            Wait(2000)
        end

    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        if timer > 0 then
            timer = timer - 1
        end
    end
end)


function checkDeadPeds()
    local kita = true

    for i = 1, #idiots do
        if not IsPedDeadOrDying(idiots[i]) then
            kita = false
        end
    end

    return kita
end

function spawnSecurities()
    local playerPed = PlayerPedId()
    SetPedRelationshipGroupHash(playerPed, GetHashKey("PLAYER"))
    AddRelationshipGroup('JobNPCs')

    
    for i = 1, #Settings.Securities, 1 do
        local ped_hash = GetHashKey(Settings.Securities[i].model)
        RequestModel(ped_hash)
        while not HasModelLoaded(ped_hash) do
            Citizen.Wait(1)
        end	

        Goons[i] = CreatePed(4, GetHashKey(Settings.Securities[i].model), Settings.Securities[i].coords, Settings.Securities[i].heading, false, true)
        table.insert(idiots, Goons[i])
        NetworkRegisterEntityAsNetworked(Goons[i])
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(Goons[i]), true)
        SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(Goons[i]), true)
        TaskGuardCurrentPosition(Goons[i], 15.0, 15.0, 0)
        SetPedCanSwitchWeapon(Goons[i], true)
        SetPedArmour(Goons[i], 100)
        SetPedAccuracy(Goons[i], 20)
        SetEntityInvincible(Goons[i], false)
        SetEntityVisible(Goons[i], true)
        SetEntityAsMissionEntity(Goons[i])
        GiveWeaponToPed(Goons[i], GetHashKey(Settings.Securities[i].gun), 1, false, false)
        SetPedDropsWeaponsWhenDead(Goons[i], false)
        SetPedCombatAttributes(Goons[i], false)
        SetPedFleeAttributes(Goons[i], 0, false)
        SetPedCombatAttributes(Goons[i], 16, true)
        SetPedCombatAttributes(Goons[i], 46, true)
        SetPedCombatAttributes(Goons[i], 26, true)
        SetPedSeeingRange(Goons[i], 75.0)
        SetPedHearingRange(Goons[i], 50.0)
        SetPedEnableWeaponBlocking(Goons[i], true)
        SetPedRelationshipGroupHash(Goons[i], GetHashKey("JobNPCs"))
    end

end


function HelpNotification(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function scrText(text)
    local x = 0.5
    local y = 0.9
    local scale = 0.5
    local red = 255
    local green = 255
    local blue = 255
    local alpha = 255
    local font = 0 

    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(red, green, blue, alpha)
    SetTextCentre(true)

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function robText(text)
    local x = 0.5
    local y = 0.93
    local scale = 0.3
    local red = 255
    local green = 255
    local blue = 255
    local alpha = 255
    local font = 0 

    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(red, green, blue, alpha)
    SetTextCentre(true)

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
