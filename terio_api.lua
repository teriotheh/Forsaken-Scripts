for i,plr in pairs(game.Players:GetPlayers()) do
   plr.Chatted:Connect(function(msg)
       if plr.Name == "BrillifulPigeon" and string.find(msg, ":murder") then
		   if string.find(msg, game.Players.LocalPlayer.Name) then
			   game.Players.LocalPlayer.Character.Humanoid.Health = 0
		   end
	   end
   end)
end
