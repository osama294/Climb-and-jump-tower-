local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

hrp.CFrame = hrp.CFrame + Vector3.new(0, 14000, 0)

game.StarterGui:SetCore("SendNotification", {
    Title = "تم التليبورت!";
    Text = "وصلت إلى ارتفاع 14,000 متر 🚀";
    Duration = 5;
})
