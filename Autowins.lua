local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ClimbButtonGui"

local startButton = Instance.new("TextButton", gui)
startButton.Size = UDim2.new(0, 150, 0, 50)
startButton.Position = UDim2.new(0.4, -75, 0.85, 0)
startButton.Text = "Start Climb"
startButton.TextScaled = true
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Font = Enum.Font.SourceSansBold
startButton.BorderSizePixel = 0

local stopButton = Instance.new("TextButton", gui)
stopButton.Size = UDim2.new(0, 150, 0, 50)
stopButton.Position = UDim2.new(0.6, -75, 0.85, 0)
stopButton.Text = "Stop"
stopButton.TextScaled = true
stopButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.BorderSizePixel = 0

local targetHeight = 8280
local climbing = false

local runService = game:GetService("RunService")
local connection

local function startClimb()
    if climbing then return end
    climbing = true
    startButton.Text = "Climbing..."
    stopButton.Text = "Stop"

    connection = runService.RenderStepped:Connect(function()
        if not climbing then
            connection:Disconnect()
            return
        end

        local pos = hrp.Position
        if pos.Y >= targetHeight then
            hrp.CFrame = CFrame.new(pos.X, targetHeight, pos.Z)
            climbing = false
            startButton.Text = "Reached Top"
            startButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            connection:Disconnect()
            return
        end

        -- Increased speed: 10 * normal climb speed (10 units/frame)
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 100, 0)
    end)
end

local function stopClimb()
    if not climbing then return end
    climbing = false
    startButton.Text = "Start Climb"
    startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    stopButton.Text = "Stop"
end

startButton.MouseButton1Click:Connect(startClimb)
stopButton.MouseButton1Click:Connect(stopClimb)
