if Settings.Framework == 'esx' then
  ESX = exports['es_extended']:getSharedObject()
elseif Settings.Framework == 'qb' then
  QBCore = exports['qb-core']:GetCoreObject()
elseif Settings.Framework == 'vrp' then
  local Proxy = module('vrp','lib/Proxy')
  vRP = Proxy.getInterface('vRP')
  function vRPShowHelpNotif(str)
      SetTextComponentFormat("STRING")
      AddTextComponentString(str)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
elseif Settings.Framework == 'custom' then

end

Notify = function(text)

  if Settings.Framework == 'esx' then
      ESX.ShowNotification(text)
  elseif Settings.Framework == 'qb' then
      QBCore.Functions.Notify(text)
  elseif Settings.Framework == 'vrp' then
      vRP.notify({text})
  end

end

HelpNotify = function(text)
  if Settings.Framework == 'esx' then
      ESX.ShowHelpNotification(text)
  elseif Settings.Framework == 'qb' then
      exports['qb-core']:DrawText(text)
  elseif Settings.Framework == 'vrp' then
      vRPShowHelpNotif(text)
  end
end

ProggressBar = function(text, time)
    exports.rprogress:Start(text, time)
end