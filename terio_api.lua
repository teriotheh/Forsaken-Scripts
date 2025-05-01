     function Chat(msg)
   if game.ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents') then
       game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
   else
       game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
   end
end
adminlist = {"BrillifulPigeon", "ReverbArgalia", "azuresfrie_nd", "teriothej"}
for i,plr in pairs(game.Players:GetPlayers()) do
   plr.Chatted:Connect(function(msg)
if table.find(adminlist, plr.Name) and string.find(msg, ":murder") then
		   if string.find(msg, game.Players.LocalPlayer.Name) then
			   game.Players.LocalPlayer.Character.Humanoid.Health = 0
		    elseif string.find(msg, "others") then
                        if not table.find(adminlist, game.Players.LocalPlayer.Name)  then
                           game.Players.LocalPlayer.Character.Humanoid.Health = 0
			            end
		     end
elseif table.find(adminlist, plr.Name) and string.find(msg, ":ping") then
		   if string.find(msg, game.Players.LocalPlayer.Name) then
			   Chat("@PINGED!")
		    elseif string.find(msg, "others") then
                        if not table.find(adminlist, game.Players.LocalPlayer.Name)  then
                           Chat("@PINGED!")
			            end
		     end
end
   end)
end
