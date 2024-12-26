repeat wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/GOA_HUB/refs/heads/main/KeySystem.lua"))()
local screen = game:GetService("CoreGui").KeySystem
local box = game:GetService("CoreGui").KeySystem.Frame.TextBox
local tb3 = game:GetService("CoreGui").KeySystem.Frame.Frame:GetChildren()[3]
local tb2 = game:GetService("CoreGui").KeySystem.Frame.Frame.TextButton
local correct = false
getgenv().Nevcit = false
local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "f8697a274a6147978e4430002dd72c79"
local falseData = "b3d0b953d17a4191bc765c9be4503ba3"

KeyGuardLibrary.Set({
  publicToken = "236a84aa38b742699016bf40133dbec7",
  privateToken = "a6bca04c1b964ce896721bc4c6a859de",
  trueData = trueData,
  falseData = falseData,
})

local keygoahub = "GOAHUB/Key.txt"

if isfile(keygoahub) then
  local kuncistored = readfile(keygoahub)
  local response = KeyGuardLibrary.validateDefaultKey(kuncistored)
  if response == trueData then
    box.Text = "Valid Key"
    task.wait(0.3)
    game.StarterGui:SetCore("SendNotification", {
      Title = "Loading .......";
      Text = "Please Wait";
      Duration = "4";
      Button1 = "OK"
    })
    task.wait(0.1)
    screen:Destroy()
    task.wait(0.1)
    getgenv().Nevcit = true
    task.wait(0.1)
    correct = true
  elseif response ~= trueData then
    delfile(keygoahub)
  end
end

tb3.MouseButton1Click:Connect(function()
    local getkey = KeyGuardLibrary.getLink()
    task.wait(0.1)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Notifications";
        Text = "Paste on Website";
        Duration = "10";
        Button1 = "OK"
    })
    setclipboard(getkey)
end)

tb2.MouseButton1Click:Connect(function()
    local key = box.Text
    local response = KeyGuardLibrary.validateDefaultKey(key)
    if response == trueData then
        writefile("GOAHUB/Key.txt", key)
        task.wait(0.1)
        box.Text = "Valid Key"
        task.wait(0.2)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Loading .......";
            Text = "Please Wait";
            Duration = "4";
            Button1 = "OK"
        })
        task.wait(0.1)
        screen:Destroy()
        task.wait(0.1)
        getgenv().Nevcit = true
        task.wait(0.1)
        correct = true
    elseif response ~= trueData then
        box.Text = "Invalid Key"
        game.StarterGui:SetCore("SendNotification", {
            Title = "ERROR";
            Text = "GET KEY FIRST";
            Duration = "5";
            Button1 = "OK"
        })
    end
end)

repeat task.wait()
  if getgenv().KeyMode == 2 or getgenv().AllowAnyKey == false or getgenv().UseKey == "25ms" then
    game.Players.LocalPlayer:Kick("Cracking Detected : Please Dont Cracking The Script")
  end
until correct and getgenv().Nevcit
for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do  
  if gui.Name == "FLUENT" then 
    gui:Destroy()
  end
end

local infinitestamina
local energy
local thirst
local Hunger
local stop = false
getgenv().JumpPower = nil
getgenv().WalkSpeed = nil
getgenv().Air = 20
getgenv().Active = false
getgenv().Hunger = 10
getgenv().Sleep = false
getgenv().Seed = false
getgenv().Apple = false
getgenv().Activity = "Nothing"
getgenv().Item = "Nothing"
getgenv().Location = "Nothing"
local lp = game.Players.LocalPlayer
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/UI-Library/refs/heads/main/Loadstring/FluentLib"))()
local Options = Fluent.Options

local Window = Fluent:CreateWindow({
    Title = "GOA HUB ",
    SubTitle = " by Nevcit",
    TabWidth = 80,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
  Main = Window:AddTab({ Title = "Main", Icon = "home" }),
  Player = Window:AddTab({ Title = "Player", Icon = "user" }),
  Credit = Window:AddTab({ Title = "Credit", Icon = "bookmark" }),
  Save = Window:AddTab({ Title = "Save", Icon = "save" })
}

-----\\ Main //-----
Tabs.Main:AddButton({
    Title = "No FOG",
    Description = "",
    Callback = function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").Atmosphere:Destroy()
    end
})

local Dropdown = Tabs.Main:AddDropdown("Auto Drink If Reach", {
    Title = "Auto Drink If Reach (%}",
    Description = "",
    Values = {1, 10, 20, 30, 40, 50, 60, 70, 80, 90},
    Multi = false,
    Default = 20,
    Callback = function(Value)
      getgenv().Air = Value
    end
})

local Toggle = Tabs.Main:AddToggle("Auto Drink", 
{
    Title = "Auto Drink", 
    Description = "",
    Default = false,
    Callback = function(state)
      if state == true then
        stop = false
        getgenv().Active = false
        repeat task.wait(0.5)
          local hrp = lp.Character.HumanoidRootPart
          local old = hrp.CFrame
          if getgenv().Air >= lp.Thirst.Value and getgenv().Active == false then
            getgenv().Active = true
            if lp.Backpack:FindFirstChild("Drinking Glass") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") == nil then
              hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
              repeat task.wait(0.2) until not lp.GameplayPaused
              task.wait(0.2)
              fireproximityprompt(workspace.Shelter["Shelf with Drinks"].Primary.ProximityPrompt)
              task.wait(0.2)          
              if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
                hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
                repeat task.wait(0.2) until not lp.GameplayPaused
                repeat task.wait(0.1)
                  fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
                until lp.Backpack:FindFirstChild("Water Bucket")
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Water Bucket" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Drinking Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
                task.wait(0.1)
                hrp.CFrame = old
              elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Drinking Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                task.wait(0.1)
                hrp.CFrame = old
              end
            elseif lp.Backpack:FindFirstChild("Drinking Glass") ~= nil then
              if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
                hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
                repeat task.wait(0.2) until not lp.GameplayPaused
                repeat task.wait(0.1)
                  fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
                until lp.Backpack:FindFirstChild("Water Bucket")
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Water Bucket" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Drinking Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
                task.wait(0.1)
                hrp.CFrame = old
              elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Drinking Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                task.wait(0.1)
                hrp.CFrame = old
              end
            elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") ~= nil then
              if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
                hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
                repeat task.wait(0.2) until not lp.GameplayPaused
                repeat task.wait(0.1)
                  fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
                until lp.Backpack:FindFirstChild("Water Bucket")
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Water Bucket" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Drinking Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
                task.wait(0.1)
                hrp.CFrame = old
              elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
                hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
                task.wait(0.2)            
                fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
                task.wait(0.1)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                task.wait(0.1)
                hrp.CFrame = old
              elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Water of Glass") ~= nil then
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                task.wait(0.1)
                hrp.CFrame = old
              elseif lp.Backpack:FindFirstChild("Water of Glass") ~= nil then
                for i, v in pairs(lp.Backpack:GetChildren()) do
                  if v.Name == "Water of Glass" then
                    lp.Character.Humanoid:EquipTool(v)
                  end
                end
                task.wait(0.2)
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                task.wait(0.1)
                hrp.CFrame = old                
              end
            end
            getgenv().Active = false            
          end      
        until stop
      end
      if state == false then
        stop = true
      end
    end 
})

local Dropdown = Tabs.Main:AddDropdown("Auto Eat If Reach", {
    Title = "Auto Eat If Reach (%}",
    Description = "",
    Values = {1, 10, 20, 30, 40, 50, 60, 70, 80, 90},
    Multi = false,
    Default = 20,
    Callback = function(Value)
      getgenv().Hunger = Value
    end
})


local Toggle = Tabs.Main:AddToggle("Auto Eat", 
{
    Title = "Auto Eat", 
    Description = "",
    Default = false,
    Callback = function(state)
      if state == true then
        stop = false
        getgenv().Active = false
        while task.wait(0.3) do
          local hrp = lp.Character.HumanoidRootPart
          local old = hrp.CFrame
          if lp.Hunger.Value <= getgenv().Hunger and getgenv().Active == false then
            getgenv().Active = true
            if lp.Backpack:FindFirstChild("Apple") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") == nil then
              hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
              repeat task.wait(0.2) until not lp.GameplayPaused
              task.wait(0.1)
              task.spawn(function()
                for i, v in pairs(workspace.Farm:GetDescendants()) do
                  if v.Name == "Apple" and v:IsA("Part") and v:FindFirstChild("ProximityPrompt") and getgenv().Apple == false then
                    hrp.CFrame = v.CFrame
                    fireproximityprompt(v.ProximityPrompt)
                  end
                end
              end)
              repeat task.wait(0.2) until lp.Backpack:FindFirstChild("Apple")
              task.wait(0.1)
              for i, v in pairs(lp.Backpack:GetChildren()) do
                if v.Name == "Apple" then
                  lp.Character.Humanoid:EquipTool(v)
                end
              end
              task.wait(0.2)
              game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
              hrp.CFrame = old
            elseif lp.Backpack:FindFirstChild("Apple") ~= nil then
              for i, v in pairs(lp.Backpack:GetChildren()) do
                if v.Name == "Apple" then
                  lp.Character.Humanoid:EquipTool(v)
                end
              end
              task.wait(0.2)
              game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
              hrp.CFrame = old
            elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") then
              game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
              hrp.CFrame = old              
            end
            getgenv().Active = false
          end
          if stop == true then
            break
          end
        end          
      end
      if state == false then
        stop = true
      end
    end 
})

local Dropdown = Tabs.Main:AddDropdown("Activity", {
    Title = "Activity",
    Description = "",
    Values = {"Fill Dispenser", "Drink", "Eat Apple", "Sleep", "Place Seed", "Attach Wheel", "Attach Paint", "Attach Steering Wheel", "Attach Engine", "Attach Seats"},
    Multi = false,
    Default = "",
    Callback = function(Value)
      getgenv().Activity = Value
    end
})

Tabs.Main:AddButton({
    Title = "Do The Activity",
    Description = "",
    Callback = function()
      local hrp = lp.Character.HumanoidRootPart
      local old = hrp.CFrame
      if getgenv().Activity == "Drink" then
        if lp.Backpack:FindFirstChild("Drinking Glass") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") == nil then
          hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter["Shelf with Drinks"].Primary.ProximityPrompt)
          task.wait(0.2)          
          if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
            hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
            repeat task.wait(0.2) until not lp.GameplayPaused
            repeat task.wait(0.1)
              fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
            until lp.Backpack:FindFirstChild("Water Bucket")
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water Bucket" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Drinking Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
            task.wait(0.1)
            hrp.CFrame = old
          elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Drinking Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
            task.wait(0.1)
            hrp.CFrame = old
          end
        elseif lp.Backpack:FindFirstChild("Drinking Glass") ~= nil then
          if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
            hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
            repeat task.wait(0.2) until not lp.GameplayPaused
            repeat task.wait(0.1)
              fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
            until lp.Backpack:FindFirstChild("Water Bucket")
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water Bucket" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Drinking Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
            task.wait(0.1)
            hrp.CFrame = old
          elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Drinking Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
            task.wait(0.1)
            hrp.CFrame = old
          end
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") ~= nil then
          if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
            hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
            repeat task.wait(0.2) until not lp.GameplayPaused
            repeat task.wait(0.1)
              fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
            until lp.Backpack:FindFirstChild("Water Bucket")
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water Bucket" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Drinking Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9)) 
            task.wait(0.1)
            hrp.CFrame = old
          elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)            
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
            task.wait(0.1)
            hrp.CFrame = old
          elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Water of Glass") ~= nil then
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
            task.wait(0.1)
            hrp.CFrame = old
          elseif lp.Backpack:FindFirstChild("Water of Glass") ~= nil then
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water of Glass" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
            task.wait(0.1)
            hrp.CFrame = old
          end
        end
      elseif getgenv().Activity == "Fill Dispenser" then
        if workspace.Shelter.WaterDispenser.Bottle.Transparency == 1 then
          if lp.Backpack:FindFirstChild("Water Bucket") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Water Bucket") == nil then
            hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
            repeat task.wait(0.2) until not lp.GameplayPaused
            repeat task.wait(0.1)
              fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
            until lp.Backpack:FindFirstChild("Water Bucket")
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water Bucket" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            hrp.CFrame = old
          elseif lp.Backpack:FindFirstChild("Water Bucket") ~= nil then
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575) 
            task.wait(0.2)            
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Water Bucket" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            hrp.CFrame = old
          elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Water Bucket") ~= nil then
            hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)            
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.WaterDispenser.Primary.ProximityPrompt)
            task.wait(0.1)
            hrp.CFrame = old
          end
        elseif workspace.Shelter.WaterDispenser.Bottle.Transparency == 0 then
          Fluent:Notify({
            Title = "ERROR",
            Content = "DISPENSER IS ALREADY FILLED",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Attach Wheel" then
        if lp.Backpack:FindFirstChild("Wheel") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Wheel") == nil and workspace.Shelter.Truck.Wheels.Done.Value == false then
          hrp.CFrame = CFrame.new(1147.07996, 55.9864388, 206.178238, -0.877708137, -8.31582341e-08, 0.479195625, -1.1075705e-07, 1, -2.93285787e-08, -0.479195625, -7.88162211e-08, -0.877708137)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(workspace.Grabbables.Wheels:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then
              fireproximityprompt(v)
            end
          end
          task.wait(0.2)
          hrp.CFrame = CFrame.new(51.3092995, 56.4138947, -101.931618, -0.999997079, -3.15024096e-08, 0.00242084684, -3.16472253e-08, 1, -5.97823941e-08, -0.00242084684, -5.98588343e-08, -0.999997079)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Wheel" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.3)
          fireproximityprompt(workspace.Shelter.Truck.Wheels.Wheel.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Wheel") ~= nil then
          hrp.CFrame = CFrame.new(51.3092995, 56.4138947, -101.931618, -0.999997079, -3.15024096e-08, 0.00242084684, -3.16472253e-08, 1, -5.97823941e-08, -0.00242084684, -5.98588343e-08, -0.999997079)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Wheel" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Wheels.Wheel.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Wheel") ~= nil then
          hrp.CFrame = CFrame.new(51.3092995, 56.4138947, -101.931618, -0.999997079, -3.15024096e-08, 0.00242084684, -3.16472253e-08, 1, -5.97823941e-08, -0.00242084684, -5.98588343e-08, -0.999997079)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)          
          fireproximityprompt(workspace.Shelter.Truck.Wheels.Wheel.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Shelter.Truck.Wheels.Wheel_FrontLeft.Transparency == 0 then
          Fluent:Notify({
            Title = "ERROR",
            Content = "ALREADY ATTACH",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Attach Engine" then
        if lp.Backpack:FindFirstChild("Engine") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Engine") == nil and workspace.Shelter.Truck.Engine.Done.Value == false then
          hrp.CFrame = CFrame.new(611.939514, 59.9735718, 914.994263, 0.105314724, -1.75599215e-08, 0.994438946, -1.80728712e-08, 1, 1.95721022e-08, -0.994438946, -2.00335979e-08, 0.105314724)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables.Engine.Engine.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = CFrame.new(57.2358818, 56.3991814, -94.0194778, -0.101343475, 3.53139704e-08, 0.99485153, -6.06338668e-09, 1, -3.61143933e-08, -0.99485153, -9.6921271e-09, -0.101343475)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Engine" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.3)
          fireproximityprompt(workspace.Shelter.Truck.Engine.Engine.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Engine") ~= nil then
          hrp.CFrame = CFrame.new(57.2358818, 56.3991814, -94.0194778, -0.101343475, 3.53139704e-08, 0.99485153, -6.06338668e-09, 1, -3.61143933e-08, -0.99485153, -9.6921271e-09, -0.101343475)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Engine" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Engine.Engine.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Engine") ~= nil then
          hrp.CFrame = CFrame.new(57.2358818, 56.3991814, -94.0194778, -0.101343475, 3.53139704e-08, 0.99485153, -6.06338668e-09, 1, -3.61143933e-08, -0.99485153, -9.6921271e-09, -0.101343475)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)        
          fireproximityprompt(workspace.Shelter.Truck.Engine.Engine.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Shelter.Truck.Engine["Meshes/ls9 2.7"].Transparency == 0 then
          Fluent:Notify({
            Title = "ERROR",
            Content = "ALREADY ATTACH",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Attach Steering Wheel" then
        if lp.Backpack:FindFirstChild("Steering Wheel") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Steering Wheel") == nil and workspace.Shelter.Truck.Steering.Done.Value == false then
          hrp.CFrame = CFrame.new(25.3284569, 56.5372887, -128.344589, 0.427752227, -1.87288993e-08, 0.903896093, -9.16603042e-08, 1, 6.40967457e-08, -0.903896093, -1.10268914e-07, 0.427752227)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)          
          fireproximityprompt(workspace.Grabbables["Steering Wheel"]["Steering Wheel"].ProximityPrompt)          
          task.wait(0.2)
          hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Steering Wheel" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.3)
          fireproximityprompt(workspace.Shelter.Truck.Steering["Steering Wheel"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Steering Wheel") ~= nil then
          hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Steering Wheel" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Steering["Steering Wheel"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Steering Wheel") ~= nil then
          hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)          
          fireproximityprompt(workspace.Shelter.Truck.Steering["Steering Wheel"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Shelter.Truck.Steering.Part.Transparency == 0 then
          Fluent:Notify({
            Title = "ERROR",
            Content = "ALREADY ATTACH",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Attach Seats" then
        if lp.Backpack:FindFirstChild("Seats") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Seats") == nil and workspace.Shelter.Truck.Seats.Done.Value == false then
          if lp.Backpack:FindFirstChild("Shovel") ~= nil then
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Shovel" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            task.wait(0.2)
            hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Seats" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.Truck.Seats.Seats.ProximityPrompt)
            task.wait(0.2)
            hrp.CFrame = old
          elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") ~= nil then            
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            task.wait(0.2)
            hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Seats" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.Truck.Seats.Seats.ProximityPrompt)
            task.wait(0.2)
            hrp.CFrame = old
          elseif lp.Backpack:FindFirstChild("Shovel") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") == nil then
            hrp.CFrame = CFrame.new(140.574829, 55.8462791, 904.099182, -0.700005233, -9.33984801e-09, 0.714137733, 2.28315894e-10, 1, 1.33022944e-08, -0.714137733, 9.474725e-09, -0.700005233)
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Grabbables.Shovel.Shovel.ProximityPrompt)
            task.wait(0.3)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Shovel" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            repeat task.wait(0.2) until workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") ~= nil
            task.wait(0.3)
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            task.wait(0.2)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            task.wait(0.2)
            hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Seats" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            fireproximityprompt(workspace.Shelter.Truck.Seats.Seats.ProximityPrompt)
            task.wait(0.2)
            hrp.CFrame = old 
          end
        elseif lp.Backpack:FindFirstChild("Seats") ~= nil then
          hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Seats" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Seats.Seats.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Seats") ~= nil then
          hrp.CFrame = CFrame.new(46.1098328, 59.2773705, -95.5080566, -0.017966073, -6.48278728e-08, -0.999838591, 6.8737684e-08, 1, -6.60734898e-08, 0.999838591, -6.99136748e-08, -0.0179660749)
          task.wait(0.2)          
          fireproximityprompt(workspace.Shelter.Truck.Seats.Seats.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Shelter.Truck.Seats.VehicleSeatBack.Transparency == 0 then
          Fluent:Notify({
            Title = "ERROR",
            Content = "ALREADY ATTACH",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Attach Paint" then
        if lp.Backpack:FindFirstChild("Paint Tool") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Paint Tool") == nil and workspace.Shelter.Truck.Paint.Done.Value == false then
          hrp.CFrame = CFrame.new(1022.6156, 71.38134, 859.589661, -0.53081286, -6.92262532e-08, 0.847489059, -3.08820103e-09, 1, 7.97496966e-08, -0.847489059, 3.97149513e-08, -0.53081286)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.3)
          fireproximityprompt(workspace.Grabbables.Paint["Paint Tool"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = CFrame.new(38.7100182, 59.6424294, -94.1621246, -0.0639254227, -4.82457523e-08, -0.997954667, -2.54135646e-08, 1, -4.67167283e-08, 0.997954667, 2.23751986e-08, -0.0639254227)
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Paint Tool" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Paint["Paint Tool"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Paint Tool") ~= nil then
          hrp.CFrame = CFrame.new(38.7100182, 59.6424294, -94.1621246, -0.0639254227, -4.82457523e-08, -0.997954667, -2.54135646e-08, 1, -4.67167283e-08, 0.997954667, 2.23751986e-08, -0.0639254227)
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Paint Tool" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          fireproximityprompt(workspace.Shelter.Truck.Paint["Paint Tool"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Paint Tool") ~= nil then
          hrp.CFrame = CFrame.new(38.7100182, 59.6424294, -94.1621246, -0.0639254227, -4.82457523e-08, -0.997954667, -2.54135646e-08, 1, -4.67167283e-08, 0.997954667, 2.23751986e-08, -0.0639254227)
          task.wait(0.2)          
          fireproximityprompt(workspace.Shelter.Truck.Paint["Paint Tool"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif workspace.Shelter.Truck.Paint.Nose.Color == Color3.fromRGB(151, 0, 0) then
          Fluent:Notify({
          Title = "ERROR",
          Content = "ALREADY ATTACH",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Activity == "Eat Apple" then
        getgenv().Apple = false
        if lp.Backpack:FindFirstChild("Apple") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") == nil then
          hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          task.spawn(function()
            for i, v in pairs(workspace.Farm:GetDescendants()) do
              if v.Name == "Apple" and v:IsA("Part") and v:FindFirstChild("ProximityPrompt") and getgenv().Apple == false then
                hrp.CFrame = v.CFrame
                fireproximityprompt(v.ProximityPrompt)
              end
            end
          end)
          repeat task.wait(0.2) until lp.Backpack:FindFirstChild("Apple") or workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple")
          task.wait(0.1)
          getgenv().Apple = true
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Apple" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Apple") ~= nil then
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Apple" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") then
          game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
        end
      elseif getgenv().Activity == "Place Seed" then
        getgenv().Seed = false
        if lp.Backpack:FindFirstChild("Apple Seed") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed") == nil then
          hrp.CFrame = CFrame.new(30.4831429, 56.5372887, -136.862762, 0.940896273, -6.7141869e-08, -0.33869493, 6.10180848e-08, 1, -2.87284667e-08, 0.33869493, 6.36399156e-09, 0.940896273)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Shelter["Apple Seed Place"].Union.ProximityPrompt)
          task.wait(0.2)
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Apple Seed" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          task.spawn(function()
            for i, v in pairs(workspace.Farm:GetDescendants()) do
              if v.Name == "FarmSeed" and v:IsA("Part") and v:FindFirstChild("ProximityPrompt") and v:FindFirstChild("Apple Seed Place") and getgenv().Seed == false then
                hrp.CFrame = v.CFrame
                fireproximityprompt(v.ProximityPrompt)
              end
            end
          end)
          repeat task.wait(0.2) until not workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed")
          task.wait(0.1)
          getgenv().Seed = true
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Apple Seed") ~= nil then
          for i, v in pairs(lp.Backpack:GetChildren()) do
            if v.Name == "Apple Seed" then
              lp.Character.Humanoid:EquipTool(v)
            end
          end
          task.wait(0.2)
          hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          task.spawn(function()
            for i, v in pairs(workspace.Farm:GetDescendants()) do
              if v.Name == "FarmSeed" and v:IsA("Part") and v:FindFirstChild("ProximityPrompt") and getgenv().Seed == false then
                hrp.CFrame = v.CFrame
                fireproximityprompt(v.ProximityPrompt)
              end
            end
          end)
          repeat task.wait(0.2) until not workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed")
          task.wait(0.1)
          getgenv().Seed = true
          hrp.CFrame = old
        elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed") ~= nil then
          hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          task.spawn(function()
            for i, v in pairs(workspace.Farm:GetDescendants()) do
              if v.Name == "FarmSeed" and v:IsA("Part") and v:FindFirstChild("ProximityPrompt") and getgenv().Seed == false then
                hrp.CFrame = v.CFrame
                fireproximityprompt(v.ProximityPrompt)
              end
            end
          end)
          repeat task.wait(0.2) until not workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed")
          task.wait(0.1)
          getgenv().Seed = true
          hrp.CFrame = old
        end
      elseif getgenv().Activity == "Sleep" then
        getgenv().Sleep = false
        hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
        repeat task.wait(0.2) until not lp.GameplayPaused
        task.wait(0.4)
        for i, v in pairs(workspace.Shelter:GetDescendants()) do
          if v.Name == "Primary" and v.Parent.Name == "Bed" and v:FindFirstChild("ProximityPrompt") and getgenv().Sleep == false then
            repeat task.wait(0.2)
              hrp.CFrame = v.CFrame
            until hrp.CFrame == v.CFrame
            fireproximityprompt(v.ProximityPrompt)
          end
        end      
      elseif getgenv().Activity == "Nothing" then 
        Fluent:Notify({
          Title = "ERROR",
          Content = "PLEASE SELECT THE ACTIVITY FIRST",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
        })
      end
    end
})

local Dropdown = Tabs.Main:AddDropdown("Items", {
    Title = "Items",
    Description = "",
    Values = {"Hut Key", "Wheel", "WareHouse Key", "Hammer", "Paint", "Shovel", "Seats", "Apple", "Engine", "Water Bucket", "Steering Wheel", "SnailHouse Key", "Apple Seed"},
    Multi = false,
    Default = "",
    Callback = function(Value)
      getgenv().Item = Value
    end
})

Tabs.Main:AddButton({
    Title = "Get Item",
    Description = "",
    Callback = function()
      local hrp = lp.Character.HumanoidRootPart
      local old = hrp.CFrame
      if getgenv().Item == "Hut Key" then
        if lp.Backpack:FindFirstChild("Hut Key") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Hut Key") == nil then
          hrp.CFrame = CFrame.new(1114.92371, 55.9637108, 196.167587, -0.306804508, -3.71351447e-08, -0.951772511, 1.18919896e-08, 1, -4.28502211e-08, 0.951772511, -2.44651108e-08, -0.306804538)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          fireproximityprompt(workspace.Grabbables["Hut Key"].ProximityPrompt)     
          repeat task.wait(0.2) until lp.Backpack:FindFirstChild("Hut Key")
          hrp.CFrame = old                  
        elseif lp.Backpack:FindFirstChild("Hut Key") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Hut Key") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Wheel" then        
        if lp.Backpack:FindFirstChild("Wheel") == nil and workspace.Shelter.Truck.Wheels.Done.Value == false and workspace.Players[tostring(lp.Name)]:FindFirstChild("Wheel") == nil then
          hrp.CFrame = CFrame.new(1147.07996, 55.9864388, 206.178238, -0.877708137, -8.31582341e-08, 0.479195625, -1.1075705e-07, 1, -2.93285787e-08, -0.479195625, -7.88162211e-08, -0.877708137)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.2)
          fireproximityprompt(workspace.Grabbables.Wheels.Wheel.ProximityPrompt)
          for i, v in pairs(workspace.Grabbables.Wheels:GetDescendants()) do
            if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then
              fireproximityprompt(v)
            end
          end
          task.wait(0.2)
          hrp.CFrame = old        
        elseif lp.Backpack:FindFirstChild("Wheel") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Wheel") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        elseif workspace.Shelter.Truck.Wheel.Done.Value == true then
          Fluent:Notify({
            Title = "ERROR",
            Content = "THE ITEM ALREADY ATTACH TO TRUCK",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "WareHouse Key" then
        if lp.Backpack:FindFirstChild("Warehouse Key") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Warehouse Key") == nil then
          hrp.CFrame = CFrame.new(1161.54834, 62.7582817, 403.851318, 0.470124811, 6.00592198e-09, -0.88259995, -3.36824502e-09, 1, 5.01068032e-09, 0.88259995, 6.17167706e-10, 0.470124811)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables["Warehouse Key"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Warehouse Key") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Warehouse Key") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Engine" then
        if lp.Backpack:FindFirstChild("Engine") == nil and workspace.Shelter.Truck.Engine.Done.Value == false and workspace.Players[tostring(lp.Name)]:FindFirstChild("Engine") == nil then
          hrp.CFrame = CFrame.new(611.939514, 59.9735718, 914.994263, 0.105314724, -1.75599215e-08, 0.994438946, -1.80728712e-08, 1, 1.95721022e-08, -0.994438946, -2.00335979e-08, 0.105314724)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables.Engine.Engine:WaitForChild("ProximityPrompt"))
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Engine") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Engine") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        elseif workspace.Shelter.Truck.Engine.Done.Value == true then
          Fluent:Notify({
            Title = "ERROR",
            Content = "THE ITEM ALREADY ATTACH TO TRUCK",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Shovel" then
        if lp.Backpack:FindFirstChild("Shovel") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") == nil then
          hrp.CFrame = CFrame.new(140.574829, 55.8462791, 904.099182, -0.700005233, -9.33984801e-09, 0.714137733, 2.28315894e-10, 1, 1.33022944e-08, -0.714137733, 9.474725e-09, -0.700005233)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables.Shovel.Shovel.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Shovel") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Apple" then
        if lp.Backpack:FindFirstChild("Apple") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") == nil then
          hrp.CFrame = CFrame.new(88.6800919, 55.9996948, 932.230164, 0.990285218, 1.30156437e-08, -0.139050946, -7.10417103e-09, 1, 4.30093259e-08, 0.139050946, -4.16036592e-08, 0.990285218)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Farm:GetChildren()[7]:GetChildren()[5].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Apple") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Seats" then
        if lp.Backpack:FindFirstChild("Seats") == nil and workspace.Shelter.Truck.Seats.Done.Value == false and workspace.Players[tostring(lp.Name)]:FindFirstChild("Seats") == nil then
          if lp.Backpack:FindFirstChild("Shovel") ~= nil then
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Shovel" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            hrp.CFrame = old
          elseif workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") ~= nil then            
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            hrp.CFrame = old
          elseif lp.Backpack:FindFirstChild("Shovel") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Shovel") == nil then
            hrp.CFrame = CFrame.new(140.574829, 55.8462791, 904.099182, -0.700005233, -9.33984801e-09, 0.714137733, 2.28315894e-10, 1, 1.33022944e-08, -0.714137733, 9.474725e-09, -0.700005233)
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Grabbables.Shovel.Shovel.ProximityPrompt)
            task.wait(0.2)
            for i, v in pairs(lp.Backpack:GetChildren()) do
              if v.Name == "Shovel" then
                lp.Character.Humanoid:EquipTool(v)
              end
            end
            task.wait(0.2)
            hrp.CFrame = CFrame.new(112.098579, 55.9896202, 940.053711, -0.766663432, -1.15261409e-08, 0.642049134, -4.9540807e-09, 1, 1.20365051e-08, -0.642049134, 6.04718497e-09, -0.766663432)            
            repeat task.wait(0.2) until not lp.GameplayPaused
            task.wait(0.1)
            fireproximityprompt(workspace.Farm.Dig.FarmDigs.ProximityPrompt)
            task.wait(0.2)
            workspace.Players[tostring(lp.Name)].Shovel.Parent = lp.Backpack
            task.wait(0.1)
            workspace.Players[tostring(lp.Name)].Seats.Parent = lp.Backpack
            hrp.CFrame = old
          end
        elseif lp.Backpack:FindFirstChild("Seats") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Seats") ~= nil then
          Fluent:Notify({
            Title = "ERROR",
            Content = "YOU ALREADY HAVE IT",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        elseif workspace.Shelter.Truck.Seats.Done.Value == true then
          Fluent:Notify({
            Title = "ERROR",
            Content = "THE ITEM ALREADY ATTACH TO TRUCK",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Paint" then
        if lp.Backpack:FindFirstChild("Paint Tool") == nil and workspace.Shelter.Truck.Paint.Done.Value == false and workspace.Players[tostring(lp.Name)]:FindFirstChild("Paint Tool") == nil then
          hrp.CFrame = CFrame.new(1022.6156, 71.38134, 859.589661, -0.53081286, -6.92262532e-08, 0.847489059, -3.08820103e-09, 1, 7.97496966e-08, -0.847489059, 3.97149513e-08, -0.53081286)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables.Paint["Paint Tool"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Paint Tool") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Paint Tool") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        elseif workspace.Shelter.Truck.Paint.Done.Value == true then
          Fluent:Notify({
            Title = "ERROR",
            Content = "THE ITEM ALREADY ATTACH TO TRUCK",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Water Bucket" then
        if lp.Backpack:FindFirstChild("Water Bucket") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Water Bucket") == nil then
          hrp.CFrame = CFrame.new(134.298721, 57.052597, 447.872284, 0.0271485131, 8.72740458e-08, 0.999631464, -7.80113254e-08, 1, -8.51875583e-08, -0.999631464, -7.56698526e-08, 0.0271485131)
          repeat task.wait(0.2) until not lp.GameplayPaused
          repeat task.wait(0.1)
            fireproximityprompt(workspace.Lake["Water Bucket"].Pot.ProximityPrompt)
          until lp.Backpack:FindFirstChild("Water Bucket")
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Water Bucket") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Water Bucket") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "SnailHouse Key" then
        if lp.Backpack:FindFirstChild("Snailhouse Key") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Snailhouse Key") == nil then        
          hrp.CFrame = CFrame.new(30.4831429, 56.5372887, -136.862762, 0.940896273, -6.7141869e-08, -0.33869493, 6.10180848e-08, 1, -2.87284667e-08, 0.33869493, 6.36399156e-09, 0.940896273)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait()
          fireproximityprompt(workspace.Grabbables["Snailhouse Key"].ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Snailhouse Key") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Snailhouse Key") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Apple Seed" then
        if lp.Backpack:FindFirstChild("Apple Seed") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed") == nil then
          hrp.CFrame = CFrame.new(30.4831429, 56.5372887, -136.862762, 0.940896273, -6.7141869e-08, -0.33869493, 6.10180848e-08, 1, -2.87284667e-08, 0.33869493, 6.36399156e-09, 0.940896273)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Shelter["Apple Seed Place"].Union.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Apple Seed") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Apple Seed") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Steering Wheel" then
         if lp.Backpack:FindFirstChild("Steering Wheel") == nil and workspace.Shelter.Truck.Steering.Done.Value == false and workspace.Players[tostring(lp.Name)]:FindFirstChild("Steering Wheel") == nil then          
           hrp.CFrame = CFrame.new(25.3284569, 56.5372887, -128.344589, 0.427752227, -1.87288993e-08, 0.903896093, -9.16603042e-08, 1, 6.40967457e-08, -0.903896093, -1.10268914e-07, 0.427752227)
           repeat task.wait(0.2) until not lp.GameplayPaused
           task.wait(0.1)
           fireproximityprompt(workspace.Grabbables["Steering Wheel"]["Steering Wheel"].ProximityPrompt)
           task.wait(0.2)
           hrp.CFrame = old
         elseif lp.Backpack:FindFirstChild("Steering Wheel") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Steering Wheel") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        elseif workspace.Shelter.Truck.Steering.Done.Value == true then
          Fluent:Notify({
            Title = "ERROR",
            Content = "THE ITEM ALREADY ATTACH TO TRUCK",
            SubContent = "", -- Optional
            Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Drinking Glass" then
        if lp.Backpack:FindFirstChild("Drinking Glass") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") == nil then                   
          hrp.CFrame = CFrame.new(27.2257442, 56.5372925, -135.588196, 0.309803575, -7.90111443e-08, 0.950800538, 3.16892113e-08, 1, 7.27741565e-08, -0.950800538, 7.58442553e-09, 0.309803575)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Shelter["Shelf with Drinks"].Primary.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Drinking Glass") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Drinking Glass") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Hammer" then
        if lp.Backpack:FindFirstChild("Hammer") == nil and workspace.Players[tostring(lp.Name)]:FindFirstChild("Hammer") == nil then                   
          hrp.CFrame = CFrame.new(647.531982, 55.8801765, 894.881348, -0.846374929, 2.19782361e-08, -0.532587528, -3.20614202e-09, 1, 4.63620218e-08, 0.532587528, 4.09472065e-08, -0.846374929)
          repeat task.wait(0.2) until not lp.GameplayPaused
          task.wait(0.1)
          fireproximityprompt(workspace.Grabbables.Hammer.Hammer.ProximityPrompt)
          task.wait(0.2)
          hrp.CFrame = old
        elseif lp.Backpack:FindFirstChild("Hammer") ~= nil or workspace.Players[tostring(lp.Name)]:FindFirstChild("Hammer") ~= nil then
          Fluent:Notify({
          Title = "ERROR",
          Content = "YOU ALREADY HAVE IT",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
        end
      elseif getgenv().Item == "Nothing" then
        Fluent:Notify({
          Title = "ERROR",
          Content = "PLEASE SELECT THE ITEM FIRST",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
      end
    end
})

local Dropdown = Tabs.Main:AddDropdown("Location", {
    Title = "Location",
    Description = "",
    Values = {"In WareHouse", "Outside WareHouse", "In SnailHouse", "Outside SnailHouse", "Monument", "Lake", "Farm", "GreekHouse", "Shelter"},
    Multi = false,
    Default = "",
    Callback = function(Value)
      getgenv().Location = Value
    end
})

Tabs.Main:AddButton({
    Title = "Teleport To Location",
    Description = "",
    Callback = function()
      local hrp = lp.Character.HumanoidRootPart
      if getgenv().Location == "In WareHouse" then
        hrp.CFrame = CFrame.new(1010.40271, 56.0720673, 842.081299, -0.772180438, 5.96541412e-08, -0.635403275, 2.09251461e-08, 1, 6.84543977e-08, 0.635403275, 3.95632433e-08, -0.772180438)
      elseif getgenv().Location == "Outside WareHouse" then
        hrp.CFrame = CFrame.new(985.757263, 55.8291054, 814.237061, -0.809321642, -5.01599899e-08, -0.587365687, -9.78364767e-08, 1, 4.94090742e-08, 0.587365687, 9.74536221e-08, -0.809321642)
      elseif getgenv().Location == "Monument" then
        hrp.CFrame = CFrame.new(1151.79492, 56.0027237, 200.356094, -0.996182024, -1.81165316e-09, 0.0873001739, -4.83541784e-09, 1, -3.44249393e-08, -0.0873001814, -3.47156366e-08, -0.996182024)
      elseif getgenv().Location == "In SnailHouse" then
        hrp.CFrame = CFrame.new(611.939514, 59.9735718, 914.994263, 0.105314724, -1.75599215e-08, 0.994438946, -1.80728712e-08, 1, 1.95721022e-08, -0.994438946, -2.00335979e-08, 0.105314724)
      elseif getgenv().Location == "Farm" then
        hrp.CFrame = CFrame.new(103.814682, 55.9863548, 966.578674, 0.798175871, 1.64670126e-08, -0.602424502, -6.88385526e-08, 1, -6.3872335e-08, 0.602424502, 9.24513941e-08, 0.798175871)
      elseif getgenv().Location == "GreekHouse" then
        hrp.CFrame = CFrame.new(1160.42407, 62.7539558, 404.274475, 0.428958058, 1.66924732e-08, -0.903324425, -8.71373942e-08, 1, -2.2899652e-08, 0.903324425, 8.85363249e-08, 0.428958058)
      elseif getgenv().Location == "Lake" then
        hrp.CFrame = CFrame.new(128.591125, 56.7658882, 436.911987, 0.0405651666, 1.03102444e-07, 0.999176919, -7.0914318e-08, 1, -1.00308355e-07, -0.999176919, -6.67869315e-08, 0.0405651666)
      elseif getgenv().Location == "Shelter" then
        hrp.CFrame = CFrame.new(73.6355438, 55.9023209, -117.283447, 0.451259643, -3.19775708e-08, 0.892392755, 2.69615263e-08, 1, 2.21997798e-08, -0.892392755, 1.40424055e-08, 0.451259643)
      elseif getgenv().Location == "Outside SnailHouse" then
        hrp.CFrame = CFrame.new(621.790894, 55.8430138, 881.133423, -0.988965988, -2.62766964e-08, 0.148142621, -2.87977198e-08, 1, -1.48726214e-08, -0.148142621, -1.89746867e-08, -0.988965988)
      elseif getgenv().Location == "Nothing" then
        Fluent:Notify({
          Title = "ERROR",
          Content = "PLEASE SELECT THE LOCATION FIRST",
          SubContent = "", -- Optional
          Duration = 9 -- Set to nil to make the notification not disappear
          })
      end
    end
})

-----\\ PLAYER //-----

local Toggle = Tabs.Player:AddToggle("Infinite Stamina", 
{
    Title = "Infinite Stamina", 
    Description = "",
    Default = false,
    Callback = function(state)
      if state then
        infinitestamina = false
        repeat task.wait(0.1)
          if game:GetService("Players").LocalPlayer.PlayerGui.Time:GetChildren()[7].stamina.Value <= 249 then
            game:GetService("Players").LocalPlayer.PlayerGui.Time:GetChildren()[7].stamina.Value = 250
          end
        until infinitestamina
      end
      if not state then
        infinitestamina = true
      end
    end 
})

local Slider = Tabs.Player:AddSlider("WalkSpeed", 
{
    Title = "WalkSpeed",
    Description = "",
    Default = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,
    Min = 10,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
      getgenv().WalkSpeed = Value
    end
})

local Toggle = Tabs.Player:AddToggle("Active WalkSpeed", 
{
    Title = "Active WalkSpeed", 
    Description = "",
    Default = false,
    Callback = function(state)
      getgenv().ActiveWalkSpeed = false
      if state then
        getgenv().ActiveWalkSpeed = true
        repeat task.wait(0.1)
          if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= getgenv().WalkSpeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
          end
        until not getgenv().ActiveWalkSpeed
      end
      if not state then
        getgenv().ActiveWalkSpeed = false
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 10
      end
    end 
})

local Slider = Tabs.Player:AddSlider("Jump Power", 
{
    Title = "Jump Power",
    Description = "",
    Default = game.Players.LocalPlayer.Character.Humanoid.JumpHeight,
    Min = 7.15,
    Max = 50,
    Rounding = 1,
    Callback = function(Value)
      getgenv().JumpPower = Value
    end
})

local Toggle = Tabs.Player:AddToggle("Active Jump Power", 
{
    Title = "Active Jump Power", 
    Description = "",
    Default = false,
    Callback = function(state)
      getgenv().ActiveJumpPower = false
      if state then
        getgenv().ActiveJumpPower = true
        repeat task.wait(0.5)
          if game.Players.LocalPlayer.Character.Humanoid.JumpHeight ~= getgenv().JumpPower then
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = getgenv().JumpPower
          end
        until not getgenv().ActiveJumpPower
      end
      if not state then
        getgenv().ActiveJumpPower = false
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 7.15
      end
    end 
})

------\\ CREDIT //-----

Tabs.Credit:AddButton({
    Title = "Youtube Channel",
    Description = "",
    Callback = function()
        setclipboard("https://www.youtube.com/@Nevcit")
    end
})

-------\\ SAVE //---------

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nevcit/UI-Library/refs/heads/main/Loadstring/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
  
InterfaceManager:SetFolder("GOAHUB")
SaveManager:SetFolder("GOAHUB/Weird-Strict-Dad")

InterfaceManager:BuildInterfaceSection(Tabs.Save)
SaveManager:BuildConfigSection(Tabs.Save)

----------\\ TOOGLE //-----------

Fluent:Notify({
  Title = "READ",
  Content = "IF YOU FOUND BUG, COMMENT ON MY YOUTUBE CHANNEL",
  SubContent = "", -- Optional
  Duration = 9 -- Set to nil to make the notification not disappear
})

for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
  if gui.Name == "Nevcit" then
    gui:Destroy()
  end
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
Button.MouseButton1Click:Connect(function()
  if minimize.Visible == true then
    minimize.Visible = false
  elseif minimize.Visible == false then
    minimize.Visible = true
  end
end)