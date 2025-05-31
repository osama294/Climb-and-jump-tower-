local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- تعديل السرعة إلى 20,000,000,000
humanoid.WalkSpeed = 20000000000

-- تنبيه
game.StarterGui:SetCore("SendNotification", {
    Title = "السرعة مفعلة!",
    Text = "تم تعيين سرعة اللاعب إلى 20 مليار 🚀",
    Duration = 5;
})
