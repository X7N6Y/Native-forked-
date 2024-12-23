-- Deobfuscated loader.lua from Native-lab/Native with Roblox ID whitelist

local function execute(source, env)
    local f = loadstring(source)
    if not f then return nil end
    setfenv(f, env)
    return f()
end

local function checkWhitelist(userId)
    local whitelist = {
        [123456789] = true,  -- Replace with the Roblox ID of the first whitelisted user
        [987654321] = true,  -- Replace with the Roblox ID of the second whitelisted user
        [7347356224] = true, -- Your Roblox ID added
        -- ... Add more whitelisted user IDs here
    }
    return whitelist[userId]
end

local function loadRemoteScript(url)
    local response = game:HttpGet(url)
    if response then
        return response
    else
        warn("Failed to load script from: " .. url)
        return nil
    end
end

if checkWhitelist(game.Players.LocalPlayer.UserId) then
    local uiScript = loadRemoteScript("https://raw.githubusercontent.com/Native-lab/Native/main/Library/UI.lua")
    local mainScript = loadRemoteScript("https://raw.githubusercontent.com/Native-lab/Native/main/Main.lua") -- Assuming you want to load Main.lua

    if uiScript and mainScript then
        local uiEnv = setupUI()
        execute(uiScript, uiEnv)

        local mainEnv = getfenv()
        mainEnv.UI = uiEnv -- Make the UI library available to Main.lua
        execute(mainScript, mainEnv)
    else
        warn("Failed to load one or more scripts.")
    end
else
    warn("You are not whitelisted to use this script. Your Roblox ID is: " .. game.Players.LocalPlayer.UserId)
end