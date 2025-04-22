local char
	char = game.Players.LocalPlayer.Character

for i,v in pairs(char.Life1:GetChildren()) do
	if v:IsA("BasePart") then
		v:Destroy()
	end
end
if char:FindFirstChild("Life2") then
	for i,v in pairs(char.Life2:GetChildren()) do
	if v:IsA("BasePart") then
		v:Destroy()
	end
    end
end

for i,v in pairs(char:GetChildren()) do
	if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not string.find(v.Name, "Hitbox") and not string.find(v.Name, "Holder") then
		v.Transparency = 0
		v.Color = Color3.fromRGB(255, 255, 255)
	end
end
--Clothes
local Shirt = Instance.new("Shirt")
Shirt.Parent = char
Shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=94974220498237"
char.Torso.Color = Color3.fromRGB(105, 102, 92)
local Pants = Instance.new("Pants")
Pants.Parent = char
Pants.PantsTemplate = "http://www.roblox.com/asset/?id=3267139027"
--Accessories
local Hat = game:GetObjects(7168334659)

local HatC0 = CFrame.new(0, 1.25, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hat) do
	v.Parent = char
	local HatWeld = Instance.new("Weld")
	HatWeld.Parent = v.Handle
	HatWeld.Part0 = char.Head
	HatWeld.Part1 = v.Handle
	HatWeld.C0 = HatC0
end
local Hair = game:GetObjects(12281536963)

local HairC0 = CFrame.new(0.200000003, -0.0700000003, 0.25, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Hair) do
	v.Parent = char
	local HairWeld = Instance.new("Weld")
	HairWeld.Parent = v.Handle
	HairWeld.Part0 = char.Head
	HairWeld.Part1 = v.Handle
	HairWeld.C0 = HairC0
end
local Eyes = game:GetObjects(13904713247)

local EyesC0 = CFrame.new(0, 0.359999985, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Eyes) do
	v.Parent = char
	local EyesWeld = Instance.new("Weld")
	EyesWeld.Parent = v.Handle
	EyesWeld.Part0 = char.Head
	EyesWeld.Part1 = v.Handle
	EyesWeld.C0 = EyesC0
end
local Scarf = game:GetObjects(138389347588090)

local ScarfC0 = CFrame.new(0, -0.700000346, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
for i,v in pairs(Scarf) do
	v.Parent = char
	local ScarfWeld = Instance.new("Weld")
	ScarfWeld.Parent = v.Handle
	ScarfWeld.Part0 = char.Head
	ScarfWeld.Part1 = v.Handle
	ScarfWeld.C0 = ScarfC0
end











--functions
char.ChildAdded:Connect(function(v)
if v.Name == "Life2" then
	for i,b in pairs(v:GetChildren()) do
	if b:IsA("BasePart") then
		 		b.Transparency = 1
	end
	end
end	
end)
