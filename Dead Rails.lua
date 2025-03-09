for i, v in ipairs(game.CoreGui:GetChildren()) do
    if v.Name == "FLUENT" then
        v:Destroy()
    end
end
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/UI-Library/refs/heads/main/Loadstring/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/UI-Library/refs/heads/main/Loadstring/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Goa Hub | Dead Rails",
    SubTitle = "by Nevcit",
    TabWidth = 100,
    Size = UDim2.fromOffset(560, 360),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Esp = Window:AddTab({ Title = "Visual", Icon = "eye" }),    
    Credit = Window:AddTab({ Title = "Credit", Icon = "bookmark" }),
    Settings = Window:AddTab({ Title = "Settings", Ic5io0on = "settings" })
}
----------------------------------
--- LOCAL
----------------------------------
----\\ Service //----
local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local OldSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
----\\ Main Tab //----
local auraactive = false
local auracon
local DistanceKillAura = 15
local gunactive = false
local RangeGunAura = 30
local MultiDropdown = nil
local selectedItems = {}
local TypeGetItem = "Bring"
local TypeItem = "Fuel"
local instantactive = false
local instantcon
local speedactive = false
local SpeedValue = 16
local isBoostActive = false
local linearVelocity = nil
local bringactive = false
local weaponNames = {"Rifle", "Shotgun", "BoldActionRifle", "NavyRevolver", "Revolver", "SawedOffShotgun", "MaximGun", "Mauser", "Canon"}
local meleeNames = {"Pickaxe", "Hammer", "Axe", "Tomahawk", "Cavalry Sword", "Vampire Knife"}
local throwableNames = {"Molotov", "Dynamite", "Holy Potion"}
local healingNames = {"Bandage", "Snake Oil"}
local bringing = false
local collectactive = false
local collecting = false
----\\ ESP Tab //----
local brightactive = false
local brightcon
local fogactive = false
local SavedBright = {}
----\\ Settings ESP //----
local ShowHealth = false
local ShowDistance = false
local ShowAttribute = false
local AutoRemove = false
local HighlightActive = false
local DisplayValue = false
----\\ ESP //----
local itemcon
local itemactive = false
local mobcon
local mobactive = false
local playercon
local playeractive = false
---------------------------------
--- FUNCTION
---------------------------------
task.wait(0.05)

local function createLinearVelocity()
    if linearVelocity then
        linearVelocity:Destroy()
    end
    local humanoidRootPart = LocalPlayer.Character.HumanoidRootPart
    local attachment = Instance.new("Attachment", humanoidRootPart)

    linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.Attachment0 = attachment
    linearVelocity.MaxForce = math.huge
    linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
    linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    linearVelocity.VectorVelocity = Vector3.zero
    linearVelocity.Parent = humanoidRootPart
end

local function toggleBoost(state)
    isBoostActive = state

    if isBoostActive then
        createLinearVelocity()
        task.spawn(function()
            while isBoostActive do
                local moveDirection = LocalPlayer.Character.Humanoid.MoveDirection
                if moveDirection.Magnitude > 0 then
                    linearVelocity.VectorVelocity = moveDirection.Unit * SpeedValue
                else
                    linearVelocity.VectorVelocity = Vector3.zero
                end
                task.wait(0.03)
            end
            linearVelocity.VectorVelocity = Vector3.zero
        end)
    else
        if linearVelocity then
            linearVelocity:Destroy()
            linearVelocity = nil
        end
    end
end

local function GetInstance(pathString)
    local segments = string.split(pathString, ".") -- Pisahkan berdasarkan "."
    local instance = game -- Mulai dari `game`

    for _, name in ipairs(segments) do
        instance = instance:FindFirstChild(name)
        if not instance then
            return nil -- Jika ada bagian path yang tidak ditemukan, return nil
        end
    end

    return instance
end

local function GetPriorityNpc()
    local npcs = {}

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Parent:IsA("Folder") and v:GetAttribute("BloodColor") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= LocalPlayer.Name then
            local humanoid = v.Humanoid
            if v.Parent.Name ~= "RuntimeItems" and humanoid.Health ~= 0 then
                local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < DistanceKillAura then
                    table.insert(npcs, {npc = v, health = humanoid.Health, distance = distance, name = v.Name, id = v:GetDebugId()})
                end
            end
        end
    end
    table.sort(npcs, function(a, b)
        if a.health == b.health then
            if a.distance == b.distance then
                if a.name == b.name then
                    return a.id < b.id -- Jika semuanya sama, gunakan Debug ID (unik)
                end
                return a.name < b.name -- Urutkan berdasarkan nama (alfabet)
            end
            return a.distance < b.distance -- Urutkan berdasarkan jarak
        end
        return a.health < b.health -- Urutkan berdasarkan darah
    end)

    return npcs[1] and npcs[1].npc or nil
end

local function KillAura(state)
    auraactive = state
    if auraactive then
        while auraactive do
            if not auraactive then break end
            local Target = GetPriorityNpc()
            if Target and Target.Parent.Name ~= "RuntimeItems" then
                game:GetService("ReplicatedStorage").Shared.Remotes.RequestStopDrag:FireServer()
                game:GetService("ReplicatedStorage").Shared.Remotes.RequestStartDrag:FireServer(GetInstance(Target:GetFullName()))
                repeat task.wait() until Target.HumanoidRootPart.CollisionGroup == "DraggableObject"
                task.wait(0.14)
                Target.Humanoid.Health = 0
                task.wait(0.25)
                game:GetService("ReplicatedStorage").Shared.Remotes.RequestStopDrag:FireServer()
            end
            task.wait(1)
        end
    else
        auraactive = false
    end
end

local function GunAura(state)
    gunactive = state
    if gunactive then
        while gunactive do
            if not gunactive then
                return
            end
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Parent:IsA("Folder") and v.Parent.Name ~= "RuntimeItems" and v:GetAttribute("BloodColor") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Horse" and v.Name ~= "Unicorn" then
                    local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance <= RangeGunAura and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                        local x, y, z = Camera.CFrame:ToEulerAnglesXYZ()
                        for _, gun in pairs(LocalPlayer.Character:GetChildren()) do
                            if table.find(weaponNames, gun.Name) and v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState.CurrentAmmo.Value > 0 then
                                local args = {
                                    [1] = workspace:GetServerTimeNow(),
                                    [2] = gun,
                                    [3] = CFrame.new(Camera.CFrame.Position) * CFrame.Angles(x, y, z),
                                    [4] = {
                                        ["1"] = v.Humanoid
                                    }
                                }
                                game:GetService("ReplicatedStorage").Remotes.Weapon.Shoot:FireServer(unpack(args))
                            elseif table.find(weaponNames, gun.Name) and v:FindFirstChild("ClientWeaponState") and v.ClientWeaponState.CurrentAmmo.Value <= 0 then
                                local args = {
                                    [1] = workspace:GetServerTimeNow(),
                                    [2] = gun
                                }
                                game:GetService("ReplicatedStorage").Remotes.Weapon.Reload:FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end
end
                    

local function AutoAttack(state)
    attackactive = state
    if attackactive then
        while attackactive do
            if not attackactive then break end
            for i, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Parent:IsA("Folder") and v:GetAttribute("BloodColor") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Horse" and v.Name ~= "Unicorn" then
                    local distance = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance <= 15 and LocalPlayer.Character:FindFirstChildOfClass("Tool") and LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("MeleeSwing") and v.Name ~= "Horse" and v.Name ~= "Unicorn" then
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(300, 300))
                        ---[ VirtualInputManager:SendMouseButtonEvent(0, 0, Enum.UserInputType.MouseButton1.Value, true, game, 1) 
                        ---[ VirtualInputManager:SendMouseButtonEvent(0, 0, Enum.UserInputType.MouseButton1.Value, false, game, 1)
                    end
                end
            end
            task.wait(0.1)
        end
    else
        attackactive = false
    end
end

local function GetUniqueItemNames()
    local itemNames = {}
    local uniqueNames = {}
    local runtime = workspace:FindFirstChild("RuntimeItems")
    if runtime then
        for _, item in pairs(workspace.RuntimeItems:GetChildren()) do
            if item:IsA("Model") then
                local distance = (item.PrimaryPart.Position - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
                if not uniqueNames[item.Name] and distance > 30 then
                    table.insert(itemNames, item.Name)
                    uniqueNames[item.Name] = true
                end
            end
        end
    else
        itemNames = {"Join In Game"}
    end

    return itemNames
end

local function BringSelectedItems()
    local store = game:GetService("ReplicatedStorage").Remotes:WaitForChild("StoreItem")
    local character = LocalPlayer.Character
    if not character then
        warn("Character not found!")
        return
    end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("HumanoidRootPart not found!")
        return
    end
    if #selectedItems == 0 then
        warn("No Item Selected!")
        return
    end
    for _, item in pairs(workspace.RuntimeItems:GetChildren()) do
        if item:IsA("Model") and table.find(selectedItems, item.Name) then
            if item.PrimaryPart then
                local distance = (item.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if ModeGetItem == "Bring" and distance <= 18 then
                    item:MoveTo(LocalPlayer.Character.PrimaryPart.Position + LocalPlayer.Character.PrimaryPart.CFrame.LookVector * 5)
                elseif ModeGetItem == "Collect" and distance <= 18 then
                    store:FireServer(item)
                end
            end
        end
    end
end

local function RefreshDropdown()
    if MultiDropdown then
        local newValues = GetUniqueItemNames()
        local oldValues = {} 
        for _, itemName in ipairs(selectedItems) do
            oldValues[itemName] = false
        end
        MultiDropdown:SetValue(oldValues)
        task.wait(0.1)
        MultiDropdown:SetValues(newValues)
        local updatedSelectedItems = {}
        for _, itemName in ipairs(selectedItems) do
            if table.find(newValues, itemName) then
                updatedSelectedItems[itemName] = true
            end
        end
        MultiDropdown:SetValue(updatedSelectedItems)
        selectedItems = {}
        for itemName, isSelected in pairs(updatedSelectedItems) do
            if isSelected then
                table.insert(selectedItems, itemName)
            end
        end
    else
        warn("Dropdown not created!")
    end
end

local function CustomWalkSpeed(state)
    speedactive = state
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid")
    
    if humanoid then
        local OldSpeed = humanoid.WalkSpeed
        if speedactive then
            task.spawn(function()
                while speedactive do
                    if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                        LocalPlayer.Character.Humanoid.WalkSpeed = SpeedValue
                    end
                    if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.WalkSpeed == SpeedValue then
                        continue
                    end
                    task.wait(0.1)
                end
            end)
        else
            if humanoid.WalkSpeed ~= OldSpeed then
                humanoid.WalkSpeed = OldSpeed
            end
        end
    end
end

local function FullBright(state)
    brightactive = state
    if brightactive then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.FogStart = 100000
        brightcon = Lighting.Changed:Connect(function(v)
            if v == "Brightness" then
                Lighting.Brightness = 2
            elseif v == "Ambient" then
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            elseif v == "OutdoorAmbient" then
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            elseif v == "FogStart" then
                Lighting.FogStart = 100000
            end
            task.wait(0.01)
        end)
    else
        if brightcon then
            brightcon:Disconnect()
            brightcon = nil
        end
    end
end

local function NoFog(state)
    fogactive = state
    if fogactive then
        local atmos = Lighting:FindFirstChild("Atmosphere")
        local sky = Lighting:FindFirstChild("GrayCloudSky")
        if atmos then
            SavedBright[atmos.Name] = atmos:Clone() -- Simpan backup berdasarkan nama
            atmos:Destroy()
        end
        if sky then
            SavedBright[sky.Name] = sky:Clone()            
            sky:Destroy()
        end        
    else
        for name, clone in pairs(SavedBright) do
            local newClone = clone:Clone()
            newClone.Parent = Lighting -- Kembalikan Atmosphere
            SavedBright[name] = nil -- Hapus dari backup setelah dipulihkan                
        end
    end
end
        
local function InstantInteract(state)
    instantactive = state
    if instantactive then
        instantcon = ProximityPromptService.PromptButtonHoldBegan:Connect(function(v)
            if v.HoldDuration ~= 0 then
                v.HoldDuration = 0
            end
            task.wait(0.1)
        end)
    else
        if instantcon then
            instantcon:Disconnect()
            instantcon = nil
        end
    end
end

local function ESP(target, color, highlight)
    local high = highlight or nil
    local folder = Instance.new("Folder")
    local objectPos = target.PrimaryPart and target.PrimaryPart.Position or target:GetPivot().Position
    local distance = (objectPos - workspace.Train.Platform:GetChildren()[4].Position).Magnitude

    if target.Parent:IsA("Folder") and target.Parent.Name == "RuntimeItems" then
        folder.Name = target:GetAttribute("BloodColor") and "NevcitESPMob" or "NevcitESPItem"
    elseif target.Parent:IsA("Folder") and target.Parent.Name ~= "RuntimeItems" then
        folder.Name = "NevcitESPMob"
    else
        folder.Name = "NevcitESPPlayer"
    end    

    if target.PrimaryPart then
        folder.Parent = target.PrimaryPart
    else
        return
    end

    if target.Parent.Name == "RuntimeItems" and distance < 25 and target:FindFirstChild("Humanoid") and target.Humanoid.Health == 0 then
        folder:Destroy()
    end

    if high and folder.Name ~= "NevcitESPPlayer" then
        local hl = Instance.new("Highlight", folder)
        hl.Name = "NevcitHighlight"
        hl.Adornee = target
        hl.FillColor = target:GetAttribute("BloodColor") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 144, 255)
        hl.FillTransparency = 0.3
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0.7
    elseif high then
        local hl = Instance.new("Highlight", folder)
        hl.Name = "NevcitHighlight"
        hl.Adornee = target
        hl.FillColor = Color3.fromRGB(0, 255, 0)
        hl.FillTransparency = 0.4
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0.7
    end

    local function createBillboard(parent, adornee, text, target)
        local billboard = Instance.new("BillboardGui", parent)
        billboard.Adornee = adornee
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.MaxDistance = 900
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.TextColor3 = target.Parent:IsA("Folder") and (target:GetAttribute("BloodColor") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 144, 255)) or Color3.fromRGB(0, 255, 0)
        textLabel.TextSize = 16
        textLabel.TextStrokeTransparency = 0.3
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextScaled = false

        local function updateText()
            if not parent.Parent or not folder.Parent or not target.PrimaryPart then return end

            local DisplayText = target.Name
            local humanoid = target:FindFirstChildWhichIsA("Humanoid")
            local distance2 = (target.PrimaryPart.Position - Camera.CFrame.Position).Magnitude
            local textSize = math.clamp(20 - (distance2 / 30), 12, 20)
            local billboardSize = UDim2.new(0, math.clamp(100 + (distance2 / 2), 100, 300), 0, math.clamp(50 + (distance2 / 4), 50, 150))

            if ShowHealth and humanoid then
                DisplayText = DisplayText .. " | HP : " .. math.floor(humanoid.Health)
            end
            if ShowDistance then
                DisplayText = DisplayText .. "\nDistance: " .. math.floor(distance2 * 0.28) .. "M"
            end
            if ShowAttribute then
                for attrName, attrValue in pairs(target:GetAttributes()) do
                    if attrName == "Value" or attrName == "Fuel" then
                        DisplayText = DisplayText .. "\n" .. attrName .. ": " .. tostring(attrValue)
                    end
                end
            end
            if HighlightActive and not (parent:FindFirstChild("NevcitHighlight") or folder:FindFirstChild("NevcitHighlight")) then
                local hl = Instance.new("Highlight")
                hl.Parent = parent or folder
                hl.Name = "NevcitHighlight"
                hl.Adornee = target
                if target.PrimaryPart:FindFirstChild("NevcitESPPlayer") then
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                    hl.FillTransparency = 0.6
                else
                    hl.FillColor = target:GetAttribute("BloodColor") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 144, 255)  -- **Warna default**
                    hl.FillTransparency = 0.6
                end
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.OutlineTransparency = 0.8
            end
            if textLabel.Text ~= DisplayText then
                textLabel.Text = DisplayText
            elseif textLabel.TextSize ~= textSize then
                textLabel.TextSize = textSize
            end
            task.wait(0.2)
            task.defer(updateText)
        end

        task.defer(updateText)
    end

    local displayText = target.Name
    if folder.Name == "NevcitESPItem" then
        createBillboard(folder, target.PrimaryPart, displayText, target)
    elseif folder.Name == "NevcitESPMob" and target:GetAttribute("BloodColor") then
        createBillboard(folder, target:FindFirstChild("Head") or target.PrimaryPart, displayText, target)
    elseif folder.Name == "NevcitESPPlayer" and target:GetAttribute("BloodColor") then
        createBillboard(folder, target:FindFirstChild("Head") or target.PrimaryPart, displayText, target)
    end
end

local healthConnections = {}

local function UpdateESP(target)
    if not target.PrimaryPart then return end
    local esp = target.PrimaryPart:FindFirstChild("NevcitESP") or target.PrimaryPart:FindFirstChild("NevcitESPMob") or target.PrimaryPart:FindFirstChild("NevcitESPPlayer")
    if not esp then return end  

    local billboard = esp:FindFirstChild("BillboardGui")
    if not billboard then return end  

    local textLabel = billboard:FindFirstChild("TextLabel")
    if not textLabel then return end  

    local distance = (target.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
    local textSize = math.clamp(20 - (distance / 30), 12, 20)  
    local billboardSize = UDim2.new(0, math.clamp(100 + (distance / 2), 100, 300), 0, math.clamp(50 + (distance / 4), 50, 150))
    
    if billboard.Size ~= billboardSize then
        billboard.Size = billboardSize
    end
    if textLabel.TextSize ~= textSize then
        textLabel.TextSize = textSize
    end

    local humanoid = target:FindFirstChildWhichIsA("Humanoid")

    local displayText = target.Name

    if ShowHealth and humanoid then
        displayText = displayText .. " | HP: " .. math.floor(humanoid.Health)
    end
    if ShowDistance then
        displayText = displayText .. "\nDistance: " .. math.floor(distance * 0.28) .. " M"
    end
    if ShowAttribute then
        for attrName, attrValue in pairs(target:GetAttributes()) do
            if attrName == "Value" or attrName == "Fuel" then  
                displayText = displayText .. "\n" .. attrName .. ": " .. tostring(attrValue)
            end
        end
    end
    
    if textLabel.Text ~= displayText then
        textLabel.Text = displayText
    end
    
    if ShowHealth and humanoid and not healthConnections[target] then
        healthConnections[target] = humanoid.HealthChanged:Connect(function()
            if humanoid.Health <= 0 then
                if healthConnections[target] then
                    healthConnections[target]:Disconnect()
                    healthConnections[target] = nil
                end
            end
            UpdateESP(target)
            task.wait(0.1)
        end)
    end
    if HighlightActive and not esp:FindFirstChild("NevcitHighlight") then
        local hl = Instance.new("Highlight", esp)
        hl.Name = "NevcitHighlight"
        hl.Adornee = target
        if target.PrimaryPart:FindFirstChild("NevcitESPPlayer") then
            hl.FillColor = Color3.fromRGB(0, 255, 0)
            hl.FillTransparency = 0.5
        else
            hl.FillColor = target:GetAttribute("BloodColor") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 144, 255)  -- **Warna default**
            hl.FillTransparency = 0.5
        end
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0.7
    end
end

local function ApplyESPItem(state)
    itemactive = state
    if itemactive then
        local runtime = workspace:FindFirstChild("RuntimeItems")
        task.spawn(function()
            while itemactive do
                if not runtime or not itemactive then
                    break
                end
                for _, v in pairs(runtime:GetChildren()) do
                    if not (v:GetAttribute("BloodColor") or v:GetAttribute("DangerScore")) and v:IsA("Model") and v.PrimaryPart then
                        local distance = (v.PrimaryPart.Position - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
                        local distance1 = (v.PrimaryPart.Position - workspace.Train.PrimaryPart.Position).Magnitude
                        if (distance1 <= 30 or distance <= 30) and v.PrimaryPart:FindFirstChild("NevcitESPItem") and AutoRemove then
                            v.PrimaryPart.NevcitESPItem:Destroy()
                        elseif (distance1 > 30 and distance > 30)and not v.PrimaryPart:FindFirstChild("NevcitESPItem") then
                            ESP(v, Color3.fromRGB(30, 144, 255), HighlightActive)
                        end
                    end
                end
                task.wait(0.8)
            end
        end)
    else
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Folder") and v.Name == "NevcitESPItem" then
                v:Destroy()
            end
        end
        itemactive = false
    end
end

local function ApplyESPMob(state)
    mobactive = state
    if mobactive then
        task.spawn(function()
            while mobactive do
                if not mobactive then break end
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Parent:IsA("Folder") and (v:GetAttribute("BloodColor") or v:GetAttribute("DangerScore")) and v.PrimaryPart and v:FindFirstChildWhichIsA("Humanoid") then
                        local distance = (v.PrimaryPart.Position - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
                        local distance1 = (v.PrimaryPart.Position - workspace.Train.PrimaryPart.Position).Magnitude
                        if (distance1 <= 30 or distance <= 30) and v.Humanoid.Health <= 0 and v:FindFirstChild("NevcitESPMob") and AutoRemove then
                            v.PrimaryPart.NevcitESPMob:Destroy()
                        elseif (distance1 <= 30 or distance <= 30) and not v.PrimaryPart:FindFirstChild("NevcitESPMob") then
                            ESP(v, Color3.fromRGB(255, 0, 0), HighlightActive)
                        end
                    end
                end
                task.wait(0.4)
            end
        end)
    else
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Folder") and v.Name == "NevcitESPMob" then
                v:Destroy()
            end
        end
        mobactive = false
    end
end

local function ApplyESPPlayer(state)
    playeractive = state
    if playeractive then
        task.spawn(function()
            while playeractive do
                if not playeractive then break end
                for _, v in pairs(Players:GetChildren()) do
                    if v.Name ~= LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.PrimaryPart then
                        if not v.Character.PrimaryPart:FindFirstChild("NevcitESPPlayer") then
                            ESP(v.Character, Color3.fromRGB(0, 255, 0), HighlightActive)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    else
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Folder") and v.Name == "NevcitESPPlayer" then
                v:Destroy()
            end
        end
        playeractive = false
    end
end


local function ApplyESPItem2(state)
    itemactive = state
    if itemactive then
        local runtime = workspace:FindFirstChild("RuntimeItems")
        if runtime then
            for i, v in pairs(runtime:GetChildren()) do
                if v:IsA("Model") then
                    if v.PrimaryPart:FindFirstChild("NevcitESP") == nil then
                        ESP(v, Color3.fromRGB(255, 255, 255), HighlightActive)
                    end
                end
            end
            itemcon = runtime.ChildAdded:Connect(function(v)
                if v.PrimaryPart:FindFirstChild("NevcitESP") == nil then
                    ESP(v, Color3.fromRGB(255, 255, 255), HighlightActive)
                end
                task.wait(0.1)
            end)                    
        end
        task.spawn(function()
            while itemactive do
                if not itemactive then break end
                task.wait(0.7)
                for i, v in pairs(runtime:GetChildren()) do
                    if v:IsA("Model") and v.PrimaryPart and v.Parent.Name == "RuntimeItems" and v.PrimaryPart:FindFirstChild("NevcitESP") then  
                        local objectPos = v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position
                        local distance = (objectPos - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
                        if distance < 30 and AutoRemove and v.PrimaryPart:FindFirstChild("NevcitESP") then
                            v.PrimaryPart.NevcitESP:Destroy()
                        end
                    end
                end
            end
        end)
    else
        itemactive = false
        local runtime = workspace:FindFirstChild("RuntimeItems")
        if runtime then
            for i, v in pairs(runtime:GetDescendants()) do
                if v.Name == "NevcitESP" and v:IsA("Folder") then
                    v:Destroy()
                end
            end
        end
        if itemcon then
            itemcon:Disconnect()
            itemcon = nil
        end
    end
end

local function ApplyESPMob2(state)
    mobactive = state
    if mobactive then
        local runtime = workspace:FindFirstChild("RuntimeItems")
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Parent:IsA("Folder") and v:GetAttribute("BloodColor") and not v.PrimaryPart:FindFirstChild("NevcitESPMob") then
                ESP(v, Color3.fromRGB(255, 0, 0), HighlightActive)                
            end
        end
        mobcon = workspace.DescendantAdded:Connect(function(v)
            if v.Parent:IsA("Folder") and v:GetAttribute("BloodColor") and not v.PrimaryPart:FindFirstChild("NevcitESPMob") then
                ESP(v, Color3.fromRGB(255, 0, 0), HighlightActive)
            end            
            task.wait(0.1)
        end)
        task.spawn(function()
            while mobactive do
                if not mobactive then break end
                task.wait(0.4)
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v.Parent:IsA("Folder") and v:GetAttribute("BloodColor") and v.PrimaryPart then  
                        local objectPos = v.PrimaryPart
                        local distance = (objectPos.Position - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
                        if distance < 30 and v.PrimaryPart:FindFirstChild("NevcitESPMob") and AutoRemove and v.Humanoid.Health == 0 then
                            v.PrimaryPart:FindFirstChild("NevcitESPMob"):Destroy()
                        end
                    end
                end
            end
        end)            
    else
        mobactive = false
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "NevcitESPMob" and v:IsA("Folder") then
                v:Destroy()
            end
        end
        if mobcon then
            mobcon:Disconnect()
            mobcon = nil
        end
    end
end

local function ApplyESPPlayer2(state)
    playeractive = state
    if playeractive then
        for i, v in pairs(Players:GetChildren()) do
            if v.Name ~= LocalPlayer.Name then
                ESP(v.Character, Color3.fromRGB(255, 0, 0), HighlightActive)                
            end
        end
        task.spawn(function()
            while ShowDistance do
                if not playeractive then break end
                for i, v in pairs(Players:GetChildren()) do
                    if v.Name ~= LocalPlayer.Name and v.Character.PrimaryPart and v.Character.PrimaryPart:FindFirstChild("NevcitESPPlayer") then
                    end
                end
                task.wait(0.5)
            end
        end)            
    else
        playeractive = false
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "NevcitESPPlayer" and v:IsA("Folder") then
                v:Destroy()
            end
        end
        if playercon then
            playercon:Disconnect()
            playercon = nil
        end
    end
end

local function DoBringItem(type)
    local runtime = workspace:FindFirstChild("RuntimeItems")
    if not runtime then return end

    local character = LocalPlayer.Character
    local primaryPart = character and character.PrimaryPart

    if not primaryPart then return end
    local playerPos = primaryPart.Position

    for _, v in ipairs(runtime:GetChildren()) do
        if v:IsA("Model") then
            local objectPos = v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position
            local distance = (objectPos - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
            local distance2 = (objectPos - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

            if distance > 25 and distance2 <= 22 then
                local targetPos = playerPos + primaryPart.CFrame.LookVector * 5

                if type == "Valueable" and v:GetAttribute("Value") and v.Name ~= "Bandage" then
                    v:PivotTo(CFrame.new(targetPos))
                elseif type == "Expensive" and tonumber(v:GetAttribute("Value")) and tonumber(v:GetAttribute("Value")) >= 40 then
                    v:MoveTo(targetPos)
                elseif type == "Bond" and v.Name == "Bond" then
                    v:MoveTo(targetPos)
                elseif type == "Fuel" and v:GetAttribute("Fuel") then
                    v:MoveTo(targetPos)
                elseif type == "Coal" and v:GetAttribute("Fuel") and v.Name == "Coal" then
                    v:MoveTo(targetPos)
                elseif type == "Armor" and v.Name:match("Armor") then
                    v:MoveTo(targetPos)
                elseif type == "Gun" and table.find(weaponNames, v.Name) then
                    v:PivotTo(CFrame.new(targetPos))
                elseif type == "Melee" and table.find(meleeNames, v.Name) then
                    v:MoveTo(targetPos)
                elseif type == "Healing" and table.find(healingNames, v.Name) then
                    v:MoveTo(targetPos)
                elseif type == "Throwable" and table.find(throwableNames, v.Name) then
                    v:MoveTo(targetPos)
                elseif type == "Cowboy" and v:GetAttribute("Bounty") then
                    v:MoveTo(targetPos)
                elseif type == "Ammo" and v.Name:match("Ammo") or v.Name:match("Shells") then
                    v:PivotTo(CFrame.new(targetPos))
                end
            end
        end
    end
end

local function BringItem(state, TypeItem, loop)
    bringactive = state
    if bringactive then
        if not loop then
            DoBringItem(TypeItem)
        elseif loop then
            bringing = true
            task.spawn(function()
                while bringing do
                    if not bringing then break end
                    DoBringItem(TypeItem)
                    task.wait(0.1)
                end
            end)
        end
    else
        bringing = false
    end
end

local function DoCollectItem(type)
    local runtime = workspace.RuntimeItems
    local store = game:GetService("ReplicatedStorage").Remotes:WaitForChild("StoreItem")
    if not runtime then return end

    local character = LocalPlayer.Character
    local primaryPart = character and character.PrimaryPart

    if not primaryPart then return end
    local playerPos = primaryPart.Position

    for _, v in ipairs(runtime:GetChildren()) do
        if v:IsA("Model") then
            local objectPos = v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position
            local distance = (objectPos - workspace.Train.Platform:GetChildren()[4].Position).Magnitude
            local distance2 = (objectPos - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance > 25 and distance2 <= 22 then
                if type == "Valueable" and v:GetAttribute("Value") and v.Name ~= "Bandage" then
                    store:FireServer(v)
                elseif type == "Expensive" and tonumber(v:GetAttribute("Value")) and tonumber(v:GetAttribute("Value")) >= 40 then
                    store:FireServer(v)
                elseif type == "Bond" and v.Name == "Bond" then
                    store:FireServer(v)
                elseif type == "Fuel" and v:GetAttribute("Fuel") then
                    store:FireServer(v)
                elseif type == "Coal" and v:GetAttribute("Fuel") and v.Name == "Coal" then
                    store:FireServer(v)
                elseif type == "Armor" and v.Name:match("Armor") then
                    store:FireServer(v)
                elseif type == "Gun" and table.find(weaponNames, v.Name) then
                    store:FireServer(v)
                elseif type == "Melee" and table.find(meleeNames, v.Name) then
                    store:FireServer(v)
                elseif type == "Healing" and table.find(healingNames, v.Name) then
                    store:FireServer(v)
                elseif type == "Throwable" and table.find(throwableNames, v.Name) then
                    store:FireServer(v)
                elseif type == "Cowboy" and v:GetAttribute("Bounty") then
                    store:FireServer(v)              
                elseif type == "Ammo" and v.Name:match("Ammo") then
                    store:FireServer(v)
                end
            end
        end
    end
end

local function GetItem(state, loop)
    getactive = state
    if getactive then
        if not loop then
            if ModeGetItem == "Collect" then
                DoCollectItem(TypeItem)
            elseif ModeGetItem == "Bring" then
                DoBringItem(TypeItem)
            end
        elseif loop then
            task.spawn(function()
                while getactive do
                    if ModeGetItem == "Collect" then
                        DoCollectItem(TypeItem)
                    elseif ModeGetItem == "Bring" then
                        DoBringItem(TypeItem)
                    end
                    task.wait(0.1)
                end
            end)
        end
    else
        getactive = false
    end
end

task.wait(0.1)
-----------------------------------
--- WINDOW
-----------------------------------
----\\ Main Tab //----

Tabs.Main:AddSlider("Kill Aura Distance", 
{
    Title = "Kill Aura Distance",
    Description = "",
    Default = 15,
    Min = 0,
    Max = 30,
    Rounding = 0,
    Callback = function(Value)
        DistanceKillAura = Value
    end
})

Tabs.Main:AddToggle("Kill Aura", 
{
    Title = "Kill Aura", 
    Description = "Must Not Use Nothing",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            KillAura(state)
        end)
    end 
})

Tabs.Main:AddSlider("Gun Aura Distance", 
{
    Title = "Gun Aura Distance",
    Description = "",
    Default = 30,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        RangeGunAura = Value
    end
})

Tabs.Main:AddToggle("Gun Aura", 
{
    Title = "Gun Aura", 
    Description = "Must Use Range Weapon",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            GunAura(state)
        end)
    end 
})

Tabs.Main:AddToggle("Auto Attack", 
{
    Title = "Auto Attack", 
    Description = "Must Use Melee Weapon",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            AutoAttack(state)
        end)
    end 
})

Tabs.Main:AddToggle("Instant Interact", 
{
    Title = "Instant Interact",
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            InstantInteract(state)
        end)
    end 
})

Tabs.Main:AddDropdown("Select Mode Get Item", {
    Title = "Select Mode Get Item",
    Description = "Collect = Must Use Sack",
    Values = {"Bring", "Collect"},
    Multi = false,
    Default = 2,
    Callback = function(Value)
      ModeGetItem = Value
    end
})

MultiDropdown = Tabs.Main:AddDropdown("Select Item", {
    Title = "Select Item",
    Description = "",
    Values = GetUniqueItemNames(),
    Multi = true,
    Default = {},
    Callback = function(Value)
        selectedItems = {}
        if typeof(Value) == "table" then
            for itemName, isSelected in pairs(Value) do
                if isSelected then -- Hanya tambahkan item yang bernilai true
                    table.insert(selectedItems, itemName)
                end
            end
        else
            selectedItems = { tostring(Value) } -- Pastikan selalu string
        end
        print("Selected Items setelah Update:", table.concat(selectedItems, ", ")) -- DEBUG
    end
})

Tabs.Main:AddButton({
    Title = "Refresh",
    Description = "",
    Callback = function()
        RefreshDropdown()        
    end
})

Tabs.Main:AddButton({
    Title = "Get Selected Item",
    Description = "Must be near the selected item",
    Callback = function()
        BringSelectedItems()
    end
})

Tabs.Main:AddToggle("Auto Get Selected Item", {
    Title = "Auto Get Selected Item", 
    Description = "Must be near the selected item",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            while state do
                BringSelectedItems()
                task.wait(0.3)
            end
        end)
    end
})

Tabs.Main:AddDropdown("Get Type Item", {
    Title = "Select Get Type Item",
    Description = "",
    Values = {"Ammo", "Armor", "Bond", "Cowboy", "Expensive", "Fuel", "Gun", "Healing", "Melee", "Throwable", "Valueable"},
    Multi = false,
    Default = 5,
    Callback = function(Value)
      TypeItem = Value
    end
})

Tabs.Main:AddButton({
    Title = "Get Selected Type Item",
    Description = "Must be near the selected type item",
    Callback = function()
        GetItem(true, false)
    end
})

Tabs.Main:AddToggle("Auto Get Selected Type Item", {
    Title = "Auto Get Selected Type Item", 
    Description = "Must be near the selected type item",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            GetItem(state, true)
        end)
    end
})

Tabs.Main:AddToggle("Auto Collect Bond", {
    Title = "Auto Collect Bond", 
    Description = "Must be near the bond",
    Default = false,
    Callback = function(state)
        if state then
            task.spawn(function()
                while state do
                    if not state then break end
                    for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if v.Name == "Bond" and v:IsA("Model") then
                            local objectPos = v.PrimaryPart and v.PrimaryPart.Position or v:GetPivot().Position
                            local distance = (objectPos - LocalPlayer.Character.PrimaryPart.Position).Magnitude
                            if distance <= 30 then
                                game:GetService("ReplicatedStorage").Packages.RemotePromise.Remotes.C_ActivateObject:FireServer(v)
                            end
                        end
                    end
                    task.wait(0.3)
                end
            end)
        else
            return
        end
    end
})

----\\ ESP Tab //----

Tabs.Esp:AddToggle("FullBright", 
{
    Title = "Full Bright", 
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            FullBright(state)
        end)
    end 
})

Tabs.Esp:AddToggle("No FOG", 
{
    Title = "No FOG", 
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            NoFog(state)
        end)
    end 
})

local setesp = Tabs.Esp:AddSection("SETTINGS ESP")
setesp:AddToggle("ActiveHighlight", 
{
    Title = "Use Highlight", 
    Description = "",
    Default = false,
    Callback = function(state)
        if state then
            HighlightActive = true
        end
        if not state then
            HighlightActive = false
        end
    end 
})

setesp:AddToggle("Show Health", 
{
    Title = "Show Health", 
    Description = "",
    Default = false,
    Callback = function(state)
        if state then
            ShowHealth = true
        end
        if not state then
            ShowHealth = false
        end
    end 
})

setesp:AddToggle("Show Distance", 
{
    Title = "Show Distance", 
    Description = "",
    Default = false,
    Callback = function(state)
        if state then
            ShowDistance = true
        end
        if not state then
            ShowDistance = false
        end
    end 
})

setesp:AddToggle("Show Type Item", 
{
    Title = "Show Type Item", 
    Description = "",
    Default = false,
    Callback = function(state)
        if state then
            ShowAttribute = true
        end
        if not state then
            ShowAttribute = false
        end
    end 
})

setesp:AddToggle("AutoRemove", 
{
    Title = "Auto Remove ESP", 
    Description = "Remove ESP if near train (Except ESP Player)",
    Default = false,
    Callback = function(state)
        if state then
            AutoRemove = true
        end
        if not state then
            AutoRemove = false
        end
    end 
})

local mainesp = Tabs.Esp:AddSection("ESP")

mainesp:AddToggle("ESPItem", 
{
    Title = "ESP Items", 
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            ApplyESPItem(state)
        end)
    end 
})

mainesp:AddToggle("ESPMob", 
{
    Title = "ESP Mob", 
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            ApplyESPMob(state)
        end)
    end 
})

mainesp:AddToggle("ESPMob", 
{
    Title = "ESP Player", 
    Description = "",
    Default = false,
    Callback = function(state)
        task.spawn(function()
            ApplyESPPlayer(state)
        end)
    end 
})

----\\ SETTINGS //----
local toggleproblem = Tabs.Settings:AddSection("Toggle UI Problem")

toggleproblem:AddButton({
    Title = "Toggle UI Dissapear? Click This",
    Description = "",
    Callback = function()
        for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do            
            if gui.Name == "Nevcit" then
                gui:Destroy()
            end
        end
        if UI then
            UI:Disconnect()
            UI = nil
        end
        local minimize = game:GetService("CoreGui").FLUENT:GetChildren()[2]
        local size = {35, 35}
        local ScreenGui = Instance.new("ScreenGui", game.CoreGui)       
        ScreenGui.Name = "Nevcit"
        ScreenGui.Enabled = true
        local Button = Instance.new("ImageButton", ScreenGui)
        Button.Image = "rbxassetid://114587443832683"
        Button.Size = UDim2.new(0, size[1], 0, size[2])
        Button.Position = UDim2.new(0.15, 0, 0.15, 0)
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.Active = true
        Button.Draggable = true
        local uistroke = Instance.new("UIStroke", Button)
        uistroke.Thickness = 4
        uistroke.Color = Color3.fromRGB(0, 0, 0)
        UI = Button.MouseButton1Click:Connect(function()
            if minimize.Visible == true then
                minimize.Visible = false
            elseif minimize.Visible == false then
                minimize.Visible = true
            end
        end)
    end
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("GOAHUB")
SaveManager:SetFolder("GOAHUB/Dead-Rails")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Fluent:Notify({
    Title = "Read This",
    Content = "Subscribe my channel (Nevcit) for support me",
    Duration = 5
})

-----------------\\ CREDIT //-----------------

Tabs.Credit:AddButton({
    Title = "Youtube Channel",
    Description = "",
    Callback = function()
        setclipboard("https://www.youtube.com/@Nevcit")
        Fluent:Notify({
            Title = "Subcribe For Support Me",
            Content = "",
            SubContent = "", -- Optional
            Duration = 5 -- Set to nil to make the notification not disappear
        })
    end
})

Tabs.Credit:AddButton({
    Title = "Discord Server",
    Description = "",
    Callback = function()
        setclipboard("https://discord.gg/DQYZnHMRZM")
        Fluent:Notify({
            Title = "Success Copy The Link",
            Content = "",
            SubContent = "", -- Optional
            Duration = 2 -- Set to nil to make the notification not disappear
        })
    end
})

----------------- TOOGLE UI -----------------
for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
  if gui.Name == "Nevcit" then
    gui:Destroy()
  end
end

if UI then
    UI:Disconnect()
    UI = nil
end

local minimize = game:GetService("CoreGui").FLUENT:GetChildren()[2]
local size = {35, 35}
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Nevcit"
ScreenGui.Enabled = true
local Button = Instance.new("ImageButton", ScreenGui)
Button.Image = "rbxassetid://114587443832683"
Button.Size = UDim2.new(0, size[1], 0, size[2])
Button.Position = UDim2.new(0.15, 0, 0.15, 0)
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button.Active = true
Button.Draggable = true
local uistroke = Instance.new("UIStroke", Button)
uistroke.Thickness = 4
uistroke.Color = Color3.fromRGB(0, 0, 0)
UI = Button.MouseButton1Click:Connect(function()
  if minimize.Visible == true then
    minimize.Visible = false
  elseif minimize.Visible == false then
    minimize.Visible = true
  end
end)