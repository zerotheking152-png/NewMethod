local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local throwRemote = ReplicatedStorage:WaitForChild("Fishing_RemoteThrow")
local fishingFolder = ReplicatedStorage:WaitForChild("Fishing")
local toServer = fishingFolder:WaitForChild("ToServer")
local minigameStarted = toServer:WaitForChild("MinigameStarted")
local reelFinished = toServer:WaitForChild("ReelFinished")

local sellRemote = ReplicatedStorage:WaitForChild("Economy"):WaitForChild("ToServer"):WaitForChild("SellUnder")

local sessionID = nil
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if getnamecallmethod() == "FireServer" and self == throwRemote then
        local args = {...}
        if typeof(args[2]) == "string" and #args[2] > 20 then
            sessionID = args[2]
            print("✅ Session ID captured: " .. sessionID)
        end
    end
    return oldNamecall(self, ...)
end))

getgenv().Blati = false
getgenv().ForceSecret = false
getgenv().InfiniteJump = false
getgenv().Noclip = false
getgenv().WalkSpeedValue = 16
getgenv().AutoSell = false
getgenv().SellMode = "Count"
getgenv().SellValue = 10
local fishCaught = 0
local lastSellTime = 0

local humanoid = nil
local function getHumanoid()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        humanoid = player.Character.Humanoid
        return humanoid
    end
    return nil
end
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    getHumanoid()
end)
getHumanoid()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "HamzHub",
    LoadingTitle = "HamzHub Is Loading",
    LoadingSubtitle = "",
    ShowText = "HamzHub",
    Theme = "Default",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = false,
    },
})

local MainTab = Window:CreateTab("MAIN", 4483362458)
local PlayerTab = Window:CreateTab("PLAYER", 4483362458)

MainTab:CreateLabel("MANCING MANUAL 1X BARU IDUPIN BLATI")

local blatiLoop
local function startBlati()
    if blatiLoop then return end
    blatiLoop = task.spawn(function()
        while getgenv().Blati do
            if sessionID and humanoid then
                throwRemote:FireServer(0, sessionID)
                task.wait(0.00001)
                minigameStarted:FireServer(sessionID)
                
                -- FIX DELAY REEL (sesuai update Indo Strike)
                -- Sekarang nunggu dulu sesuai durasi reel biar server nerima
                local reelDuration = math.random(7.8, 11.5) -- delay reel yang aman
                task.wait(reelDuration)
                
                local successArgs = {
                    ["duration"] = reelDuration,
                    ["result"] = "SUCCESS",
                    ["insideRatio"] = 0.8 + (math.random(3, 18) / 100),
                    ["catchType"] = "SECRET",
                    ["isSecret"] = true
                }
                reelFinished:FireServer(successArgs, sessionID)
                fishCaught = fishCaught + 1
                if getgenv().AutoSell and getgenv().SellMode == "Count" and fishCaught >= getgenv().SellValue then
                    if sellRemote then sellRemote:FireServer(800) end
                    fishCaught = 0
                end
                task.wait(0.00001)
            else
                task.wait(0.00001)
            end
        end
    end)
end

MainTab:CreateToggle({
    Name = "BLATI (Instant Fishing)",
    CurrentValue = false,
    Flag = "BlatiFlag",
    Callback = function(Value)
        getgenv().Blati = Value
        if Value then
            startBlati()
            local args = {
	"bd4238ec-6bbc-4523-8c63-a17356e1f130"
}
game:GetService("ReplicatedStorage"):WaitForChild("FishUI"):WaitForChild("ToServer"):WaitForChild("ToggleFavorite"):FireServer(unpack(args))
            local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
            if backpackTool then backpackTool.Parent = player.Character end
        else
            if blatiLoop then task.cancel(blatiLoop) blatiLoop = nil end
        end
    end,
})

local forceSecretLoop
local function startForceSecret()
    if forceSecretLoop then return end
    forceSecretLoop = task.spawn(function()
        while getgenv().ForceSecret do
            if sessionID and humanoid then
                throwRemote:FireServer(0, sessionID)
                task.wait(0.00001)
                minigameStarted:FireServer(sessionID)
                
                -- FIX DELAY REEL (sesuai update Indo Strike)
                -- Sekarang nunggu dulu sesuai durasi reel biar server nerima
                local reelDuration = math.random(7.8, 11.5) -- delay reel yang aman
                task.wait(reelDuration)
                
                local successArgs = {
                    ["duration"] = reelDuration,
                    ["result"] = "SUCCESS",
                    ["insideRatio"] = 0.8 + (math.random(3, 18) / 100),
                    ["catchType"] = "SECRET",
                    ["isSecret"] = true
                }
                reelFinished:FireServer(successArgs, sessionID)
                fishCaught = fishCaught + 1
                if getgenv().AutoSell and getgenv().SellMode == "Count" and fishCaught >= getgenv().SellValue then
                    if sellRemote then sellRemote:FireServer(800) end
                    fishCaught = 0
                end
                task.wait(0.00001)
            else
                task.wait(0.00001)
            end
        end
    end)
end

MainTab:CreateToggle({
    Name = "FORCE SECRET (Instant Fishing Secret)",
    CurrentValue = false,
    Flag = "ForceSecretFlag",
    Callback = function(Value)
        getgenv().ForceSecret = Value
        if Value then
            startForceSecret()
            local args = {
	"bd4238ec-6bbc-4523-8c63-a17356e1f130"
}
game:GetService("ReplicatedStorage"):WaitForChild("FishUI"):WaitForChild("ToServer"):WaitForChild("ToggleFavorite"):FireServer(unpack(args))
            local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
            if backpackTool then backpackTool.Parent = player.Character end
        else
            if forceSecretLoop then task.cancel(forceSecretLoop) forceSecretLoop = nil end
        end
    end,
})

local jumpConnection
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpFlag",
    Callback = function(Value)
        getgenv().InfiniteJump = Value
        if Value then
            if not jumpConnection then
                jumpConnection = UserInputService.JumpRequest:Connect(function()
                    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)
            end
        else
            if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
        end
    end,
})

local noclipConnection
PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipFlag",
    Callback = function(Value)
        getgenv().Noclip = Value
        if Value then
            if not noclipConnection then
                noclipConnection = RunService.Stepped:Connect(function()
                    if getgenv().Noclip and player.Character then
                        for _, v in pairs(player.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end)
            end
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
                if player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = true end
                    end
                end
            end
        end
    end,
})

PlayerTab:CreateInput({
    Name = "WalkSpeed",
    CurrentValue = "16",
    PlaceholderText = "16",
    RemoveTextAfterFocusLost = false,
    Flag = "WalkSpeedFlag",
    Callback = function(Text)
        local value = tonumber(Text)
        if value and humanoid then
            getgenv().WalkSpeedValue = value
            humanoid.WalkSpeed = value
        end
    end,
})

local ShopTab = Window:CreateTab("SHOP", 4483362458)

ShopTab:CreateDropdown({
    Name = "Select Option",
    Options = {"Count", "Second"},
    CurrentOption = {"Count"},
    MultipleOptions = false,
    Flag = "SellModeFlag",
    Callback = function(CurrentOption)
        getgenv().SellMode = CurrentOption[1]
    end,
})

ShopTab:CreateInput({
    Name = "Sell Every (ikan)",
    CurrentValue = "10",
    PlaceholderText = "10",
    RemoveTextAfterFocusLost = false,
    Flag = "SellValueFlag",
    Callback = function(Text)
        local val = tonumber(Text)
        if val and val >= 1 then
            getgenv().SellValue = val
        end
    end,
})

ShopTab:CreateToggle({
    Name = "AUTO SELL",
    CurrentValue = false,
    Flag = "AutoSellFlag",
    Callback = function(Value)
        getgenv().AutoSell = Value
        if Value and getgenv().SellMode == "Second" then
            lastSellTime = tick()
        end
    end,
})

local TeleportTab = Window:CreateTab("TELEPORT", 4483362458)
local teleportSection = TeleportTab:CreateSection("TELEPORT PULAU")

TeleportTab:CreateDropdown({
    Name = "Select Option",
    Options = {"Pulau Kinyis", "Pulau Raja Ampat", "Pulau Wakatobi", "Pulau Bali", "Pulau natuna", "Pulau Banda"},
    CurrentOption = {""},
    MultipleOptions = false,
    Flag = "TeleportFlag",
    Callback = function(CurrentOption)
        local selected = CurrentOption[1]
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if selected == "Pulau Kinyis" then
                hrp.CFrame = CFrame.new(81.8612061, 1006.87341, -818.234985, 0.485841095, -3.1988499e-08, -0.87404716, 9.73005925e-08, 1, 1.74866148e-08, 0.87404716, -9.35410185e-08, 0.485841095)
            elseif selected == "Pulau Raja Ampat" then
                hrp.CFrame = CFrame.new(-1845.45935, 1006.62732, -1579.06555, 0.925677121, -1.99983274e-09, 0.378314495, 9.79888726e-10, 1, 2.88852808e-09, -0.378314495, -2.30313835e-09, 0.925677121)
            elseif selected == "Pulau Wakatobi" then
                hrp.CFrame = CFrame.new(-1399.88684, 1021.17017, 1497.85059, -0.327202201, -4.10665884e-08, 0.944954336, 7.90609747e-08, 1, 7.08346519e-08, -0.944954336, 9.78862644e-08, -0.327202201)
            elseif selected == "Pulau Bali" then
                hrp.CFrame = CFrame.new(989.347717, 1034.922, 1607.38538, 0.00405485556, 4.51565931e-08, 0.999991775, -1.46329642e-08, 1, -4.50976287e-08, -0.999991775, -1.4449979e-08, 0.00405485556)
            elseif selected == "Pulau natuna" then
                hrp.CFrame = CFrame.new(2240.65332, 995.997681, -94.5214081, 0.267383486, 2.81976913e-08, -0.963590205, 1.64388858e-08, 1, 3.38247297e-08, 0.963590205, -2.48845229e-08, 0.267383486)
            elseif selected == "Pulau Banda" then
                hrp.CFrame = CFrame.new(-349.488678, 1000.69397, 178.114243, 0.996432185, 6.81453258e-08, 0.0843971372, -6.44756852e-08, 1, -4.6206285e-08, -0.0843971372, 4.05998684e-08, 0.996432185)
            end
            sessionID = nil
            task.wait(0.5)
            local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
            if backpackTool then
                backpackTool.Parent = player.Character
            end
        end
    end,
})

player.CharacterAdded:Connect(function()
    task.wait(1)
    if humanoid then
        humanoid.WalkSpeed = getgenv().WalkSpeedValue
    end
end)

local VirtualUser = game:GetService("VirtualUser")
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local rodEquipLoop = task.spawn(function()
    while true do
        if (getgenv().Blati or getgenv().ForceSecret) and player.Character then
            local toolInHand = player.Character:FindFirstChildOfClass("Tool")
            if not toolInHand then
                local backpackTool = player.Backpack:FindFirstChildOfClass("Tool")
                if backpackTool then
                    backpackTool.Parent = player.Character
                end
            end
        end
        task.wait(0.5)
    end
end)

local autoSellTimerLoop = task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().AutoSell and getgenv().SellMode == "Second" then
            if tick() - lastSellTime >= getgenv().SellValue then
                if fishCaught > 0 and sellRemote then
                    sellRemote:FireServer(800)
                    fishCaught = 0
                end
                lastSellTime = tick()
            end
        end
    end
end)

print("🎉 HAMZHUB GUI KEREN udah muncul bro! Tab MAIN & PLAYER siap. Cast manual 1x dulu biar Blati nyala. Gas polll 🔥")
