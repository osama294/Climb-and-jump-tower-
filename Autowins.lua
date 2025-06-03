local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ClimbButtonGui"

-- زر ابدأ الصعود (بحجم أصغر)
local startButton = Instance.new("TextButton", gui)
startButton.Size = UDim2.new(0, 50, 0, 50) -- صغر الحجم (50x50 بدل 150x50)
startButton.Position = UDim2.new(0.4, -25, 0.85, 0)
startButton.Text = "🚀"
startButton.TextScaled = true
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Font = Enum.Font.SourceSansBold
startButton.BorderSizePixel = 0

-- زر إيقاف الصعود (بحجم أصغر)
local stopButton = Instance.new("TextButton", gui)
stopButton.Size = UDim2.new(0, 50, 0, 50) -- صغر الحجم
stopButton.Position = UDim2.new(0.6, -25, 0.85, 0)
stopButton.Text = "⏸"
stopButton.TextScaled = true
stopButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.BorderSizePixel = 0

local targetHeight = 14000 -- 14 كم (14000 وحدة تقريباً)
local climbing = false

local runService = game:GetService("RunService")
local connection

local function startClimb()
    if climbing then return end
    climbing = true
    startButton.Text = "🚀"  -- بس السهم أثناء الصعود
    stopButton.Text = "⏸"

    connection = runService.RenderStepped:Connect(function()  
        if not climbing then  
            connection:Disconnect()  
            return  
        end  

        local pos = hrp.Position  
        if pos.Y >= targetHeight then  
            hrp.CFrame = CFrame.new(pos.X, targetHeight, pos.Z)  
            climbing = false  
            startButton.Text = "✅"  -- ممكن تخليها علامة صح لما توصل القمة
            startButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)  
            connection:Disconnect()  
            return  
        end  

        -- تحريك تدريجي للأعلى بسرعة 14,000/60 تقريباً (تقريباً 233 وحدة لكل إطار عند 60 فريم)
        -- بس ممكن تخلي سرعة ثابتة 14,000 / (عدد ثواني الصعود) عشان تكون حركة سلسة
        -- لكن هسّه أبسط طريقة:
        local speedPerFrame = 233  -- 14,000 ÷ 60 (مدة تقريبية 1 ثانية للصعود)
        hrp.CFrame = hrp.CFrame + Vector3.new(0, speedPerFrame, 0)  
    end)
end

local function stopClimb()
    if not climbing then return end
    climbing = false
    startButton.Text = "🚀"
    startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    stopButton.Text = "⏸"
end

startButton.MouseButton1Click:Connect(startClimb)
stopButton.MouseButton1Click:Connect(stopClimb)
