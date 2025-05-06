for _, part in pairs(game.Workspace:GetDescendants()) do
    if part.Name == "DoorSystem" then
        part:Destroy()
    end
end
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local currentTargetATM = nil
local atmEspConnection
local ATMModule = require(game.ReplicatedStorage.Modules.Game.ATM.ATM)

local function updateHighlight(model, isActive)
    local existing = CoreGui:FindFirstChild("ATMESP_" .. model:GetDebugId())
    if not existing then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ATMESP_" .. model:GetDebugId()
        highlight.Adornee = model
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0
        highlight.Parent = CoreGui
        existing = highlight
    end

    if model == currentTargetATM then
        existing.FillColor = Color3.fromRGB(168, 2, 255) -- สีแดงคือเป้าหมายกำลังจะไปหา
    else
        existing.FillColor = isActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end
    existing.FillTransparency = 0.5
end

local function clearESP()
    for _, obj in ipairs(CoreGui:GetChildren()) do
        if obj:IsA("Highlight") and obj.Name:match("^ATMESP_") then
            obj:Destroy()
        end
    end
end

local function drawESP()
    for _, atm in ipairs(Workspace.Map.Props:GetChildren()) do
        if atm.Name == "ATM" then
            local isActive = false
            for _, obj in ATMModule.class.objects do
                if obj.instance == atm then
                    isActive = not obj.states.disabled:get()
                    break
                end
            end
            updateHighlight(atm, isActive)
        end
    end
end

atmEspConnection = RunService.RenderStepped:Connect(function()
    pcall(drawESP)
end)

local ATMModule = require(game.ReplicatedStorage.Modules.Game.ATM.ATM)
local Net = require(game.ReplicatedStorage.Modules.Core.Net)
local ItemUtils = require(game.ReplicatedStorage.Modules.Game.Inventory.ItemUtils)
local Data = require(game.ReplicatedStorage.Modules.Core.Data)
local HackTools = require(game.ReplicatedStorage.Modules.Game.ATM.ATMUI).valid_hack_tools
local Char = require(game.ReplicatedStorage.Modules.Core.Char)
local HRP = Char.get_hrp
local LocalPlayer = game.Players.LocalPlayer
local DelayBetweenHacks = 1
local AutoWinDelay = 1 
AutoFarm = true
-- task.spawn(function()
    -- while true do
        -- pcall(function()
            -- if AutoFarm then
                -- for _, atm in ATMModule.class.objects do
                    -- local model = atm.instance
                    -- if model and model:IsDescendantOf(workspace) then
                        -- local isDisabled = atm.states.disabled:get()
                        -- local isBeingHacked = atm.states.hacker:get() ~= nil
                        -- local distance = (HRP().Position - model:GetPivot().Position).Magnitude
                        -- if not isDisabled and not isBeingHacked and distance < 15 then
                            -- local validTool = nil
                            -- for _, tool in HackTools do
                                -- local toolName = tool.Name
                                -- if ItemUtils.get_item_count(Data, "misc", toolName) > 0 then
                                    -- validTool = toolName
                                    -- break
                                -- end
                            -- end
                            -- if validTool then
                                -- Net.send("request_begin_hacking_2", model, validTool)
                                -- task.wait(AutoWinDelay) -- 💡 Delay antes del auto-win
                                -- Net.send("atm_win_2", model)
                                -- task.wait(DelayBetweenHacks)
                            -- end
                        -- end
                    -- end
                -- end
            -- end
        -- task.wait(0.1)
        -- end)
    -- end
-- end)
function hackxxccc()
        pcall(function()
            for _, atm in ATMModule.class.objects do
                local model = atm.instance
                if model and model:IsDescendantOf(workspace) then
                    local isDisabled = atm.states.disabled:get()
                    local isBeingHacked = atm.states.hacker:get() ~= nil
                    local distance = (HRP().Position - model:GetPivot().Position).Magnitude
                    if not isDisabled and not isBeingHacked and distance < 15 then
                        local validTool = nil
                        for _, tool in HackTools do
                            local toolName = tool.Name
                            if ItemUtils.get_item_count(Data, "misc", toolName) > 0 then
                                validTool = toolName
                                break
                            end
                        end
                        if validTool then
                            Net.send("request_begin_hacking_2", model, validTool)
                            task.wait(AutoWinDelay) -- 💡 Delay antes del auto-win
                            Net.send("atm_win_2", model)
                        end
                    end
                end
            end
    end)
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local ATMModule = require(game.ReplicatedStorage.Modules.Game.ATM.ATM)
local Net = require(game.ReplicatedStorage.Modules.Core.Net)
local ItemUtils = require(game.ReplicatedStorage.Modules.Game.Inventory.ItemUtils)
local Data = require(game.ReplicatedStorage.Modules.Core.Data)
local HackTools = require(game.ReplicatedStorage.Modules.Game.ATM.ATMUI).valid_hack_tools
local Char = require(game.ReplicatedStorage.Modules.Core.Char)
local HRP = Char.get_hrp
local LocalPlayer = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local previousATM = nil
local text = game:GetService("Players").LocalPlayer.PlayerGui.TopRightHud.Holder.Frame.MoneyTextLabel.Text
local numberOnly = string.match(text, "%d+")

local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local c, h, hrp



local function upd()
    c = p.Character or p.CharacterAdded:Wait()
    h = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
end

upd()
p.CharacterAdded:Connect(function()
    evading = false
    upd()
end)

local evading = false

rs.RenderStepped:Connect(function()
    pcall(function()
        if not c or not h or not hrp then return end
        if h.Health <= 29 and not evading then
            evading = true
            local pos = hrp.Position
            local y = pos.Y - 5
            task.spawn(function()
                while h.Health < 29 and h.Parent do
                    local off = Vector3.new(math.random(-40,40),0,math.random(-40,40))
                    local dir = (pos + off - hrp.Position).Unit
                    hrp.Velocity = dir * math.random(10,25) * 10
                    hrp.CFrame = CFrame.new(hrp.Position.X, y, hrp.Position.Z)
                    task.wait(0.01)
                end
                evading = false
            end)
        end
    end)
end)

local Window = Fluent:CreateWindow({
    Title = "BLOCK SPIN" .. Fluent.Version,
    SubTitle = "by k-hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(470, 350),
    Acrylic = true,  -- ใช้พื้นหลังแบบโปร่งใส
    Theme = "Amethyst",  -- กำหนดธีม
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "align-justify" }),
}
local Dropdown1 = Tabs.Main:AddDropdown("Bicycle", {
    Title = "Bicycle",
    Values = {"BMX","EScooter"},
    Multi = false,
    Default = "BMX"
})

local Dropdown = Tabs.Main:AddDropdown("HackTool", {
    Title = "HackTool",
    Values = {"HackToolBasic","HackToolPro","HackToolUltimate"},
    Multi = false,
    Default = "HackToolBasic"
})



Dropdown:OnChanged(function(value)
    HackTool = value
end)
Dropdown1:OnChanged(function(value)
    Bicycle = value
end)

local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

local hoverHeight = 3
local speed = 64
local maxSlope = 45
_G.autoDrivePrompt = true

function buy_chip(chip, loop)
    for i = 1, loop do
        Net.send("purchase_consumable", workspace:WaitForChild("ShopZone_Illegal"), chip)
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local id = player.UserId

local function SitInCar()
    local vehiclesFolder = workspace:WaitForChild("Vehicles")
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    for _, v in pairs(vehiclesFolder:GetChildren()) do
        local ownerId = v:GetAttribute("OwnerUserId")
        if ownerId == id then
            local seat = v:FindFirstChild("DriverSeat", true)
            if seat and seat:IsA("VehicleSeat") and seat.Occupant == nil then
                local distance = (seat.Position - rootPart.Position).Magnitude
                if distance > 15 then
                    v:SetPrimaryPartCFrame(CFrame.new(rootPart.Position + Vector3.new(0, 3, -5)))
                    wait(0.5)
                end
                seat:Sit(humanoid)
                print("ขึ้นรถเรียบร้อย")
                break
            end
        end
    end
end
spawn(function()
    local vehiclesFolder = workspace:WaitForChild("Vehicles")
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    while true do wait()
        pcall(function()
            for _, v in pairs(vehiclesFolder:GetChildren()) do
                local ownerId = v:GetAttribute("OwnerUserId")
                if ownerId == id then
                    local seat = v:FindFirstChild("DriverSeat", true)
                    if seat and seat:IsA("VehicleSeat") and seat.Occupant == nil then
                        local distance = (seat.Position - rootPart.Position).Magnitude
                        if distance > 15 then
                            v:SetPrimaryPartCFrame(CFrame.new(rootPart.Position + Vector3.new(0, 3, -5)))
                        end
                    end
                end
            end
        end)
    end 
end)
local function exitCar()
    local vehiclesFolder = workspace:WaitForChild("Vehicles")

    for _, v in pairs(vehiclesFolder:GetChildren()) do
        local ownerId = v:GetAttribute("OwnerUserId")
        if ownerId == id then
            local seat = v:FindFirstChild("DriverSeat", true)
            if seat and seat:IsA("VehicleSeat") and seat.Occupant then
                if seat.Occupant == humanoid then
                    humanoid.Sit = false
                    print("ลงรถเรียบร้อย")
                    break
                end
            end
        end
    end
end


local function moveModelSmoothly(model, currentPos, targetPos, previousDir, finalTargetPos)
    if not model or not model.Parent then return end

    local direction = (targetPos - currentPos)
    if direction.Magnitude == 0 then return end
    direction = Vector3.new(direction.X, 0, direction.Z).Unit
    local targetCFrame = CFrame.lookAt(targetPos, targetPos + direction)

    local angleMultiplier = 1
    if previousDir then
        local dot = previousDir:Dot(direction)
        local angle = math.acos(math.clamp(dot, -1, 1))
        angleMultiplier = 1 + (angle / math.pi)
    end

    local adjustedSpeed = speed

    local dummy
    local success, err = pcall(function()
        dummy = Instance.new("Part")
        dummy.Anchored = true
        dummy.CanCollide = false
        dummy.Transparency = 1
        dummy.Size = Vector3.new(1, 1, 1)
        dummy.CFrame = model:GetPivot()
        dummy.Name = "K_Hub_Dummy"
        dummy.Parent = workspace
    end)

    if not success or not dummy or not dummy.Parent then
        warn("สร้าง dummy Part ไม่สำเร็จ:", err)
        return
    end

    local distance = (dummy.Position - targetPos).Magnitude
    local tweenTime = (distance / adjustedSpeed) * angleMultiplier
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(dummy, tweenInfo, {CFrame = targetCFrame})

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if model and model.Parent and dummy and dummy.Parent then
            local ok, err = pcall(function()
                model:PivotTo(dummy.CFrame)
            end)
            if not ok then warn("PivotTo ล้มเหลว:", err) end
        else
            if conn then conn:Disconnect() end
        end
    end)

    tween:Play()
    tween.Completed:Wait()

    if conn then conn:Disconnect() end
    if dummy and dummy.Parent then dummy:Destroy() end

    return direction
end

-- ฟังก์ชันเดินไปตาม path
local function moveToDestinationbuy(model, destination, chip)
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
        AgentMaxSlope = maxSlope
    })

    path:ComputeAsync(model:GetPivot().Position, destination)

    if path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        for i = 1, #waypoints do
            local current = waypoints[i]
            local targetPos = current.Position + Vector3.new(0, hoverHeight, 0)
            local currentPos = model:GetPivot().Position
            moveModelSmoothly(model, currentPos, targetPos)
        end
        buy_chip(chip, 6)
        task.wait(2.5)
    else
        warn("Path สร้างไม่สำเร็จ")
    end
end


spawn(function()
	while _G.autoDrivePrompt do wait()
		pcall(function()
			for i,v in pairs(workspace.Vehicles:GetDescendants()) do
				if v.Name == "DrivePrompt" then
					v.HoldDuration = 0
					v.KeyboardKeyCode = Enum.KeyCode.X
				end
			end
		end)
	end
end)

local function pressE()
	pcall(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
		wait(0.1)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
	end)
end

local function pressX()
	pcall(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
		wait(0.1)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
	end)
end
local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local c, h, hrp

local function upd()
    c = p.Character or p.CharacterAdded:Wait()
    h = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
end

upd()
p.CharacterAdded:Connect(function()
    evading = false
    upd()
end)

function deposit()
    local text = game:GetService("Players").LocalPlayer.PlayerGui.TopRightHud.Holder.Frame.MoneyTextLabel.Text
    local numberOnly = tonumber(string.match(text, "%d+"))
    if numberOnly and numberOnly > 2100 then
        local amountToDeposit = numberOnly - 2100
        Net.send("transfer_funds", "hand", "bank", amountToDeposit)
    end
end

local evading = false
local function moveToDestination(model, destination)
	pcall(function()
		local MAX_ATTEMPTS = 5
		local ATTEMPT_RADIUS = 5
		local ROTATION_INCREMENT = 10 -- หมุนทีละ 10 องศา
		local MAX_ROTATION = 360

		for attempt = 1, MAX_ATTEMPTS do
			local hrp = HRP()
			if not hrp then return false end

			for _, atm in ATMModule.class.objects do
				if atm.instance == currentTargetATM then
					local hacker = atm.states.hacker:get() ~= nil
					local isDisabled = not atm.states.disabled:get()
					if not isDisabled or hacker then
						warn("ATM เป้าหมายใช้ไม่ได้แล้ว ข้ามไปตู้ถัดไป")
						return false
					end
					break
				end
			end

			local originalPos = hrp.Position

			local hrpPos = model:GetPivot().Position
			local offset = Vector3.new(
				math.random(-ATTEMPT_RADIUS, ATTEMPT_RADIUS),
				0,
				math.random(-ATTEMPT_RADIUS, ATTEMPT_RADIUS)
			)
			local targetPos = destination + offset

			local path
			local pathSuccess = false

			for angle = 0, MAX_ROTATION, ROTATION_INCREMENT do
				path = PathfindingService:CreatePath({
					AgentRadius = 2,
					AgentHeight = 5,
					AgentCanJump = false,
					AgentMaxSlope = maxSlope
				})
				path:ComputeAsync(hrpPos, targetPos)

				if path.Status == Enum.PathStatus.Success then
					pathSuccess = true
					break
				else
					local pivot = model:GetPivot()
					model:PivotTo(pivot * CFrame.Angles(0, math.rad(ROTATION_INCREMENT), 0))
					wait(0.01)
				end
			end

			if pathSuccess then
				local waypoints = path:GetWaypoints()
				local lastDir = nil
				for i, wp in ipairs(waypoints) do
					for _, atm in ATMModule.class.objects do
						if atm.instance == currentTargetATM then
							local hacker = atm.states.hacker:get() ~= nil
							local isDisabled = not atm.states.disabled:get()
							if not isDisabled or hacker then
								warn("ATM เป้าหมายโดนแฮกระหว่างเดินทาง หยุด!")
								return false
							end
							break
						end
					end

					local target = wp.Position + Vector3.new(0, hoverHeight, 0)
					local current = model:GetPivot().Position
					local isLast = (i == #waypoints)
					lastDir = moveModelSmoothly(model, current, target, lastDir, waypoints[#waypoints].Position)
				end

				wait(0.1)

				-- จอดรถ
				for _, part in pairs(model:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = true
					end
				end

				wait(0.1)
				exitCar()
				wait(0.1)

				hrp.CFrame = CFrame.new(destination)
				deposit()
				wait(0.1)
				hackxxccc()
				wait(0.1)

				for _, part in pairs(model:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = false
					end
				end

				wait(0.1)
				if (HRP().Position - originalPos).Magnitude > 30 then
					warn("โดนเทเลพอร์ตกลับ!")
					return false
				end

				local teleportPos = hrp.Position + Vector3.new(0, 5, 0)
				model:PivotTo(CFrame.new(teleportPos))

				for i = 1, 4 do
					SitInCar()
				end

				wait(0.1)
				return true
			else
				warn(string.format("พยายามสร้าง Path รอบที่ %d ไม่สำเร็จ ลองใหม่...", attempt))
			end
		end

		warn("ล้มเหลวในการสร้างเส้นทางทั้งหมด")
		return false
	end)
end

local id = game.Players.LocalPlayer.UserId

function Find_a_car()
    for i, v in pairs(workspace.Vehicles:GetChildren()) do
        local ownerId = v:GetAttribute("OwnerUserId")
        if ownerId == id then
            return v
        end
    end
end

local function atm()
    local closestATM = nil
    local shortestDistance = math.huge
    local hrp = HRP()
    if not hrp then return end

    if previousATM and not previousATM:IsDescendantOf(workspace) then
        previousATM = nil
    end

    for _, atm in ATMModule.class.objects do
        local model = atm.instance
        if model and model:IsDescendantOf(workspace) then
            local isBeingHacked = atm.states.hacker:get() ~= nil
            if not isBeingHacked then
                local distance = (hrp.Position - model:GetPivot().Position).Magnitude
                if distance < shortestDistance then
                    closestATM = model
                    shortestDistance = distance
                end
            end
        end
    end

    if closestATM and closestATM ~= previousATM then
        previousATM = closestATM
        return {
            atmposition = closestATM:GetPivot().Position,
            armdistance = math.floor(shortestDistance * 100) / 100
        }
    end
end

local auto_farm = Tabs.Main:AddToggle("Toggle", { Title = "Auto Farm", Default = false })


atm()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function IsTool(ToolName)
    if LocalPlayer.PlayerGui:FindFirstChild("Items") and 
       LocalPlayer.PlayerGui.Items:FindFirstChild("ItemsHolder") and 
       LocalPlayer.PlayerGui.Items.ItemsHolder:FindFirstChild("ItemsScrollingFrame") then

        for _, Image in ipairs(LocalPlayer.PlayerGui.Items.ItemsHolder.ItemsScrollingFrame:GetChildren()) do
            if Image:FindFirstChild("ItemName") then
                if Image.ItemName.ContentText == ToolName then
                    return Image.Name
                end
            end
        end
        return false
    else
        local sidebarSlider = LocalPlayer.PlayerGui:FindFirstChild("Sidebar") and
                              LocalPlayer.PlayerGui.Sidebar:FindFirstChild("SidebarSlider") and
                              LocalPlayer.PlayerGui.Sidebar.SidebarSlider:FindFirstChild("SidebarHolder") and
                              LocalPlayer.PlayerGui.Sidebar.SidebarSlider.SidebarHolder:FindFirstChild("SidebarHolderSlider")

        if sidebarSlider then
            for _, Ui in ipairs(sidebarSlider:GetChildren()) do
                local btn = Ui:FindFirstChild("InventoryButton")
                if btn then
                    for _, connection in ipairs(getconnections(btn.MouseButton1Click)) do
                        connection:Fire()
                    end
                    task.wait(1)
                    for _, connection in ipairs(getconnections(btn.MouseButton1Click)) do
                        connection:Fire()
                    end
                end
            end
        end
    end
end
local closestATM = nil
local shortestDistance = math.huge
local hrp = HRP()
local RunService = game:GetService("RunService")


local autoFarmThread = nil
local enabled = true

local atmBlacklist = {}

auto_farm:OnChanged(function(enabled)
    if enabled then
        if Bicycle == "BMX" then
            Net.get("toggle_equip_item",IsTool("BMX"))
            SitInCar()
        else
            Net.get("toggle_equip_item",IsTool("EScooter"))
            SitInCar()
        end
        wait(0.3)
        SitInCar()
        autoFarmThread = task.spawn(function()
            while auto_farm.Value do
                pcall(function()
                    local chip = Dropdown.Value or "HackToolBasic"
                    print("จำนวนชิป:", ItemUtils.get_item_count(Data, "misc", chip))
    
                    for atm, expireTime in pairs(atmBlacklist) do
                        if tick() > expireTime then
                            atmBlacklist[atm] = nil
                        end
                    end
    
                    if ItemUtils.get_item_count(Data, "misc", chip) < 1 then
                        local bike = Find_a_car()
                        if bike then
                            print("กำลังไปซื้อชิป...")
                            local destination = Vector3.new(-214.27664184570312, 255.20828247070312, 387.0736999511719)
                            moveToDestinationbuy(bike, destination, chip)
                        end
                    else
                        local hrp = HRP()

                        local sortedATMs = {}
                        for _, atm in ATMModule.class.objects do
                            local model = atm.instance
                            if model and model:IsDescendantOf(workspace) and model:GetPivot() then
                                local hacker = atm.states.hacker:get() ~= nil
                                local isDisabled = not atm.states.disabled:get()

                                if isDisabled and hacker == false and model ~= previousATM and (not atmBlacklist[model] or tick() > atmBlacklist[model]) then
                                    local dist = (hrp.Position - model:GetPivot().Position).Magnitude
                                    table.insert(sortedATMs, {model = model, distance = dist, atm = atm})
                                end
                            end
                        end

                        table.sort(sortedATMs, function(a, b)
                            return a.distance < b.distance
                        end)

                        local foundATM = false
                        for _, atmData in ipairs(sortedATMs) do
                            local model = atmData.model
                            local atm = atmData.atm

                            previousATM = model
                            atmBlacklist[model] = tick() + 1
                            currentTargetATM = model

                            local bike = Find_a_car()
                            if bike then
                                local destination = (model:GetPivot() * CFrame.new(-2, 0, 0)).Position
                                print("เจอ ATM ที่ใกล้และว่าง:", model.Name)
                                moveToDestination(bike, destination)
                                wait(0.1)
                                SitInCar()
                                foundATM = true
                                break
                            end
                        end

                        if not foundATM then
                            previousATM = nil
                            currentTargetATM = nil
                        end
                    end
                    wait(0.1)
                end)
            end
        end)
    else
        if autoFarmThread then
            task.cancel(autoFarmThread)
            autoFarmThread = nil
        end
    end
end)

Fluent:Notify({
    Title = "k Hub!",
    Content = "atm farm",
    Duration = 5
})
