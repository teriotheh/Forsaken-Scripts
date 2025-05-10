
local statusModule = {}
local player = game.Players.LocalPlayer
local StatusTemplate = game.ReplicatedStorage.Modules.Statuses.StatusDisplay
function Format(Int)
	return string.format("%02i", Int)
end
numberMap = {
    {1000, 'M'},
    {900, 'CM'},
    {500, 'D'},
    {400, 'CD'},
    {100, 'C'},
    {90, 'XC'},
    {50, 'L'},
    {40, 'XL'},
    {10, 'X'},
    {9, 'IX'},
    {5, 'V'},
    {4, 'IV'},
    {1, 'I'}
    
}
function intToRoman(num)
    local roman = ""
    while num > 0 do
        for index,v in pairs(numberMap)do 
            local romanChar = v[2]
            local int = v[1]
            while num >= int do
                roman = roman..romanChar
                num = num - int
            end
        end
    end
    return roman
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

function statusModule.giveSpeed(_, timey, power)
task.spawn(function()
task.spawn(function()
addStatusEffect("Speed", intToRoman(power), timey)
end)
local SpeedStatus = Instance.new("NumberValue")
SpeedStatus.Parent = game.Players.LocalPlayer.Character.SpeedMultipliers
SpeedStatus.Value = 1 + power / 10
SpeedStatus.Name = "SpeedStatus-Artificial"
game.Debris:AddItem(SpeedStatus, timey)
end)
end


return statusModule
