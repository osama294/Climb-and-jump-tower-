local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- تأخير بسيط لضمان تحميل الشخصية بالكامل
        wait(1)

        -- إنشاء قيمة ClimbSpeed إذا لم تكن موجودة
        local climbSpeed = character:FindFirstChild("ClimbSpeed")
        if not climbSpeed then
            climbSpeed = Instance.new("NumberValue")
            climbSpeed.Name = "ClimbSpeed"
            climbSpeed.Parent = character
        end

        climbSpeed.Value = 10000000000 -- 10 مليار

        -- تنبيه اللاعب
        game.StarterGui:SetCore("SendNotification", {
            Title = "🧗‍♂️ سرعة تسلق مفعلة!",
            Text = "تم تعيين Climb Speed إلى 10B تلقائيًا.",
            Duration = 4
        })
    end)
end)
