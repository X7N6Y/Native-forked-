-- Deobfuscated loader.lua from Native-lab/Native

local function execute(source, env)
    local f = loadstring(source)
    if not f then return nil end
    setfenv(f, env)
    return f()
end

local function checkWhitelist(playerName)
    local whitelist = {
        ["Player1"] = true,
        ["Player2"] = true,
        -- ... Add more whitelisted players here
    }
    return whitelist[playerName]
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

if checkWhitelist(game.Players.LocalPlayer.Name) then
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
    warn("You are not whitelisted to use this script.")
end