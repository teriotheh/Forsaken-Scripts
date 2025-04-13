"local Players = game:GetService(\"Players\")\nlocal player = game.Players.LocalPlayer\nlocal UserInputService = game:GetService(\"UserInputService\")\nlocal RunService = game:GetService(\"RunService\")\nlocal ContextActionService = game:GetService(\"ContextActionService\")\nlocal character = player.Character or player.CharacterAdded:Wait()\nlocal fzAnim = Instance.new(\"Animation\")\nfzAnim.AnimationId = \"rbxassetid://117339039533356\"\n--rounding system for cooldowns\nfunction roundNumber(num, numDecimalPlaces)\n  return tonumber(string.format(\"%.\" .. (numDecimalPlaces or 0) .. \"f\", num))\nend\n------\nlocal tpAnim = Instance.new(\"Animation\")\ntpAnim.AnimationId = \"rbxassetid://84260460113659\"\n\n\nlocal SecondLifeUsed = false\n\nlocal tpSFX = Instance.new(\"Sound\")\ntpSFX.SoundId = \"rbxassetid://84260460113659\"  \ntpSFX.Volume = 1.45 \ntpSFX.Parent = player:WaitForChild(\"PlayerGui\")  \n\nlocal abilitySound = Instance.new(\"Sound\")\nabilitySound.SoundId = \"rbxassetid://100981628806546\" \nabilitySound.Volume = 1.45  \nabilitySound.Parent = player:WaitForChild(\"PlayerGui\")  \n\nlocal savedPosition = nil\nlocal isFrozen = false\nlocal canTeleport = false \nlocal AbilityContainer = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild(\"AbilityContainer\")\nlocal AbilityTemplate = game.ReplicatedStorage.Assets.UI.AbilityIcon\n\nlocal Stabs = 0\n\nif not AbilityContainer then \n    warn(\"Not a survivor/killer!\") \n    return\n    end\n\n\n\nlocal crouching = false\nlocal Helpless = false\nlocal Ability1 = AbilityTemplate:Clone()\nAbility1.Parent = AbilityContainer\nAbility1.Name = \"RitualDagger\"\nAbility1.AbilityName.Text = \"Ritual Dagger\"\nAbility1.KeybindName.Text = \"Q + Crouching\"\nAbility1.Image = \"rbxassetid://119937664437884\"\nAbility1.Clipping.Top.Image = \"rbxassetid://119937664437884\"\nlocal Ability2 = AbilityTemplate:Clone()\nAbility2.Parent = AbilityContainer\nAbility2.Name = \"Crouch\"\nAbility2.AbilityName.Text = \"Crouch\"\nAbility2.KeybindName.Text = \"E\"\nAbility2.Image = \"rbxassetid://119937664437884\"\nAbility2.Clipping.Top.Image = \"rbxassetid://119937664437884\"\nlocal Ability3 = AbilityTemplate:Clone()\nAbility3.Name = \"Ritual\"\nAbility3.Parent = AbilityContainer\nAbility3.AbilityName.Text = \"Ritual\"\nAbility3.KeybindName.Text = \"R\"\nAbility3.Image = \"rbxassetid://119937664437884\"\nAbility3.Clipping.Top.Image = \"rbxassetid://119937664437884\"\nlocal RunningToggle = character.SpeedMultipliers.Sprinting\nlocal FOVToggle = character.FOVMultipliers.Sprinting\n--StaminaDrain toggle\n    local function staminadrainono(state)\n\n        stam = state\n\n        local stamscript = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)\n\n        \n\n        local connection\n\n        connection = game:GetService(\"RunService\").Heartbeat:Connect(function()\n\n            if not stam then\n\n                connection:Disconnect()\n\n                stamscript.StaminaLossDisabled = nil\n\n                return\n\n            end\n\n            stamscript.StaminaLossDisabled = function() \n\n            end\n\n        end)\n\n    end \n--CHARGES SYSTEM\ntask.spawn(function()\nwhile task.wait() do\n  if crouching then\n    \n    RunningToggle.Parent = character\n    FOVToggle.Parent = character\n  else\n    RunningToggle.Parent = character.SpeedMultipliers\n    FOVToggle.Parent = character.FOVMultipliers\n\n  end\n  if player.PlayerGui.MainUI.StatusContainer:FindFirstChild(\"Helpless\") then\n   Helpless = true\n  else\n   Helpless = false\n  end\n  if #game.workspace.Players.Survivors:GetChildren() > 1 then\n    if Stabs ~= 69 then\n  Ability3.Charges.Text = Stabs\n  if Stabs >= 3 then\n    Ability3.Clipping.Top.Image = \"rbxassetid://119937664437884\"\n  else\n  Ability3.Clipping.Top.Image = \"rbxassetid://94600191802783\"\n  end\n   else\n   Ability3.Charges.Text = 0 \n   Ability3.Clipping.Top.Image = \"rbxassetid://94600191802783\"\n   end\n  else\n   Stabs = 69\n   SecondLifeUsed = true\n      Ability3.Charges.Text = 0 \n   Ability3.Clipping.Top.Image = \"rbxassetid://94600191802783\"\n  end\nend\nend)\n--CHARGES SYSTEM\nlocal humanoid = character:WaitForChild(\"Humanoid\")\nlocal mouse = player:GetMouse()\n\n\n\n-- AnimationIDs\nlocal introAnim = Instance.new(\"Animation\")\nintroAnim.AnimationId = \"rbxassetid://98606150731314\"\n\nlocal loopAnim = Instance.new(\"Animation\")\nloopAnim.AnimationId = \"rbxassetid://74530436512522\"\n\nlocal walkAnim = Instance.new(\"Animation\")\nwalkAnim.AnimationId = \"rbxassetid://94721495253171\"\n\nlocal runAnim = Instance.new(\"Animation\")\nrunAnim.AnimationId = \"rbxassetid://93499989310243\"\n\nlocal slashAnim = Instance.new(\"Animation\")\nslashAnim.AnimationId = \"rbxassetid://119256819262245\"\n\nlocal m1Anim = Instance.new(\"Animation\")\nm1Anim.AnimationId = \"rbxassetid://119256819262245\"\n\n--Debounces\nlocal crouchDebounce = false\nlocal knifeDebounce = false\nlocal ritualDebounce = false\n-- Tracks and state\nlocal loopTrack\nlocal walkTrack\nlocal runTrack\nlocal walkRunConnection\nlocal active = false\nlocal rootPart = character:WaitForChild(\"HumanoidRootPart\")\nlocal runningDisabled = false\n\n\n-- Function to play an animation\nlocal function playAnimation(animation)\n    local animator = humanoid:FindFirstChildOfClass(\"Animator\")\n    if animator then\n        local animationTrack = animator:LoadAnimation(animation)\n        animationTrack:Play()\n        return animationTrack\n    end\nend\n\n-- Function to freeze the player\nlocal function freezePlayer()\n    isFrozen = true\n    -- Bind an action that sinks all inputs, effectively freezing the player\n    ContextActionService:BindAction(\n        \"FreezeMovement\",\n        function() return Enum.ContextActionResult.Sink end,\n        false,\n        unpack(Enum.PlayerActions:GetEnumItems())\n    )\nend\n--NO RUN WHILE CROUCHING\n--insert noo run script here\n--NO RUN WHILE CROUCHING\n-- Function to unfreeze the player\nlocal function unfreezePlayer()\n    isFrozen = false\n    -- Unbind the action to allow player movement again\n    ContextActionService:UnbindAction(\"FreezeMovement\")\nend\n-- Helper to stop all ability animations and reset WalkSpeed\nlocal function stopAbilityAnims()\n\tif loopTrack then loopTrack:Stop() end\n\tif walkTrack then walkTrack:Stop() end\n\tif runTrack then runTrack:Stop() end\n\tif walkRunConnection then walkRunConnection:Disconnect() end\n\t-- When ability ends, set WalkSpeed to normalSpeed\n\thumanoid.WalkSpeed = normalSpeed\nend\n\n-- Check if near a player\nlocal function getNearbyPlayer(range)\n\tfor _, target in pairs(Players:GetPlayers()) do\n\t\tif target ~= player and target.Character and target.Character:FindFirstChild(\"HumanoidRootPart\") then\n\t\t\tlocal distance = (character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude\n\t\t\tif distance \u003C= range then\n\t\t\t\treturn target\n\t\t\tend\n\t\tend\n\tend\n\treturn nil\nend\n--SWING FUNCTION\nlocal function swing()\nlocal hitbox = Instance.new(\"Part\")\nhitbox.Material = Enum.Material.ForceField\nhitbox.Size = Vector3.new(6, 5, 6)\nhitbox.Color = Color3.fromRGB(255, 0, 0)\nhitbox.Name = \"StabHitbox\"\nhitbox.Parent = workspace\nhitbox.CanCollide = false\nhitbox.Anchored = true\nlocal BodyVel = Instance.new(\"BodyVelocity\")\nBodyVel.Parent = character.HumanoidRootPart\nBodyVel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)\nBodyVel.Velocity = character.HumanoidRootPart.CFrame.LookVector * 80\ngame.Debris:AddItem(BodyVel, 0.1)\ngame.Debris:AddItem(hitbox, 0.25)\ntask.spawn(function()\nwhile hitbox do\n   task.wait()\n   hitbox.CFrame = character.HumanoidRootPart.CFrame\nend\nend)\nlocal hbdebounce = false\nhitbox.Touched:Connect(function(hit)\nif hbdebounce == true then return end\nif hit.Parent:FindFirstChild(\"Humanoid\") and hit.Parent.Parent ~= workspace.Players.Survivors then\nhbdebounce = true\nif BodyVel then\n  BodyVel:Destroy()\nend\nlocal fakehbx = hitbox:Clone()\nhitbox:Destroy()\nfakehbx.Parent = workspace\nfakehbx.Color = Color3.fromRGB(0, 255, 0)\ngame.Debris:AddItem(fakehbx, 1)\nif Stabs \u003C 3 then\nStabs += 1\nend\nprint(\"Hit killer!\")\nend\nend)\nend\n--SWING FUNCTION\n-- Behind check: if you're behind the target, the vector from the target to you\n-- will be nearly opposite to the target's LookVector (dot product close to -1).\nlocal function isBehindTarget(target)\n\tlocal targetHRP = target.Character and target.Character:FindFirstChild(\"HumanoidRootPart\")\n\tlocal myHRP = character:FindFirstChild(\"HumanoidRootPart\")\n\tif not targetHRP or not myHRP then \n\t\treturn false \n\tend\n\t\n\tlocal toAttacker = (myHRP.Position - targetHRP.Position).Unit\n\tlocal targetLook = targetHRP.CFrame.LookVector\n\tlocal dot = toAttacker:Dot(targetLook)\n\tprint(\"Slash Attempt - Dot product for\", target.Name, \":\", dot)\n\treturn dot \u003C -0.5\nend\n\n-- Ability Activation using the E key\n\nUserInputService.InputBegan:Connect(function(input, gp)\n\tif gp then return end\n    if crouchDebounce then return end\n    if Helpless then return end\n    if character.Humanoid.Health \u003C= 0 then return end\n\tif input.KeyCode == Enum.KeyCode.E then\n\t\tactive = true\n        task.spawn(function()\n        crouchDebounce = true\n        Ability2.Clipping.Top.Visible = false\n        for i = 1,60 do \n          Ability2.CooldownTime.Text = roundNumber(6 - i / 10, 1)\n          task.wait(0.1)\n        end\n        crouchDebounce = false\n        Ability2.CooldownTime.Text = \"\"\n        Ability2.Clipping.Top.Visible = true\n        end)\n\t\tif crouching == false then\n            crouching = true\n            \n\t\t-- Set WalkSpeed to sprintSpeed (since \"I'm not slow\")\n\t\thumanoid.WalkSpeed = sprintSpeed\n\n\t\t-- Play intro animation\n\t\tlocal introTrack = humanoid:LoadAnimation(introAnim)\n\t\tintroTrack:Play()\n        freezePlayer()\n\t\tintroTrack.Stopped:Wait()\n        task.wait(0.15)\n        unfreezePlayer()\n\t\t-- Start loop animation\n\t\tloopTrack = humanoid:LoadAnimation(loopAnim)\n\t\tloopTrack.Looped = true\n\t\tloopTrack:Play()\n\n\t\t-- Walk/Run animation logic (using current crouched speed, here sprintSpeed)\n\t\twalkRunConnection = RunService.RenderStepped:Connect(function()\n\t\t\tif not active then return end\n\t\t\tlocal moveDir = humanoid.MoveDirection.Magnitude\n\n\t\t\tif moveDir > 0 then\n\t\t\t\tif not walkTrack or not walkTrack.IsPlaying then\n\t\t\t\t\tif runTrack then runTrack:Stop() end\n\t\t\t\t\twalkTrack = humanoid:LoadAnimation(walkAnim)\n\t\t\t\t\twalkTrack:Play()\n\t\t\t\tend\n\t\t\telse\n\t\t\t\tif walkTrack then walkTrack:Stop() end\n\t\t\t\tif runTrack then runTrack:Stop() end\n\t\t\tend\n\t\tend)\n    else\n    \n    crouching = false\n    active = false\n    stopAbilityAnims()\n    end\n\tend\nend)\n\n\n-- Slash with behind check (exits ability if conditions are not met)\nUserInputService.InputBegan:Connect(function(input, gp)\n\tif gp then return end\n    if Helpless then return end\n    if knifeDebounce then return end\n    if character.Humanoid.Health \u003C= 0 then return end\n\tif input.KeyCode == Enum.KeyCode.Q and active then\n        task.spawn(function()\n        knifeDebounce = true\n         Ability1.Clipping.Top.Visible = false\n         for i = 1,5 do\n          Ability1.CooldownTime.Text = 15 - i\n          task.wait(1)\n         end\n        for i = 1,100 do \n          Ability1.CooldownTime.Text = roundNumber(10 - i / 10, 1)\n          task.wait(0.1)\n        end\n        knifeDebounce = false\n        Ability1.CooldownTime.Text = \"\"\n        Ability1.Clipping.Top.Visible = true\n        end)\n\t\t\tstopAbilityAnims()\n            local slashTrack = humanoid:LoadAnimation(slashAnim)\n\t\t\tslashTrack:Play()\n            crouching = false\n\t\t\tactive = false\n            task.wait(0.5)\n            \t\t\tstopAbilityAnims()\n                        crouching = false\n\t\t\tactive = false\n            swing()\n\tend\nend)\n\n\n-- R Key: Save position, play freeze animation and sound, and freeze movement\nUserInputService.InputBegan:Connect(function(input, gameProcessed)\n    if gameProcessed then return end\n    if crouching then return end\n    if Helpless then return end\n    if character.Humanoid.Health \u003C= 0 then return end\n    if input.KeyCode == Enum.KeyCode.R and not isFrozen and Stabs >= 3 and SecondLifeUsed == false and Stabs ~= 69 then\n        Stabs = 69\n\n        savedPosition = rootPart.Position  -- Save current position\n        freezePlayer()  -- Freeze the player\n        local freezeTrack = playAnimation(fzAnim)\n  -- Play the freeze sound\n        abilitySound:Play()  -- Play the ability sound\n        if freezeTrack then\n            freezeTrack.Stopped:Wait()  -- Wait for the animation to finish\n            unfreezePlayer()  -- Unfreeze the player after animation finishes\n        end\n        canTeleport = true  -- Allow teleport after pressing B\n        print(\"Position saved:\", savedPosition)\n    end\nend)\n\n-- N Key: Teleport back to the saved position, play teleport animation and sound, but allow movement after teleport\n--[[Backup: UserInputService.InputBegan:Connect(function(input, gameProcessed)\n    if gameProcessed then return end\n    if input.KeyCode == Enum.KeyCode.N and savedPosition and canTeleport then\n         SecondLifeUsed = true\n        rootPart.CFrame = CFrame.new(savedPosition)  -- Teleport to saved position\n        print(\"Teleported back to:\", savedPosition)\n        playAnimation(tpAnim)  -- Play teleport animation\n        tpSFX:Play()  -- Play teleport sound\n        canTeleport = false  -- Disable teleport until B is pressed again\n    end\nend)]]--\ncharacter.Humanoid.HealthChanged:Connect(function()\nif character.Humanoid.MaxHealth == 40 or character.Humanoid.MaxHealth == 110 then\n    if SecondLifeUsed then return end\n   SecondLifeUsed = true\n   if savedPosition then\n        rootPart.CFrame = CFrame.new(savedPosition)  -- Teleport to saved position\n        print(\"Teleported back to:\", savedPosition)\n        playAnimation(tpAnim)  -- Play teleport animation\n        tpSFX:Play()  -- Play teleport sound\n        canTeleport = false  -- Disable teleport until B is pressed again\n   else\n    game.Players.LocalPlayer.Character.Humanoid.Health = 0\n   end\nend\nend)"