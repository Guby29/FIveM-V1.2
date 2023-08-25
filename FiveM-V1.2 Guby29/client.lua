--- Created By Guby29 ---

------------------ message --------------------------------------

local function sendNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
end

RegisterCommand("message", function(source, args, rawCommand)
    if #args < 1 then
        sendNotification("~r~Vous devez préciser un message ! ")
        return
    end

    local final_Message = ""

    for k, v in pairs(args) do
        final_Message = final_Message .. v .. " "
    end

    sendNotification("Votre message est: ~g~" .. final_Message)
end, false)

------------------------------------------------ Health -------------------------------------------------

RegisterCommand("heal", function(source, args, rawCommand)
    local ped = PlayerPedId()

    sendNotification("~g~ ⚕ Vous avez été soigné ⚕")

    local health = GetEntityHealth(ped)


    local finalHealth = health / 2.0

    SetEntityHealth(ped, finalHealth)
end, false)


RegisterCommand("kill", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local health = GetEntityHealth(ped)
    sendNotification("~r~ ☠ Vous êtes mort ☠ ")
    local finalHealth = health / 2

    ApplyDamageToPed(ped, health / 2, false)

    health = GetEntityHealth(ped)
end, false)


RegisterCommand("vie", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local health = GetEntityHealth(ped)
    sendNotification("~r~ ⚠ Votre vie a été réduite de moitié ⚠")
    local finalHealth = health / 2

    ApplyDamageToPed(ped, 70, false)

    health = GetEntityHealth(ped)
end, false)


---------------------------------------------- Weapons -------------------------------------------------------

--- give combat pistol ---

RegisterCommand("give_combatpistol", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local weapon = "WEAPON_COMBATPISTOL"
    local weaponHash = GetHashKey(weapon)

    GiveWeaponToPed(ped, weaponHash, 100, false, true)

    sendNotification("~b~ Vous avez été give !")
end, false)

--- give carbine rifle ---

RegisterCommand("give_carbinerifle", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local weapon = "WEAPON_CARBINERIFLE"
    local weaponHash = GetHashKey(weapon)

    GiveWeaponToPed(ped, weaponHash, 100, false, true)

    sendNotification("~b~ Vous avez été give !")
end, false)

--- give all weapons ---

RegisterCommand("give_all_weapon", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local weapon = "WEAPON_CARBINERIFLE"
    local weapon2 = "WEAPON_COMBATPISTOL"
    local weaponHash2 = GetHashKey(weapon2)
    local weaponHash = GetHashKey(weapon)

    GiveWeaponToPed(ped, weaponHash, 100, false, true)
    GiveWeaponToPed(ped, weaponHash2, 260, false, true)

    sendNotification("~b~ Vous avez été give !")
end, false)

--- remove the combat pistol ---

RegisterCommand("remove_weapon", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local weapon = "WEAPON_COMBATPISTOL"
    local weaponHash = GetHashKey(weapon)

    RemoveWeaponFromPed(ped, weaponHash)

    sendNotification("~r~ ⚠ Votre arme a été supprimé ⚠")
end, false)

--- remove all weapons ---

RegisterCommand("remove_all_weapon", function(source, args, rawCommand)
    local ped = PlayerPedId()

    RemoveAllPedWeapons(ped, p1)

    sendNotification("~r~ ⚠ Vos armes ont été supprimées ⚠")
end, false)

-------------- coords ------------------------------

--- know his coordonates ---

RegisterCommand("coords", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    sendNotification("~r~x = " .. coords.x .. ",~b~ y = " .. coords.y .. ",~g~ z = " .. coords.z)
end, false)

--- teleportation ---

-- -1463.26, 165.58, 55.89 --

possible_tlpts = {
    vector3(-1463.26, 165.58, 55.89),
    vector3(1626.6, 6657.15, 23.62),
    vector3(3054, 2106, 1),
    vector3(-801, 176, 72),
}

RegisterCommand("tlpt", function(source, args, rawCommand)
    local ped = PlayerPedId()

    local dest = possible_tlpts[math.random(1, #possible_tlpts)]

    SetEntityCoords(ped, dest.x, dest.y, dest.z, false, false, false, false)

    sendNotification("~g~ ⚠ Vous avez été téléporté ")
end, false)

------------------------------------- God Mod ----------------------------------------------

RegisterCommand("god_on", function(source, args, rawCommand)
    local ped = PlayerPedId()
    SetEntityInvincible(ped, true)
    sendNotification("~r~ ⚠ Vous êtes invincible !")
end, false)

RegisterCommand("god_off", function(source, args, rawCommand)
    local ped = PlayerPedId()
    SetEntityInvincible(ped, false)
    sendNotification("~r~ ⚠ Vous n'êtes plus invincible ")
end, false)

----------------------- Vehicle Spawn ------------------------------------------------------

RegisterCommand("car", function(source, args, rawCommand)
    if args[1] == nil then
        sendNotification("~r~ ⚠ Merci de définir le model de vehicule")
        return
    end

    if not IsModelValid(args[1]) then
        sendNotification("~r~ ⚠ Modèle invalid")
        return
    end

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    local VehicleName = args[1]
    local vehicleHash = GetHashKey(VehicleName)

    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Citizen.Wait(10)
    end

    SetVehicleEngineOn(vehicle, true, true, false)

    local vehicle = CreateVehicle(vehicleHash, pos.x, pos.y, pos.z, heading, false, false)

    TaskWarpPedIntoVehicle(ped, vehicle, -1)
end, false)
