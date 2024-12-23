-- Modified loader.lua (https://raw.githubusercontent.com/X7N6Y/Native-forked-/main/loader.lua)

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

-- Removed loadRemoteScript function as we are not loading assets from URLs anymore

if checkWhitelist(game.Players.LocalPlayer.UserId) then
    local uiScript = [[  -- Pasted the deobfuscated UI.lua code here
        local UI = {}

        function UI.create(Type)
            local Object = Instance.new(Type)
            for azure, Value in pairs(UI) do
                if azure ~= "create" and azure ~= "set" then
                    Object[azure] = Value
                end
            end
            return Object
        end

        function UI.set(Property, Value)
            UI[Property] = Value
        end

        return UI
    ]]

    local mainScript = [[ -- Hypothetical Main.lua (replace with your actual Main.lua content)
        print("Main script loaded.")

        local function onPlayerAdded(player)
            if player == game.Players.LocalPlayer then
                local playerGui = player:WaitForChild("PlayerGui")
                
                -- Ensure ScreenGui exists before parenting UI elements to it
                local screenGui = Instance.new("ScreenGui")
                screenGui.Parent = playerGui
                screenGui.Name = "MyScreenGui" 
                
                UI.set("Parent", screenGui) -- Set the Parent property for UI elements
                UI.set("TextSize", 18)
                UI.set("Font", Enum.Font.SourceSansBold)

                local myLabel = UI.create("TextLabel")
                myLabel.Text = "Hello from Main.lua!"
                myLabel.Position = UDim2.new(0.5, -100, 0.5, -50)
                myLabel.Size = UDim2.new(0, 200, 0, 100)
                myLabel.BackgroundTransparency = 0.5
                myLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            end
        end

        game.Players.PlayerAdded:Connect(onPlayerAdded)
    ]]

    if uiScript and mainScript then
        local uiEnv = setupUI()  
        execute(uiScript, uiEnv)

        local mainEnv = getfenv()
        mainEnv.UI = uiEnv
        execute(mainScript, mainEnv)
    else
        warn("Failed to load one or more scripts.")
    end
else
    warn("You are not whitelisted to use this script. Your Roblox ID is: " .. game.Players.LocalPlayer.UserId)
end