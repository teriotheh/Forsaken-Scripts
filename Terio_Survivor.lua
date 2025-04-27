 
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local character = player.character or player.characterAdded:Wait()
local StatusTemplate = game.ReplicatedStorage.Modules.Statuses.StatusDisplay
local Dead = false
---------------------------------------------------------TERIO CHARACTER
if character.Name == "Shedletsky" then
--UI
for i,v in pairs(player.PlayerGui.TemporaryUI.PlayerInfo.CurrentSurvivors:GetChildren()) do
	if v:IsA("Frame") and string.find(v.Username.Text, player.Name) then
		v.SurvivorName.Text = "Terio"
		v.Icon.Image = "rbxassetid://112952494470082"
	end
end





function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	Minutes = Minutes
	return Format(Minutes)..":"..Format(Seconds)
end
function addStatusEffect(status, power, timer)
    local Status = StatusTemplate:Clone()
    Status.Name = status.."-Artificial"
    Status.Parent = player.PlayerGui.MainUI.StatusContainer
    Status.Title.Text = status.." "..power
    for i = 1,timer do
    Status.Timer.Text = convertToHMS(timer - i)
    task.wait(1)
    end
    Status:Destroy()
end
function giveSpeed(time)
task.spawn(function()
task.spawn(function()
addStatusEffect("Speed", "III", time)
end)
for i = 1,time * 100 do
if character.FOVMultipliers.Sprinting.Value == 1.125 then
	character.SpeedMultipliers.Sprinting.Value = 3
else
	character.SpeedMultipliers.Sprinting.Value = 1.55
end
		task.wait(0.01)
end
if character.FOVMultipliers.Sprinting.Value == 1.125 then
	character.SpeedMultipliers.Sprinting.Value = 2.167
else
	character.SpeedMultipliers.Sprinting.Value = 1
end
end)
end
local fzAnim = Instance.new("Animation")
fzAnim.AnimationId = "rbxassetid://117339039533356"
--rounding system for cooldowns
function roundNumber(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
------
local tpAnim = Instance.new("Animation")
tpAnim.AnimationId = "rbxassetid://84260460113659"


local SecondLifeUsed = false

local tpSFX = Instance.new("Sound")
tpSFX.SoundId = "rbxassetid://84260460113659"  
tpSFX.Volume = 1.45 
tpSFX.Parent = player:WaitForChild("PlayerGui")  

local abilitySound = Instance.new("Sound")
abilitySound.SoundId = "rbxassetid://100981628806546" 
abilitySound.Volume = 1.45  
abilitySound.Parent = player:WaitForChild("PlayerGui")  

local savedPosition = nil
local isFrozen = false
local canTeleport = false 
local AbilityContainer = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer")
local AbilityTemplate = game.ReplicatedStorage.Assets.UI.AbilityIcon

local Stabs = 1

if not AbilityContainer then 
    warn("Not a survivor/killer!") 
    return
end


--SHEDLETSKY CONFIGURATION AND APPEARANCE
for i,v in pairs(character:GetDescendants()) do
	if v:IsA("Accessory") or v:IsA("Hat") or v.Name == "Pants" or v.Name == "Shirt" or v.Name == "ExpressionHolder" or v.Name == "Body Colors" then
		v:Destroy()
	end
end
task.spawn(function()
while task.wait() do
if Dead then return end
for i,v in pairs(character:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Color = Color3.fromRGB(255, 255, 255)
	end
end
end
end)
--CLOTHING
local Shirt = Instance.new("Shirt")
Shirt.Parent = character
Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=13132949672"
local Pants = Instance.new("Pants")
Pants.Parent = character
Pants.PantsTemplate = "http://www.roblox.com/asset/?id=13132951176"
local Hair1 = game:GetObjects(15347329623)
local Hair1C0 = CFrame.new(0.05, 0.15, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair1) do
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character.Head
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = Hair1C0
end
local Hair2 = game:GetObjects(17612852370)
local Hair2C0 = CFrame.new(0, -0.699999988, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair2) do
	v.Parent = character
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = character.Head
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = Hair2C0
end
local FaceExpression = Instance.new("Decal")
FaceExpression.Parent = character.Head
FaceExpression.Texture = "rbxassetid://133089396665213"
FaceExpression.Face = "Front"
task.spawn(function()
character.Chicken:Destroy()
character.Sword:Destroy()
end)
------
local crouching = false
local Helpless = false
local Ability1 = AbilityContainer.Slash
Ability1.Parent = AbilityContainer
Ability1.Name = "Pierce"
Ability1.AbilityName.Text = "Pierce"
Ability1.KeybindName.Text = "Q"
Ability1.Image = "rbxassetid://86446809053120"
Ability1.Clipping.Top.Image = "rbxassetid://86446809053120"
local Ability2 = AbilityContainer.FriedChicken
Ability2.Parent = AbilityContainer
Ability2.AbilityName.Text = "Coagulate"
Ability2.KeybindName.Text = "E"
Ability2.Image = "rbxassetid://97128711074466"
Ability2.Clipping.Top.Image = "rbxassetid://97128711074466"
local Ability3 = AbilityTemplate:Clone()
Ability3.Name = "Feed"
Ability3.Parent = AbilityContainer
Ability3.AbilityName.Text = "Feed"
Ability3.KeybindName.Text = "R"
Ability3.Image = "rbxassetid://89599029084803"
Ability3.Clipping.Top.Image = "rbxassetid://89599029084803"
Ability3.LayoutOrder = 3
local RunningToggle = character.SpeedMultipliers.Sprinting
local FOVToggle = character.FOVMultipliers.Sprinting
-----Weapon
   local LanceBack = Instance.new("Accessory")
    LanceBack.Name = "LanceBack"
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.CanCollide = false
    handle.Anchored = false
    handle.Transparency = 0
    handle.Color = Color3.new(0.1, 0.1, 0.1)
    handle.Parent = LanceBack

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "http://www.roblox.com/asset/?id=18858726703" -- Novo mesh da faca
    mesh.TextureId = "http://www.roblox.com/asset/?id=18858727747" -- Nova textura da faca
    mesh.Parent = handle
    mesh.Scale = Vector3.new(1, 1, 1)

    local weld = Instance.new("Weld")
    weld.Part0 = handle
    weld.Part1 = game.Players.LocalPlayer.character:FindFirstChild("Torso")
    weld.C0 = CFrame.new(0, -1, -0.5, 1, 0, 0, 0, -1, 0, 0, 0, 1)
    weld.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld.Parent = handle

    LanceBack.Parent = game.Players.LocalPlayer.character
 local LanceFront = Instance.new("Accessory")
    LanceFront.Name = "LanceFront"
    
    local handle1 = Instance.new("Part")
    handle1.Name = "Handle"
    handle1.Size = Vector3.new(1, 1, 1)
    handle1.CanCollide = false
    handle1.Anchored = false
    handle1.Transparency = 1
    handle1.Color = Color3.new(0.1, 0.1, 0.1)
    handle1.Parent = LanceFront

    local mesh1 = Instance.new("SpecialMesh")
    mesh1.MeshId = "http://www.roblox.com/asset/?id=18858726703" -- Novo mesh da faca
    mesh1.TextureId = "http://www.roblox.com/asset/?id=18858727747" -- Nova textura da faca
    mesh1.Parent = handle1
    mesh1.Scale = Vector3.new(1, 1, 1)

    local weld1 = Instance.new("Weld")
    weld1.Part0 = handle1
    weld1.Part1 = game.Players.LocalPlayer.character:FindFirstChild("Right Arm")
    weld1.C0 = CFrame.new(-1, 0.400000006, 0, 0.00999950059, -0.999750197, 0.0199924111, 0, -0.0199934151, -0.999800086, -0.999950051, -0.00999750197, 0.000199924252)
    weld1.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld1.Parent = handle1

    LanceFront.Parent = game.Players.LocalPlayer.character
local stabSFX = Instance.new("Sound")
stabSFX.SoundId = "rbxassetid://99820161736138" 
stabSFX.Volume = 1.45  
stabSFX.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  
stabSFX:Play()
local standingstabSFX = Instance.new("Sound")
standingstabSFX.SoundId = "rbxassetid://86710781315432"
standingstabSFX.Volume = 1.45  
standingstabSFX.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  
standingstabSFX:Play()
-------------------------------------------------
--StaminaDrain toggle
    local function staminadrainono(state)

        stam = state

        local stamscript = require(game.ReplicatedStorage.Systems.character.Game.Sprinting)

        

        local connection

        connection = game:GetService("RunService").Heartbeat:Connect(function()

            if not stam then

                connection:Disconnect()

                stamscript.StaminaLossDisabled = nil

                return

            end

            stamscript.StaminaLossDisabled = function() 

            end

        end)

    end 
--CHARGES SYSTEM
task.spawn(function()
while task.wait() do
  if crouching then
    
    RunningToggle.Parent = character
    FOVToggle.Parent = character
  else
    RunningToggle.Parent = character.SpeedMultipliers
    FOVToggle.Parent = character.FOVMultipliers

  end
  if player.PlayerGui.MainUI.StatusContainer:FindFirstChild("Helpless") then
   Helpless = true
  else
   Helpless = false
  end
  if #game.workspace.Players.Survivors:GetChildren() >= 1 then
    if Stabs ~= 69 then
  Ability3.Charges.Text = Stabs
  if Stabs >= 1 then
    Ability3.Clipping.Top.Image = "rbxassetid://89599029084803"
  else
  Ability3.Clipping.Top.Image = "rbxassetid://94600191802783"
  end
   else
   Ability3.Charges.Text = 0 
   Ability3.Clipping.Top.Image = "rbxassetid://94600191802783"
   end
  else

  end
end
end)
--characterGES SYSTEM
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()



-- AnimationIDs
local introAnim = Instance.new("Animation")
introAnim.AnimationId = "rbxassetid://98606150731314"

local loopAnim = Instance.new("Animation")
loopAnim.AnimationId = "rbxassetid://74530436512522"

local walkAnim = Instance.new("Animation")
walkAnim.AnimationId = "rbxassetid://94721495253171"

local runAnim = Instance.new("Animation")
runAnim.AnimationId = "rbxassetid://93499989310243"

local slashAnim = Instance.new("Animation")
slashAnim.AnimationId = "rbxassetid://84413781229733"
local standingslashAnim = Instance.new("Animation")
standingslashAnim.AnimationId = "rbxassetid://86545133269813"

local m1Anim = Instance.new("Animation")
m1Anim.AnimationId = "rbxassetid://119256819262245"

--Debounces
local CoagulateDebounce = false
local PierceDebounce = false
local FeedDebounce = false
-- Tracks and state
local loopTrack
local walkTrack
local runTrack
local walkRunConnection
local active = false
local rootPart = character:WaitForChild("HumanoidRootPart")
local runningDisabled = false


-- Function to play an animation
local function playAnimation(animation)
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        local animationTrack = animator:LoadAnimation(animation)
        animationTrack:Play()
        return animationTrack
    end
end

-- Function to freeze the player
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
--NO RUN WHILE CROUCHING
--insert noo run script here
--NO RUN WHILE CROUCHING
-- Function to unfreeze the player
local function unfreezePlayer()
    isFrozen = false
    -- Unbind the action to allow player movement again
    ContextActionService:UnbindAction("FreezeMovement")
end
-- Helper to stop all ability animations and reset WalkSpeed
local function stopAbilityAnims()
	if loopTrack then loopTrack:Stop() end
	if walkTrack then walkTrack:Stop() end
	if runTrack then runTrack:Stop() end
	if walkRunConnection then walkRunConnection:Disconnect() end
	-- When ability ends, set WalkSpeed to normalSpeed
	humanoid.WalkSpeed = normalSpeed
end

-- Check if near a player
local function getNearbyPlayer(range)
	for _, target in pairs(Players:GetPlayers()) do
		if target ~= player and target.character and target.character:FindFirstChild("HumanoidRootPart") then
			local distance = (character.HumanoidRootPart.Position - target.character.HumanoidRootPart.Position).Magnitude
			if distance <= range then
				return target
			end
		end
	end
	return nil
end
--SWING FUNCTION
local function applyVelocity(timing, power)
local BodyVel = Instance.new("BodyVelocity")
BodyVel.Parent = character.HumanoidRootPart
BodyVel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
BodyVel.Velocity = character.HumanoidRootPart.CFrame.LookVector * power
game.Debris:AddItem(BodyVel, timing)
end
--SWING FUNCTION
-- Behind check: if you're behind the target, the vector from the target to you
-- will be nearly opposite to the target's LookVector (dot product close to -1).
local function isBehindTarget(target)
	local targetHRP = target.character and target.character:FindFirstChild("HumanoidRootPart")
	local myHRP = character:FindFirstChild("HumanoidRootPart")
	if not targetHRP or not myHRP then 
		return false 
	end
	
	local toAttacker = (myHRP.Position - targetHRP.Position).Unit
	local targetLook = targetHRP.CFrame.LookVector
	local dot = toAttacker:Dot(targetLook)
	print("Slash Attempt - Dot product for", target.Name, ":", dot)
	return dot < -0.5
end

-- Ability Activation using the E key
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
    if CoagulateDebounce then return end
    if Helpless then return end
    if character.Humanoid.Health <= 0 then return end
    if Dead then return end
	if input.KeyCode == Enum.KeyCode.E then
	task.spawn(function()
        CoagulateDebounce = true
		task.wait(70)
		CoagulateDebounce = false
	end)
      freezePlayer()
	  task.wait(2)
	  FaceExpression.Texture = "rbxassetid://127552301758353"
	  	  local coagulate = Instance.new("Sound")
	  coagulate.Parent = player.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/coagulate.mp3")
	  coagulate.PlaybackSpeed = 1.5
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
	  task.wait(0.15)
	  task.spawn(function()
	     local highlight = Instance.new("Highlight")
		 highlight.Parent = character
		 highlight.Adornee = character
		 highlight.OutlineTransparency = 1
		 highlight.FillColor = Color3.fromRGB(255, 0, 0)
		 highlight.FillTransparency = 1
		 for i = 1,20 do
		     highlight.FillTransparency -= 0.05
			 task.wait(0.01)
		 end
		 task.wait(0.2)
		 FaceExpression.Texture = "rbxassetid://133089396665213"
		 	 for i = 1,100 do
		     highlight.FillTransparency += 0.01
			 task.wait(0.01)
		 end
		 highlight:Destroy()
	  end)
	  task.wait(1)
	  
	  unfreezePlayer()
	end
end)


-- Slash with behind check (exits ability if conditions are not met)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
    if Helpless then return end
    if PierceDebounce then return end
	if Dead then return end
    if character.Humanoid.Health <= 0 then return end
	if input.KeyCode == Enum.KeyCode.Q then
        task.spawn(function()
	  local coagulate = Instance.new("Sound")
	  coagulate.Parent = player.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/lance_swing.mp3")
	  coagulate.PlaybackSpeed = 1.5
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
        PierceDebounce = true
         Ability1.Clipping.Top.Visible = false
         for i = 1,30 do
          Ability1.CooldownTime.Text = 40 - i
          task.wait(1)
         end
        for i = 1,100 do 
          Ability1.CooldownTime.Text = roundNumber(10 - i / 10, 1)
          task.wait(0.1)
        end
        PierceDebounce = false
        Ability1.CooldownTime.Text = ""
        Ability1.Clipping.Top.Visible = true
        end)
    if player.PlayerGui.MainUI.StatusContainer:FindFirstChild("Undetectable-Artificial") then
      player.PlayerGui.MainUI.StatusContainer:FindFirstChild("Undetectable-Artificial"):Destroy()
    end
			stopAbilityAnims()
			local standingSlashTrack = humanoid:LoadAnimation(standingslashAnim)
            local slashTrack = humanoid:LoadAnimation(slashAnim)
						handle1.Transparency = 0
			handle.Transparency = 1
			FaceExpression.Texture = "rbxassetid://79565455816327"
            task.wait(0.5)
			 local coagulate = Instance.new("Sound")
	  coagulate.Parent = player.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/lance_swing.mp3")
	  coagulate.PlaybackSpeed = 2
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
			slashTrack:Play()
			applyVelocity(0.27, 55)
            			stopAbilityAnims()
                        crouching = false
            			active = false
			task.wait(2)
			 FaceExpression.Texture = "rbxassetid://133089396665213"
			handle1.Transparency = 1
			handle.Transparency = 0

	end
end)


-- R Key: Save position, play freeze animation and sound, and freeze movement
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if crouching then return end
    if Helpless then return end
	if Dead then return end
	if FeedDebounce then return end
    if character.Humanoid.Health <= 0 then return end
    if input.KeyCode == Enum.KeyCode.R and Stabs >= 1 then
	 Ability3.Clipping.Top.Visible = false
	 task.spawn(function()
	 FeedDebounce = true
         for i = 1,40 do
          Ability3.CooldownTime.Text = 50 - i
          task.wait(1)
         end
        for i = 1,100 do 
          Ability3.CooldownTime.Text = roundNumber(10 - i / 10, 1)
          task.wait(0.1)
        end
		Ability3.CooldownTime.Text = ""
		Ability3.Clipping.Top.Visible = true
		FeedDebounce = false
		end)
		 task.spawn(function()
	     local highlight = Instance.new("Highlight")
		 highlight.Parent = character
		 highlight.Adornee = character
		 highlight.OutlineTransparency = 1
		 highlight.FillColor = Color3.fromRGB(255, 40, 80)
		 highlight.FillTransparency = 1
		 for i = 1,10 do
		     highlight.FillTransparency -= 0.1
			 task.wait(0.01)
		 end
		 task.wait(0.2)
		 	 for i = 1,10 do
		     highlight.FillTransparency += 0.1
			 task.wait(0.01)
		 end
		 highlight:Destroy()
	  end)
       Stabs -= 1
	   FaceExpression.Texture = "rbxassetid://133611309054814"
	   giveSpeed(5)
	   task.wait(4)
       FaceExpression.Texture = "rbxassetid://133089396665213"
    end
end)

--FEED FUNCTION
workspace.Players.Survivors.ChildRemoved:Connect(function()
  Stabs += 1
end)
game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    Dead = true
end)
game.Players.LocalPlayer.Character:GetPropertyChangedSignal("Name"):Connect(function()
    Dead = true
end)
end

----OTHER PLAYERS (MULTIPLAYER)
----------------------------
local syncedTable = {}
for i,plr in pairs(game.Players:GetPlayers()) do
   plr.Chatted:Connect(function(msg)
   if Dead then return end
        if msg == "_sync_terio_" and plr.Name ~= game.Players.LocalPlayer.Name and not table.find(syncedTable, plr.Name) then
           local targetChar = plr.Character
		   table.insert(syncedTable, plr.Name)
	for i,v in pairs(player.PlayerGui.TemporaryUI.PlayerInfo.CurrentSurvivors:GetChildren()) do
	if v:IsA("Frame") and string.find(v.Username.Text, plr.Name) then
		v.SurvivorName.Text = "Terio"
		v.Icon.Image = "rbxassetid://112952494470082"
	end
        
end

		   for i,v in pairs(targetChar:GetDescendants()) do
	if v:IsA("Accessory") or v:IsA("Hat") or v.Name == "Pants" or v.Name == "Shirt" or v.Name == "ExpressionHolder" or v.Name == "Body Colors" then
		v:Destroy()
	end
end
task.spawn(function()
while task.wait() do
if Dead then return end
for i,v in pairs(targetChar:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Color = Color3.fromRGB(255, 255, 255)
	end
end
end
end)
--CLOTHING
local Shirt = Instance.new("Shirt")
Shirt.Parent = targetChar
Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=13132949672"
local Pants = Instance.new("Pants")
Pants.Parent = targetChar
Pants.PantsTemplate = "http://www.roblox.com/asset/?id=13132951176"
local Hair1 = game:GetObjects(15347329623)
local Hair1C0 = CFrame.new(0.05, 0.15, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair1) do
	v.Parent = targetChar
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = targetChar.Head
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = Hair1C0
end
local Hair2 = game:GetObjects(17612852370)
local Hair2C0 = CFrame.new(0, -0.699999988, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair2) do
	v.Parent = targetChar
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = targetChar.Head
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = Hair2C0
end
local FaceExpression = Instance.new("Decal")
FaceExpression.Parent = targetChar.Head
FaceExpression.Texture = "rbxassetid://133089396665213"
FaceExpression.Face = "Front"
---LANCE

 local LanceBack = Instance.new("Accessory")
    LanceBack.Name = "LanceBack"
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.CanCollide = false
    handle.Anchored = false
    handle.Transparency = 0
    handle.Color = Color3.new(0.1, 0.1, 0.1)
    handle.Parent = LanceBack

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "http://www.roblox.com/asset/?id=18858726703" -- Novo mesh da faca
    mesh.TextureId = "http://www.roblox.com/asset/?id=18858727747" -- Nova textura da faca
    mesh.Parent = handle
    mesh.Scale = Vector3.new(1, 1, 1)

    local weld = Instance.new("Weld")
    weld.Part0 = handle
    weld.Part1 = targetChar:FindFirstChild("Torso")
    weld.C0 = CFrame.new(0, -1, -0.5, 1, 0, 0, 0, -1, 0, 0, 0, 1)
    weld.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld.Parent = handle

    LanceBack.Parent = targetChar
 local LanceFront = Instance.new("Accessory")
    LanceFront.Name = "LanceFront"
    
    local handle1 = Instance.new("Part")
    handle1.Name = "Handle"
    handle1.Size = Vector3.new(1, 1, 1)
    handle1.CanCollide = false
    handle1.Anchored = false
    handle1.Transparency = 1
    handle1.Color = Color3.new(0.1, 0.1, 0.1)
    handle1.Parent = LanceFront

    local mesh1 = Instance.new("SpecialMesh")
    mesh1.MeshId = "http://www.roblox.com/asset/?id=18858726703" -- Novo mesh da faca
    mesh1.TextureId = "http://www.roblox.com/asset/?id=18858727747" -- Nova textura da faca
    mesh1.Parent = handle1
    mesh1.Scale = Vector3.new(1, 1, 1)

    local weld1 = Instance.new("Weld")
    weld1.Part0 = handle1
    weld1.Part1 = targetChar:FindFirstChild("Right Arm")
    weld1.C0 = CFrame.new(-1, 0.400000006, 0, 0.00999950059, -0.999750197, 0.0199924111, 0, -0.0199934151, -0.999800086, -0.999950051, -0.00999750197, 0.000199924252)
    weld1.C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    weld1.Parent = handle1
	LanceFront.Parent = targetChar
--
task.spawn(function()
targetChar.Chicken:Destroy()
targetChar.Sword:Destroy()
end)
		end
	end)
end

------ANIMATIONS FOR OTHERS
local targetAnimationIds = {
    "84413781229733",
	"121781457295101"
}
local function onCharacterAdded(ployer, character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.AnimationPlayed:Connect(function(track)
	if Dead then return end
        for i,animId in ipairs(targetAnimationIds) do
            if track.Animation and track.Animation.AnimationId:match("%d+") == animId and ployer.Name ~= game.Players.LocalPlayer.Name and table.find(syncedTable, ployer.Name) then
			if string.find(track.Animation.AnimationId, "84413781229733") then
                print(ployer.Name)
				if ployer.Character:FindFirstChild("LanceFront") then
					ployer.Character:FindFirstChild("LanceFront").Handle.Transparency = 0
				end
				if ployer.Character:FindFirstChild("LanceBack") then
					ployer.Character:FindFirstChild("LanceBack").Handle.Transparency = 1
				end
				 local coagulate = Instance.new("Sound")
	  coagulate.Parent = game.Players.LocalPlayer.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/lance_swing.mp3")
	  coagulate.PlaybackSpeed = 1.5
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
                task.wait(2)
				if ployer.Character:FindFirstChild("LanceFront") then
					ployer.Character:FindFirstChild("LanceFront").Handle.Transparency = 1
				end
				if ployer.Character:FindFirstChild("LanceBack") then
					ployer.Character:FindFirstChild("LanceBack").Handle.Transparency = 0
				end
            elseif string.find(track.Animation.AnimationId, "121781457295101") then
				 task.wait(2)
	  ployer.Character.Head.Decal.Texture = "rbxassetid://127552301758353"
	  	  local coagulate = Instance.new("Sound")
	  coagulate.Parent = game.Players.LocalPlayer.PlayerGui
	  coagulate.SoundId = getcustomasset("TerioThings/coagulate.mp3")
	  coagulate.PlaybackSpeed = 1.5
	  coagulate:Play()
	  coagulate.Volume = 1.5
	  game.Debris:AddItem(coagulate, 2)
	  task.wait(0.15)
	  task.spawn(function()
	     local highlight = Instance.new("Highlight")
		 highlight.Parent = ployer.Character
		 highlight.Adornee = ployer.Character
		 highlight.OutlineTransparency = 1
		 highlight.FillColor = Color3.fromRGB(255, 0, 0)
		 highlight.FillTransparency = 1
		 for i = 1,20 do
		     highlight.FillTransparency -= 0.05
			 task.wait(0.01)
		 end
		 task.wait(0.2)
		 ployer.Character.Head.Decal.Texture = "rbxassetid://133089396665213"
		 	 for i = 1,100 do
		     highlight.FillTransparency += 0.01
			 task.wait(0.01)
		 end
		 highlight:Destroy()
	  end)
	  task.wait(1)
			end
			end
        end
    end)
end

game.Players.playerAdded:Connect(function(ployer)
    ployer.CharacterAdded:Connect(function(character)
        onCharacterAdded(ployer, character)
    end)
    if ployer.Character then
        onCharacterAdded(ployer, ployer.Character)
    end
end)

for i,ployer in ipairs(game.Players:GetPlayers()) do
    if ployer.Character then
        onCharacterAdded(ployer, ployer.Character)
    end
end
