local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('esx_status:getStatus', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        TriggerEvent('esx_status:getStatus', source, 'hunger', function(hungerStatus)
            TriggerEvent('esx_status:getStatus', source, 'thirst', function(thirstStatus)
                local status = {
                    hunger = hungerStatus and hungerStatus.percent or 100,
                    thirst = thirstStatus and thirstStatus.percent or 100
                }
                cb(status)
            end)
        end)
    else
        cb({hunger = 100, thirst = 100})
    end
end)

RegisterServerEvent('pm_growlsound:notifyNearbyPlayers')
AddEventHandler('pm_growlsound:notifyNearbyPlayers', function()
    local sourcePlayer = source
    local xPlayers = ESX.GetPlayers()
    local coords = GetEntityCoords(GetPlayerPed(sourcePlayer))

    for _, playerId in ipairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local targetCoords = GetEntityCoords(GetPlayerPed(playerId))

        if #(coords - targetCoords) < 8.0 then -- Adjust the distance as needed
            TriggerClientEvent('pm_growlsound:playSound', playerId)
        end
    end
end)
