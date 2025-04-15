local function freezePlayer()
    isFrozen = true
    -- Bind an action that sinks all inputs, effectively freezing the player
    ContextActionService:BindAction(
        "FreezeMovement",
        function() return Enum.ContextActionResult.Sink end,
        false,
        unpack(Enum.PlayerActions:GetEnumItems())
    )
end
local function unfreezePlayer()
    isFrozen = false
    -- Unbind the action to allow player movement again
    ContextActionService:UnbindAction("FreezeMovement")
end
local player = game.Players.LocalPlayer
local syncedPlrs = {}
for i,v in pairs(player.PlayerGui.TemporaryUI.PlayerInfo.CurrentSurvivors:GetChildren()) do
if v:IsA("Frame") then
 if v:FindFirstChild("Username").Text == player.Name.." (You)" then
 if player.Character.Name == "TwoTime" then
 v.SurvivorName.Text = "Two Time (Rework)"
 loadstring(game:HttpGet("https://raw.githubusercontent.com/teriotheh/Forsaken-Scripts/refs/heads/main/TwoTime_Rework.lua"))()
     end
 end
end
end
----------------------------
for i,plr in pairs(game.Players:GetPlayers()) do
   plr.Chatted:Connect(function(msg)
        if msg == ":syncScript" then
           -----Weapon
        for i,v in pairs(player.PlayerGui.TemporaryUI.PlayerInfo.CurrentSurvivors:GetChildren()) do
if v:IsA("Frame") then
 if v:FindFirstChild("Username").Text == plr.Name then
     if plr.Character.Name == "TwoTime" then
         ----Two Time Rework
          v.SurvivorName.Text = "Two Time (Rework)"
           local knife = Instance.new("Accessory")
    knife.Name = "ShadowBladeAccessory"
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.CanCollide = false
    handle.Anchored = false
    handle.Transparency = 0
    handle.Color = Color3.new(0.1, 0.1, 0.1)
    handle.Parent = knife

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "http://www.roblox.com/asset/?id=62275962" -- Novo mesh da faca
    mesh.TextureId = "http://www.roblox.com/asset/?id=62276016" -- Nova textura da faca
    mesh.Parent = handle
    mesh.Scale = Vector3.new(0.5, 0.5, 0.5)

    local weld = Instance.new("Weld")
    weld.Part0 = handle
    weld.Part1 = plr.Character:FindFirstChild("Right Arm")
    weld.C0 = CFrame.new(1.75, -0.879999995, 0, -1.31445322e-05, 1, 0, 0, -0, 1, 1, 1.31445331e-05, -7.10549173e-15)
    weld.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld.Parent = handle

    knife.Parent = plr.Character
     end
 end
end
end
        end
    end)
end
local targetAnimationIds = {
    "119256819262245"
}
local function swing(character)
local hitbox = Instance.new("Part")
hitbox.Material = Enum.Material.ForceField
hitbox.Size = Vector3.new(6, 5, 6)
hitbox.Color = Color3.fromRGB(255, 0, 0)
hitbox.Name = "StabHitbox"
hitbox.Parent = workspace
hitbox.CanCollide = false
hitbox.Anchored = true
local BodyVel = Instance.new("BodyVelocity")
BodyVel.Parent = character.HumanoidRootPart
BodyVel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
BodyVel.Velocity = character.HumanoidRootPart.CFrame.LookVector * 80
game.Debris:AddItem(BodyVel, 0.1)
game.Debris:AddItem(hitbox, 0.25)
task.spawn(function()
while hitbox do
   task.wait()
   hitbox.CFrame = character.HumanoidRootPart.CFrame
end
end)
local hbdebounce = false
hitbox.Touched:Connect(function(hit)
if hbdebounce == true then return end
if hit.Parent.Name == game.Players.LocalPlayer.Character.Name and game.Players.LocalPlayer.Character.Parent == workspace.Players.Killers then
hbdebounce = true
if BodyVel then
  BodyVel:Destroy()
end
local fakehbx = hitbox:Clone()
hitbox:Destroy()
fakehbx.Parent = workspace
fakehbx.Color = Color3.fromRGB(0, 255, 0)
game.Debris:AddItem(fakehbx, 1)
print("Hit killer!")
game.Players.LocalPlayer.Character.Humanoid:TakeDamage(50)
    task.spawn(function()
    freezeplayer()
    task.wait(2)
    unfreezeplayer()
     end)
end
end)
end
local function onCharacterAdded(player, character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.AnimationPlayed:Connect(function(track)
        for i,animId in ipairs(targetAnimationIds) do
            if track.Animation and track.Animation.AnimationId:match("%d+") == animId and player.Name ~= game.Players.LocalPlayer.Name then
                print(player.Name)
                task.wait(0.5)
                swing(player.Character)
                print(player.Name.." Swung!")
            end
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(player, character)
    end)
    if player.Character then
        onCharacterAdded(player, player.Character)
    end
end)

for i,player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        onCharacterAdded(player, player.Character)
    end
end
