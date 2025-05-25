local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function onCharacterAdded(char)
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("CharacterMesh") then
            child:Destroy()
        end
    end
end
lp.CharacterAdded:Connect(onCharacterAdded)

local assetIds = {
    "rbxassetid://12727615776",
    "rbxassetid://12727617721",
	"rbxassetid://17174244399",
	"rbxassetid://93001472528329",
	"rbxassetid://98573986433879"
}
local loadedAssets = {}

for _, id in ipairs(assetIds) do
    local objects = game:GetObjects(id)
    if #objects > 0 then
        table.insert(loadedAssets, objects[1])
    end
end

local function removeExistingItems(char)
    for _, accessory in ipairs(char:GetChildren()) do
        if accessory:IsA("Accessory") then
            accessory:Destroy()
        end
    end
    local shirt = char:FindFirstChildOfClass("Shirt")
    if shirt then shirt:Destroy() end
    local pants = char:FindFirstChildOfClass("Pants")
    if pants then pants:Destroy() end
end

local function equipAccessory(char, accessory)
    local clonedAccessory = accessory:Clone()
    local handle = clonedAccessory:FindFirstChild("Handle")
    if not handle then return end
    local handleAttachment = handle:FindFirstChildOfClass("Attachment")
    if not handleAttachment then
        local fallbackAttachment = Instance.new("Attachment")
        fallbackAttachment.Name = "HatAttachment"
        fallbackAttachment.CFrame = accessory.AttachmentPoint or CFrame.new()
        fallbackAttachment.Parent = handle
        handleAttachment = fallbackAttachment
    end
    local matched = false
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("Attachment") and part.Name == handleAttachment.Name then
            handle.CFrame = part.CFrame:ToWorldSpace(handleAttachment.CFrame:Inverse())
            local weld = Instance.new("Weld")
            weld.Part0 = part.Parent
            weld.Part1 = handle
            weld.C0 = part.CFrame
            weld.C1 = handleAttachment.CFrame
            weld.Parent = handle
            matched = true
            break
        end
    end
    if not matched then
        local fallbackPart = char:FindFirstChild("Head") 
            or char:FindFirstChild("UpperTorso") 
            or char:FindFirstChild("Torso") 
            or char:FindFirstChildWhichIsA("BasePart")
        if fallbackPart then
            handle.CFrame = fallbackPart.CFrame
            local weld = Instance.new("Weld")
            weld.Part0 = fallbackPart
            weld.Part1 = handle
            weld.C0 = CFrame.new()
            weld.C1 = CFrame.new()
            weld.Parent = handle
        end
    end
    clonedAccessory.Parent = char
end

local function makePlayerWhite(char)
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.BrickColor = BrickColor.new("White")
        end
    end
end

local function setup()
    local char = lp.Character or lp.CharacterAdded:Wait()
    task.wait(1)
    removeExistingItems(char)
    makePlayerWhite(char)
    for _, asset in ipairs(loadedAssets) do
        if asset:IsA("Accessory") then
            equipAccessory(char, asset)
        elseif asset:IsA("Shirt") or asset:IsA("Pants") then
			local cloth = Instance.new(asset.ClassName)
			cloth.Parent = char
			cloth[asset.ClassName.."Template"] = asset[asset.ClassName.."Template"]
		end
    end
end
setup()
local character = game.Players.LocalPlayer.Character
local usingSkin = true
for i,v in pairs(character.Life1:GetChildren()) do
	v.Transparency = 1
end
for i,v in pairs(character:GetChildren()) do
	if v:IsA("Part") and v.Name ~= "HumanoidRootPart" and v.Name ~= "VisibilityDetector" then
		v.Transparency = 0
	end
end
local Life2Wings = character:FindFirstChild("Accessory (WingsAccessory)")
Life2Wings.Handle.Weld.Part0 = character.Torso
Life2Wings.Handle.Weld.C0 = CFrame.new(0, 1, 1.25, 1, 0, 0, 0, 1, 0, 0, 0, 1)
local Life2Face = character:FindFirstChild("Accessory (Spicebush_Head)")
local Overcoat = character:FindFirstChild("Accessory (YiSangAccessory)")
Overcoat.Handle.Weld.C0 = CFrame.new(0, -0.899999976, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1)

task.spawn(function()
while usingSkin do
	task.wait()
	if character:FindFirstChild("Life2") then
		for i,v in pairs(character:FindFirstChild("Life2"):GetDescendants()) do
			if v:IsA("BasePart") then v.Transparency = 1 elseif v:IsA("Decal") then v.Transparency = 1 elseif v:IsA("ParticleEmitter") then v:Destroy() end
		end
       Life2Wings.Handle.Transparency = 0
	   Life2Face.Handle.Transparency = 0
	else
       Life2Wings.Handle.Transparency = 1
	   Life2Face.Handle.Transparency = 1
	end
	character.Life1.Head.hair.Transparency = 0
	character.ExpressionHolder.Expression.Texture = "rbxassetid://93421870784694"
	local Highlight = Instance.new("Highlight")
	Highlight.Parent = character.GhostFire.GhostfireBlade
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.FillColor = Color3.fromRGB(0, 0, 0)
	Highlight.FillTransparency = 0
	character.Life1.Head.hair.Color = Color3.fromRGB(0, 0, 0)
	character.Life1.Head.hair.Material = Enum.Material.SmoothPlastic
end
end)
lp.CharacterRemoving:Connect(function()
if usingSkin then
   usingSkin = false
end
end)
