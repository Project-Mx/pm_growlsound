ESX = exports['es_extended']:getSharedObject()

local function playStomachGrowl()
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = Config.SoundPath,
        transactionVolume = Config.volume,
    })
end


RegisterNetEvent('pm_growlsound:playSound')
AddEventHandler('pm_growlsound:playSound', function()
    playStomachGrowl()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) -- Check every 10 seconds

        ESX.TriggerServerCallback('esx_status:getStatus', function(status)
            local hunger = status.hunger
            local thirst = status.thirst

            if hunger < Config.HungerThreshold or thirst < Config.ThirstThreshold then
                playStomachGrowl()
                TriggerServerEvent('pm_growlsound:notifyNearbyPlayers')
            end
        end)
    end
end)
