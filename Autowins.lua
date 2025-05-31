local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- واجهة الزر
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ClimbButtonGui"

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0.5, -110, 0.85, 0)
button.Text = "🚀 ابدأ الصعود التدريجي"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.BorderSizePixel = 0

-- إعدادات الصعود
local targetHeight = 14299000 -- 14,299 كم
local climbSpeed = 3000 -- سرعة الصعود: 3K
local climbing = false

-- وظيفة الصعود
local function startClimb()
    if climbing then return end
    climbing = true
    button.Text = "⬆️ جاري الصعود..."

    local runService = game:GetService("RunService")

    local connection
    connection = runService.RenderStepped:Connect(function()
        if not climbing then
            connection:Disconnect()
            return
        end

        local currentY = hrp.Position.Y
        if currentY >= targetHeight then
            climbing = false
            button.Text = "✅ وصلت للقمة"
            button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            connection:Disconnect()
            return
        end

        -- الصعود التدريجي السلس
        hrp.CFrame = hrp.CFrame + Vector3.new(0, climbSpeed, 0)
    end)
end

-- الضغط على الزر
button.MouseButton1Click:Connect(startClimb)
