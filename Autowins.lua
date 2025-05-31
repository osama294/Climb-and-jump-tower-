-- إعدادات اللاعب
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- واجهة GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton", ScreenGui)

ScreenGui.Name = "ClimbLoopGUI"
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "🚀 بدء الصعود 10 مرات"
button.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true
button.Font = Enum.Font.SourceSansBold
button.BorderSizePixel = 0
button.Visible = true

-- المنطق الرئيسي
local runService = game:GetService("RunService")
local climbing = false
local climbCount = 0
local maxClimbs = 10
local isFalling = false

local function climb()
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 10000, 0)
        isFalling = true
    end
end

-- التحقق من الهبوط
local function monitorFall()
    runService.Heartbeat:Connect(function()
        if climbing and isFalling and hrp.Velocity.Y == 0 then
            isFalling = false
            climbCount += 1
            if climbCount < maxClimbs then
                wait(1)
                climb()
            else
                climbing = false
                button.Text = "✅ انتهى الصعود"
                button.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
            end
        end
    end)
end

-- عند الضغط على الزر
button.MouseButton1Click:Connect(function()
    if not climbing then
        climbCount = 0
        climbing = true
        button.Text = "⏳ جاري التنفيذ..."
        button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        wait(1)
        climb()
        monitorFall()
    end
end)
