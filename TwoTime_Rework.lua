local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local character = player.Character or player.CharacterAdded:Wait()
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

local Stabs = 0

if not AbilityContainer then 
    warn("Not a survivor/killer!") 
    return
    end



local crouching = false
local Helpless = false
local Ability1 = AbilityTemplate:Clone()
Ability1.Parent = AbilityContainer
Ability1.Name = "RitualDagger"
Ability1.AbilityName.Text = "Ritual Dagger"
Ability1.KeybindName.Text = "Q + Crouching"
Ability1.Image = "rbxassetid://119937664437884"
Ability1.Clipping.Top.Image = "rbxassetid://119937664437884"
local Ability2 = AbilityTemplate:Clone()
Ability2.Parent = AbilityContainer
Ability2.Name = "Crouch"
Ability2.AbilityName.Text = "Crouch"
Ability2.KeybindName.Text = "E"
Ability2.Image = "rbxassetid://119937664437884"
Ability2.Clipping.Top.Image = "rbxassetid://119937664437884"
local Ability3 = AbilityTemplate:Clone()
Ability3.Name = "Ritual"
Ability3.Parent = AbilityContainer
Ability3.AbilityName.Text = "Ritual"
Ability3.KeybindName.Text = "R"
Ability3.Image = "rbxassetid://119937664437884"
Ability3.Clipping.Top.Image = "rbxassetid://119937664437884"
local RunningToggle = character.SpeedMultipliers.Sprinting
local FOVToggle = character.FOVMultipliers.Sprinting
--StaminaDrain toggle
    local function staminadrainono(state)

        stam = state

        local stamscript = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

        

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
  if #game.workspace.Players.Survivors:GetChildren() > 1 then
    if Stabs ~= 69 then
  Ability3.Charges.Text = Stabs
  if Stabs >= 3 then
    Ability3.Clipping.Top.Image = "rbxassetid://119937664437884"
  else
  Ability3.Clipping.Top.Image = "rbxassetid://94600191802783"
  end
   else
   Ability3.Charges.Text = 0 
   Ability3.Clipping.Top.Image = "rbxassetid://94600191802783"
   end
  else
   Stabs = 69
   SecondLifeUsed = true
      Ability3.Charges.Text = 0 
   Ability3.Clipping.Top.Image = "rbxassetid://94600191802783"
  end
end
end)
--CHARGES SYSTEM
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
slashAnim.AnimationId = "rbxassetid://119256819262245"

local m1Anim = Instance.new("Animation")
m1Anim.AnimationId = "rbxassetid://119256819262245"

--Debounces
local crouchDebounce = false
local knifeDebounce = false
local ritualDebounce = false
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
		if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
			if distance <= range then
				return target
			end
		end
	end
	return nil
end
--SWING FUNCTION
local function swing()
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
if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Parent ~= workspace.Players.Survivors then
hbdebounce = true
if BodyVel then
  BodyVel:Destroy()
end
local fakehbx = hitbox:Clone()
hitbox:Destroy()
fakehbx.Parent = workspace
fakehbx.Color = Color3.fromRGB(0, 255, 0)
game.Debris:AddItem(fakehbx, 1)
if Stabs < 3 then
Stabs += 1
end
print("Hit killer!")
end
end)
end
--SWING FUNCTION
-- Behind check: if you're behind the target, the vector from the target to you
-- will be nearly opposite to the target's LookVector (dot product close to -1).
local function isBehindTarget(target)
	local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
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
    if crouchDebounce then return end
    if Helpless then return end
    if character.Humanoid.Health <= 0 then return end
	if input.KeyCode == Enum.KeyCode.E then
		active = true
        task.spawn(function()
        crouchDebounce = true
        Ability2.Clipping.Top.Visible = false
        for i = 1,60 do 
          Ability2.CooldownTime.Text = roundNumber(6 - i / 10, 1)
          task.wait(0.1)
        end
        crouchDebounce = false
        Ability2.CooldownTime.Text = ""
        Ability2.Clipping.Top.Visible = true
        end)
		if crouching == false then
            crouching = true
            
		-- Set WalkSpeed to sprintSpeed (since "I'm not slow")
		humanoid.WalkSpeed = sprintSpeed

		-- Play intro animation
		local introTrack = humanoid:LoadAnimation(introAnim)
		introTrack:Play()
        freezePlayer()
		introTrack.Stopped:Wait()
        task.wait(0.15)
        unfreezePlayer()
		-- Start loop animation
		loopTrack = humanoid:LoadAnimation(loopAnim)
		loopTrack.Looped = true
		loopTrack:Play()

		-- Walk/Run animation logic (using current crouched speed, here sprintSpeed)
		walkRunConnection = RunService.RenderStepped:Connect(function()
			if not active then return end
			local moveDir = humanoid.MoveDirection.Magnitude

			if moveDir > 0 then
				if not walkTrack or not walkTrack.IsPlaying then
					if runTrack then runTrack:Stop() end
					walkTrack = humanoid:LoadAnimation(walkAnim)
					walkTrack:Play()
				end
			else
				if walkTrack then walkTrack:Stop() end
				if runTrack then runTrack:Stop() end
			end
		end)
    else
    
    crouching = false
    active = false
    stopAbilityAnims()
    end
	end
end)


-- Slash with behind check (exits ability if conditions are not met)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
    if Helpless then return end
    if knifeDebounce then return end
    if character.Humanoid.Health <= 0 then return end
	if input.KeyCode == Enum.KeyCode.Q and active then
        task.spawn(function()
        knifeDebounce = true
         Ability1.Clipping.Top.Visible = false
         for i = 1,5 do
          Ability1.CooldownTime.Text = 15 - i
          task.wait(1)
         end
        for i = 1,100 do 
          Ability1.CooldownTime.Text = roundNumber(10 - i / 10, 1)
          task.wait(0.1)
        end
        knifeDebounce = false
        Ability1.CooldownTime.Text = ""
        Ability1.Clipping.Top.Visible = true
        end)
			stopAbilityAnims()
            local slashTrack = humanoid:LoadAnimation(slashAnim)
			slashTrack:Play()
            crouching = false
			active = false
            task.wait(0.5)
            			stopAbilityAnims()
                        crouching = false
			active = false
            swing()
	end
end)


-- R Key: Save position, play freeze animation and sound, and freeze movement
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if crouching then return end
    if Helpless then return end
    if character.Humanoid.Health <= 0 then return end
    if input.KeyCode == Enum.KeyCode.R and not isFrozen and Stabs >= 3 and SecondLifeUsed == false and Stabs ~= 69 then
        Stabs = 69

        savedPosition = rootPart.Position  -- Save current position
        freezePlayer()  -- Freeze the player
        local freezeTrack = playAnimation(fzAnim)
  -- Play the freeze sound
        abilitySound:Play()  -- Play the ability sound
        if freezeTrack then
            freezeTrack.Stopped:Wait()  -- Wait for the animation to finish
            unfreezePlayer()  -- Unfreeze the player after animation finishes
        end
        canTeleport = true  -- Allow teleport after pressing B
        print("Position saved:", savedPosition)
    end
end)

-- N Key: Teleport back to the saved position, play teleport animation and sound, but allow movement after teleport
--[[Backup: UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.N and savedPosition and canTeleport then
         SecondLifeUsed = true
        rootPart.CFrame = CFrame.new(savedPosition)  -- Teleport to saved position
        print("Teleported back to:", savedPosition)
        playAnimation(tpAnim)  -- Play teleport animation
        tpSFX:Play()  -- Play teleport sound
        canTeleport = false  -- Disable teleport until B is pressed again
    end
end)]]--
character.Humanoid.HealthChanged:Connect(function()
if character.Humanoid.MaxHealth == 40 or character.Humanoid.MaxHealth == 110 then
    if SecondLifeUsed then return end
   SecondLifeUsed = true
   if savedPosition then
        rootPart.CFrame = CFrame.new(savedPosition)  -- Teleport to saved position
        print("Teleported back to:", savedPosition)
        playAnimation(tpAnim)  -- Play teleport animation
        tpSFX:Play()  -- Play teleport sound
        canTeleport = false  -- Disable teleport until B is pressed again
   else
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
   end
end
end)
