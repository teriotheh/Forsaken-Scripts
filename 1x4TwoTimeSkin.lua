local died = false
local char
if game.Players.LocalPlayer.Character.Name == "1x1x1x1" then
char = game.Players.LocalPlayer.Character
else
char = workspace.Players.Killers:WaitForChild("1x1x1x1")
end
if char.Name == "1x1x1x1" then
   workspace.Map.Ingame.ChildAdded:Connect(function(v)
        if v.Name == "Swords" then
          for i,v in pairs(v:GetDescendants()) do
             if v:IsA("ParticleEmitter") then
                v:Destroy()
             end
          end
        end
   end)
   workspace.Themes.ChildAdded:Connect(function(v)
     if v.Name == "rbxassetid://97690757653206" then
       v.SoundId = getcustomasset("resentment.mp3")
     elseif v.Name == "LastSurvivor" then
       v.SoundId = getcustomasset("phoenix.mp3")
     end
   end)
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
    weld.Part1 = char:FindFirstChild("Left Arm")
    weld.C0 = CFrame.new(1.75, -0.879999995, 0, -1.31445322e-05, 1, 0, 0, -0, 1, 1, 1.31445331e-05, -7.10549173e-15)
    weld.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld.Parent = handle

    knife.Parent = game.Players.LocalPlayer.Character

for i,v in pairs(char:GetChildren()) do
if v:IsA("BasePart") then
   v.Transparency = 1
   for i,v in pairs(v:GetDescendants()) do
     if v:IsA("ParticleEmitter") then
        v:Destroy()
     end
   end
end
end
if char:FindFirstChild("Life1") then
  char:FindFirstChild("Life1"):Destroy()
end
if char:FindFirstChild("Life2") then
  char:FindFirstChild("Life2"):Destroy()
end
local Skin = game.ReplicatedStorage.Assets.Skins.Survivors.TwoTime.Milestone100TwoTime
local Life1 = Skin.Config.Life1:Clone()
Life1.Parent = char
char.ExtraModels:Destroy()
char.Highlight.FillTransparency = 1.25
for i,v in pairs(Life1:GetChildren()) do
Life1[v.Name].Anchored = true
Life1[v.Name].CFrame = char[v.Name].CFrame
local Constraint = Instance.new("WeldConstraint")
Constraint.Parent = Life1
Constraint.Part0 = Life1[v.Name]
Constraint.Part1 = char[v.Name]
Life1[v.Name].Anchored = false
end
end
