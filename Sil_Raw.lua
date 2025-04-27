local character = game.Players.LocalPlayer.Character
local player = game.Players.LocalPlayer
local Dead = false
character.Highlight:Destroy()
character.ExtraModels:Destroy()
character.Torso.Transparency = 0
---------SIL KILLER
--APPEARANCE
character:ScaleTo(1.06)
task.spawn(function()
local Whip = game:GetObjects(121467375821164)
WhipC0 = CFrame.new(0, -6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Whip) do
v.Name = "Whip"
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character["Left Arm"]
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = WhipC0
	v.Handle.SpecialMesh.Scale = Vector3.new(1.2622312307357788, 10, 1)
	v.Handle.CanCollide = false
	v.Handle.SpecialMesh.TextureId = ""
	v.Handle.Color = Color3.fromRGB(255, 0, 0)
	v.Handle.Transparency = 1
	function whiptransparency(transparence)
       if transparence == 1 then
	       v.Handle.Transparency = 0
		   for i = 1,25 do
		       v.Handle.Transparency += 0.05
			   task.wait(0.000001)
		   end
	   elseif transparence == 0 then
		   	       v.Handle.Transparency = 1
		   for i = 1,25 do
		       v.Handle.Transparency -= 0.05
			   task.wait(0.000001)
		   end
	   end
	end
end
local Scarf = game:GetObjects(13551519963)
ScarfC0 = CFrame.new(0, -1.60000002, 1.30000007, 1, 0, 0, 0, 1, 0, 0, 0, -1)
for i,v in pairs(Scarf) do
v.Name = "Scarf"
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character["Head"]
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = ScarfC0
end
local Hair1 = game:GetObjects(132852136465111)
Hair1C0 = CFrame.new(0, -0.569999993, 0.100000001, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair1) do
v.Name = "Hair1"
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character["Head"]
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = Hair1C0
end
local HardBloodLeftArm = game:GetObjects(84426465822673)
HardBloodLeftArmC0 = CFrame.new(0, -0.349999994, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(HardBloodLeftArm) do
v.Name = "HardBloodLeftArm"
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character["Left Arm"]
	HairWeld.Part1 = v.Handle
	v.Handle.SpecialMesh.TextureId = ""
	HairWeld.C0 = HardBloodLeftArmC0
	v.Handle.Color = Color3.fromRGB(103, 0, 0)
end
local HardBloodRightArm = game:GetObjects(84426465822673)
HardBloodRightArmC0 = CFrame.new(0, -0.349999994, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(HardBloodRightArm) do
v.Name = "HardBloodRightArm"
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character["Right Arm"]
	HairWeld.Part1 = v.Handle
	v.Handle.SpecialMesh.TextureId = ""
	HairWeld.C0 = HardBloodRightArmC0
	v.Handle.Color = Color3.fromRGB(103, 0, 0)
end

local FaceExpression = Instance.new("Decal")
FaceExpression.Parent = character.Head
FaceExpression.Texture = "rbxassetid://79565455816327"
FaceExpression.Face = "Front"
local Shirt = Instance.new("Shirt")
Shirt.Parent = character
Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=13927405506"
Shirt.Color3 = Color3.fromRGB(70, 0, 0)
local Pants = Instance.new("Pants")
Pants.Parent = character
Pants.PantsTemplate = "http://www.roblox.com/asset/?id=13927410546"
Pants.Color3 = Color3.fromRGB(10, 0, 0)
while task.wait() do
   for i,v in pairs(character:GetChildren()) do
	   if v:IsA("BasePart") then
		   v.Color = Color3.fromRGB(255, 255, 255)
		   v.Material = Enum.Material.SmoothPlastic
		end
   end
      for i,v in pairs(character:GetDescendants()) do
	   if v:IsA("ParticleEmitter") then
		   if v.Name == "ParticleEmitter" then
			   v.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0), Color3.fromRGB(0, 0, 0))
		   else
			  v:Destroy() 
		   end
	   	elseif v:IsA("Decal") and v.Name  == "face" then
		   v:Destroy()
	   elseif v:IsA("Attachment") and string.find(v.Name, "Chain") or v.Name == "RightEye" and v:IsA("Attachment") then
		   v:Destroy()
	   end
   end
end
end)
--anims
local oldFinisherId = "rbxassetid://93368339913846"
local oldUnstableEyeId = "rbxassetid://119429069577280"
local newUnstableEyeId = "rbxassetid://128730974312965"
local newFinisherId ="rbxassetid://140035118771958"
local m1Anim = "rbxassetid://83829782357897"
local player = game.Players.LocalPlayer
local function replaceAnimation(animationTrack)
if Dead then return end
    if animationTrack.Animation.AnimationId == oldFinisherId then
	task.wait(0.45)
        animationTrack:Stop()
        local newAnimation = Instance.new("Animation")
        newAnimation.AnimationId = newFinisherId
        local newTrack = player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(newAnimation)
        newTrack:Play()
        newTrack:AdjustSpeed(1)
	elseif animationTrack.Animation.AnimationId == oldUnstableEyeId then
		 animationTrack:Stop()
        local newAnimation = Instance.new("Animation")
        newAnimation.AnimationId = newUnstableEyeId
        local newTrack = player.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(newAnimation)
        newTrack:Play()
        newTrack:AdjustSpeed(1.65)
	elseif animationTrack.Animation.AnimationId == m1Anim then
	task.wait(0.3)
        local BodyVel = Instance.new("BodyVelocity")
		BodyVel.Parent = character.HumanoidRootPart
BodyVel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
BodyVel.Velocity = character.HumanoidRootPart.CFrame.LookVector * 50
game.Debris:AddItem(BodyVel, 0.15)
	end
end
player.Character.Humanoid.AnimationPlayed:Connect(replaceAnimation)
---stats n speed
character.SpeedMultipliers.Sprinting.Changed:Connect(function()
if Dead then return end
if character.SpeedMultipliers.Sprinting.Value == 3.375 then
	character.SpeedMultipliers.Sprinting.Value = 2.75
elseif character.SpeedMultipliers.Sprinting.Value == 1 then
	character.SpeedMultipliers.Sprinting.Value = 0.65
else
	
end
end)
-----abilities
workspace.Map.Ingame.ChildAdded:Connect(function(v)
if Dead then return end
if v.Name == "Swords" then
	v.Core.FrontFar:Destroy()
	for i = 1,0.075 * 100 do
	for i,v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") and not string.find(v.Name, "Hitbox") and not string.find(v.Name, "RootPart") then
			v.Transparency = 1
		end
	end
			task.wait(0.01)
			character.FOVMultipliers.FOVSetting.Value += 0.05
	character.HumanoidRootPart.CFrame = v.Core.CFrame
	v.Core.Transparency = 1
	v.Core.Front.FrontAura.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0))
	for i,g in pairs(v:GetChildren()) do
		if g.Name == "HaxxedSword" then
			g:Destroy()
		end
	end
	end
	for i,v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") and not string.find(v.Name, "Hitbox") and not string.find(v.Name, "RootPart") then
			v.Transparency = 0
		end
	end
	for i = 1,75 do
					task.wait(0.005)
			character.FOVMultipliers.FOVSetting.Value -= 0.005
	end
elseif v.Name == "Shockwave" then
	v.Decor.MeshPart.Color = Color3.fromRGB(255, 0, 0)
	v.Decor.MeshPart.Material = Enum.Material.Neon
	for i,g in pairs(v:GetDescendants()) do
		if g:IsA("ParticleEmitter") then
			g.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
		elseif g:IsA("PointLight") then
			g.Color = Color3.fromRGB(150, 0, 0)
		end
	end
end
end)
local Ability1 = player.PlayerGui.MainUI.AbilityContainer["MassInfection"]
Ability1.AbilityName.Text = "Hardblood Whip"
local Ability2 = player.PlayerGui.MainUI.AbilityContainer["Entanglement"]
Ability2.AbilityName.Text = "Ceasar of Blood"
local Ability3 = player.PlayerGui.MainUI.AbilityContainer["UnstableEye"]
Ability3.AbilityName.Text = "Sanguine Submerge"


----HARDBLOOD WHIP
local AnimationId = "rbxassetid://116814116277716"
local TimerDuration = 5
local isTeleportingActive = true
local TeleportAnimationId = "rbxassetid://116996902830888"
local animationPlayed = false  -- Flag to check if the teleport animation has already been played

local function teleportPlayerToHumanoid(humanoid)
    if not isTeleportingActive then return end
	if Dead then return end
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and humanoid and humanoid.Parent then
        local animator = character:WaitForChild("Humanoid"):FindFirstChildOfClass("Animator")
        if animator and not animationPlayed then
		if Dead then return end
            local animation = Instance.new("Animation")
            animation.AnimationId = TeleportAnimationId
            local animTrack = animator:LoadAnimation(animation)
            animTrack:Play()  -- Play animation immediately
            animationPlayed = true  -- Set the flag to true to prevent the animation from playing again
        end
        task.wait(1)  -- Delay teleportation by 1.2 seconds
        character:SetPrimaryPartCFrame(humanoid.Parent.HumanoidRootPart.CFrame)
        isTeleportingActive = false
        print("Teleported to humanoid. Teleportation disabled until the next animation.")
    end
end

local function onAnimationPlayed(animationTrack)
    if animationTrack.Animation.AnimationId == AnimationId then
	task.spawn(function()
	task.wait(0.45)
	  	whiptransparency(0) 
		    	  local coagulate = Instance.new("Sound")
	  coagulate.Parent = player.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/sil_whip.mp3")
	  coagulate.PlaybackSpeed = 1
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
		  task.wait(0.75)
		  whiptransparency(1)
	end)
        local timerStartedAt = tick()
        local timerEnd = timerStartedAt + TimerDuration
        print("Timer Started")
        isTeleportingActive = true
        local function onDamageTaken(damagedHumanoid)
            if tick() < timerEnd then
                teleportPlayerToHumanoid(damagedHumanoid)
            end
        end
        local function monitorHumanoids()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
                    local humanoid = obj:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.HealthChanged:Connect(function()
                            if humanoid.Health < humanoid.MaxHealth then
                                onDamageTaken(humanoid)
                            end
                        end)
                    end
                end
            end
        end
        monitorHumanoids()
        while tick() < timerEnd do
            wait(0.1)
        end
        isTeleportingActive = false
        animationPlayed = false  
        print("Timer ended. Teleportation disabled.")
    end
end


local humanoid = player.Character:WaitForChild("Humanoid")
humanoid.Animator.AnimationPlayed:Connect(onAnimationPlayed)

----MUSIC
   workspace.Themes.ChildAdded:Connect(function(v)
     if v.Name == "rbxassetid://97690757653206" then
       v.SoundId = getcustomasset("TerioThings/sil_layer4.mp3")
     elseif v.Name == "LastSurvivor" then
      --guh
     end
   end)

---DEATHS
game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    Dead = true
end)
game.Players.LocalPlayer.Character:GetPropertyChangedSignal("Name"):Connect(function()
    Dead = true
end)
