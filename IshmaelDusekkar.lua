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
    "rbxassetid://92622201093404",
    "rbxassetid://18588497876",
    "rbxassetid://18268134050",
    "rbxassetid://18268128313"
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
character.Head.Plasma:ClearAllChildren()
character.Head.Transparency = 0
character.Staff.Joint.C0 = CFrame.new(0, -1, 0, -0.0199960023, -0.999800205, 0, 0, 0, -1, 0.999800086, -0.0199924167, 0)
character.Staff.Mesh.MeshId = "rbxassetid://18290010577"
character.Staff.Mesh.TextureId = "rbxassetid://18274213192"
character.Staff.Mesh.Scale = Vector3.new(1.15, 1.15, 1.15)
local charMesh = Instance.new("CharacterMesh")
charMesh.Parent = character
charMesh.BodyPart = Enum.BodyPart.Torso
charMesh.MeshId = "48112070"
