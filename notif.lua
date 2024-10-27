-- ████████╗██╗███████╗██╗ ██████╗ ██╗   ██╗███████╗███████╗
-- ╚══██╔══╝██║██╔════╝██║██╔═══██╗██║   ██║██╔════╝██╔════╝
--    ██║   ██║█████╗  ██║██║   ██║██║   ██║███████╗█████╗  
--    ██║   ██║██╔══╝  ██║██║   ██║██║   ██║╚════██║██╔══╝  
--    ██║   ██║██║     ██║╚██████╔╝╚██████╔╝███████║███████╗
--    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝

ESX = exports["es_extended"]:getSharedObject()

math.randomseed(GetGameTimer())

local notifications = {}

local notificationsEnabled = true

function Send(message, couleurProgress, timeout, position, progress, theme, exitAnim, pin_id)
    if not notificationsEnabled then
        return
    end
    if type(message) == 'table' then
        SendCustom(message)
        return
    end

    if message == nil then
        return PrintError("^1ERREUR BULLETIN : ^7Le message de notification est nul")
    end

    message = tostring(message)

    if not tonumber(timeout) then
        timeout = Config.Timeout
    end
    
    if position == nil then
        position = Config.Position
    end
    
    if progress == nil then
        progress = Config.Progress
    end

    local id = nil
    local duplicateID = DuplicateCheck(message)

    if duplicateID then
        id = duplicateID
    else
        id = uuid(message)
        notifications[id] = message
    end
    
    AddNotification({
        duplicate   = duplicateID ~= false,
        id          = id,
        type        = "standard",
        message     = message,
        couleurProgress = couleurProgress,
        timeout     = timeout,
        position    = position,
        progress    = progress,
        theme       = theme,
        exitAnim    = exitAnim,
        pin_id      = pin_id,
    })        
end

RegisterCommand("+notifOff", function()
    notificationsEnabled = false
    print('OFF')
end)

RegisterCommand("+notifOn", function()
    notificationsEnabled = true
end)

local AdvancednotificationsEnabled = true
function SendAdvanced(message, title, subject, couleurProgress, icon, timeout, position, progress, theme, exitAnim, pin_id)
    if not AdvancednotificationsEnabled then
        return
    end
    if type(message) == 'table' then
        SendCustom(message, true)
        return
    end

    if message == nil then
        return PrintError("^1ERREUR BULLETIN : ^7Le message de notification est nul")
    end

    message = tostring(message)

    if title == nil then
        return PrintError("^1ERREUR BULLETIN : ^7Le titre de la notification est nul")
    end
    
    if subject == nil then
        return PrintError("^1ERREUR BULLETIN : ^7Le sujet de la notification est nul")
    end    

    if not tonumber(timeout) then
        timeout = Config.Timeout
    end
    
    if position == nil then
        position = Config.Position
    end
    
    if progress == nil then
        progress = Config.Progress
    end  

    local id = nil
    local duplicateID = DuplicateCheck(message)

    if duplicateID then
        id = duplicateID
    else
        id = uuid(message)
        notifications[id] = message
    end
    print(couleurProgress)
    AddNotification({
        duplicate   = duplicateID ~= false,
        id          = id,
        type        = "advanced",
        message     = message,
        title       = title,
        subject     = subject,
        couleurProgress = couleurProgress,
        icon        = Config.Pictures[icon],
        timeout     = timeout,
        position    = position,
        progress    = progress,
    })
end

RegisterCommand("+notifAdvOff", function()
    AdvancednotificationsEnabled = false
end)

RegisterCommand("+notifAdvOn", function()
    AdvancednotificationsEnabled = true
end)


function SendPinned(options)
    local pin_id = uuid()
    options.pin_id = pin_id

    SendCustom(options)

    return pin_id
end


function Unpin(pinned)
    SendNUIMessage({
        type = 'unpin',
        pin_id = pinned
    })
end

function UpdatePinned(pinned, options)
    if options.icon ~= nil then
        options.icon = Config.Pictures[options.icon]
    end

    SendNUIMessage({
        type = 'update_pinned',
        pin_id = pinned,
        options = options
    })
end

function SendCustom(options, advanced)
    if type(options) ~= 'table' then
        error("ERREUR BULLETIN : les options passées à `SendCustom` doivent être une table")
    end
    if options.type == "standard" or options.type == nil and not advanced then
        Send(options.message, options.timeout, options.position, options.progress, options.theme, options.exitAnim, options.pin_id)
    elseif advanced ~= nil or options.type == "advanced" then
        SendAdvanced(options.message, options.title, options.subject, options.icon, options.timeout, options.position, options.progress, options.theme, options.exitAnim, options.pin_id)
    end
end

function AddNotification(data)
    data.config = Config
    SendNUIMessage(data)
end

function PrintError(message)
    local s = string.rep("=", string.len(message))
    print(s)
    print(message)
    print(s)  
end

function DuplicateCheck(message)
    for id, msg in pairs(notifications) do
        if msg == message then
            return id
        end
    end

    return false
end

function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

RegisterNetEvent("TFS_notify:send")
AddEventHandler("TFS_notify:send", Send)

RegisterNetEvent("TFS_notify:sendAdvanced")
AddEventHandler("TFS_notify:sendAdvanced", SendAdvanced)

RegisterNUICallback("nui_removed", function(data, cb)
    notifications[data.id] = nil
    cb('ok')
end)

RegisterCommand('2', function()
    ESX.ShowNotification("Le Los Santos Custom est ~g~ouvert", "#5fa05d")
end)

RegisterCommand('3', function()
    ESX.ShowNotification("Vous êtes mort !", "#FF0000")
end)

-- ████████╗██╗███████╗██╗ ██████╗ ██╗   ██╗███████╗███████╗
-- ╚══██╔══╝██║██╔════╝██║██╔═══██╗██║   ██║██╔════╝██╔════╝
--    ██║   ██║█████╗  ██║██║   ██║██║   ██║███████╗█████╗  
--    ██║   ██║██╔══╝  ██║██║   ██║██║   ██║╚════██║██╔══╝  
--    ██║   ██║██║     ██║╚██████╔╝╚██████╔╝███████║███████╗
--    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
