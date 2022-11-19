if game.PlaceId == 286090429 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("FPK_Cheats (Arsenal)", "BloodTheme")
    -- MAIN
    local Misc = Window:NewTab("Misc")
    local MiscSection = Misc:NewSection("Misc")
    
    MiscSection:NewSlider("Set FPS cap", "Set Your FPS cap", 120, 1, function(s)
        setfpscap(s)
    end)

	MiscSection:NewToggle("Night Time", "Sets time to night", function(state)
        lighting = game:GetService("Lighting")
        if lighting.TimeOfDay == "00:00:00" then
            lighting.TimeOfDay = 11
        else 
            lighting.TimeOfDay = 24
        end
    end)
    
	MiscSection:NewKeybind("Set Hide Keybind", "Sets a keybind to hide the gui", Enum.KeyCode.F, function()
	    Library:ToggleUI()
    end)

	MiscSection:NewToggle("God Mode (CANT MOVE UNTIL RESTART)", "You are invisible", function(s)
		if s then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
            		humanoid:ChangeState('Dead')
            		wait()
		end
    end)

    local Combat = Window:NewTab("Combat")
    local CombatSection = Combat:NewSection("Combat")
    
    CombatSection:NewToggle("WallBang", "Are You Serious Right Neow Bro?", function(state)
        
        if state then
            getgenv().Wallbang = true
            local mt = getrawmetatable(game)
            local namecallold = mt.__namecall
            setreadonly(mt, false)
            mt.__namecall = newcclosure(function(self, ...)
                local Args = {...}
                NamecallMethod = getnamecallmethod()
                if getgenv().Wallbang and tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
                    table.insert(Args[2], workspace.Map)
                end
                return namecallold(self, ...)
            end)
            loadstring(game:HttpGet("https://pastebin.com/raw/F3j9qi5h", true))()
            setreadonly(mt, true)
        else
            getgenv().Wallbang = false
        end
    end)
    
	CombatSection:NewLabel("Safe")
    CombatSection:NewToggle("Soft Aim (UPPER TORSO)", "Just Shoot", function(state)
        if state then 
            _G.aimr = true
			_G.aimry = false
            
        else
            _G.aimr = false
            game.StarterGui:SetCore("SendNotification", {Title="FPK_Cheats"; Text="Soft Aim exploit is off!"; Duration=5;})
        end
        if _G.aimr == true then
            game.StarterGui:SetCore("SendNotification", {Title="FPK_Cheats"; Text="Soft Aim exploit is on!"; Duration=5;})
            local CurrentCamera = workspace.CurrentCamera
            local Players = game.GetService(game, "Players")
            local LocalPlayer = Players.LocalPlayer
            local Mouse = LocalPlayer:GetMouse()
            function ClosestPlayer()
                local MaxDist, Closest = math.huge
                for I,V in pairs(Players.GetPlayers(Players)) do
                    if _G.aimr == true then
                        if V == LocalPlayer then continue end
                        if V.Team == LocalPlayer then continue end
                        if not V.Character then continue end
                        local UpperTorso = V.Character.FindFirstChild(V.Character, "UpperTorso")
                        if not UpperTorso then continue end
                        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, UpperTorso.Position)
                        if not Vis then continue end
                        local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                        local Dist = (TheirPos - MousePos).Magnitude
                        if Dist < MaxDist then
                            MaxDist = Dist
                            Closest = V
                            print("working")
                        end
                    end
                end
                return Closest
            end
            local MT = getrawmetatable(game)
            local OldNC = MT.__namecall
            local OldIDX = MT.__index
            setreadonly(MT, false)
            MT.__namecall = newcclosure(function(self, ...)
                local Args, Method = {...}, getnamecallmethod()
                if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
                    local CP = ClosestPlayer()
                    if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "UpperTorso") then
						if _G.aimr == true then
                        	Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.UpperTorso.Position - CurrentCamera.CFrame.Position).Unit * 1000)
                        	return OldNC(self, unpack(Args))
						end
                    end
                end
                return OldNC(self, ...)
            end)
            MT.__index = newcclosure(function(self, K)
                if K == "Clips" then
                    return workspace.Map
                end
                return OldIDX(self, K)
            end)
            setreadonly(MT, true)
        end
    end)

	CombatSection:NewToggle("Aimbot (UPPER TORSO) (X)", "Snaps To Player", function(state)

		local localPlayer = game:GetService("Players").LocalPlayer

		if state then

			local function player()
				local target = nil
				local dist = math.huge
				
				for i, v in pairs(game:GetService("Players"):GetPlayers()) do
					if v.Name ~= localPlayer.Name then
						if v.Character and v.Character:FindFirstChild("UpperTorso") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("UpperTorso") and v.TeamColor ~= localPlayer.TeamColor then
							local magnitude = (v.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).magnitude

							if magnitude < dist then
								target = v
								dist = magnitude
							end
						end
					end
				end
				
				return target
			end


			local camera = game.Workspace.CurrentCamera
			local UIS = game:GetService("UserInputService")
			local aim = false

			game:GetService("RunService").RenderStepped:Connect(function()
				if aim then
					camera.CFrame = CFrame.new(camera.CFrame.Position,player().Character.UpperTorso.Position)
				end
			end)

			UIS.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton2 then
					aim = true
				end
			end)

			UIS.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton2 then
					aim = false
				end
			end)
		end
		
	end)

	CombatSection:NewLabel("Risky")
	CombatSection:NewToggle("Soft Aim (HEAD) (X)", "Just Shoot", function(state)
        
        
        if state then 
            _G.aimry = true
			_G.aimr = false
            
        else
            _G.aimry = false
            game.StarterGui:SetCore("SendNotification", {Title="FPK_Cheats"; Text="Soft Aim exploit is off!"; Duration=5;})
        end
        if _G.aimry == true then
            game.StarterGui:SetCore("SendNotification", {Title="FPK_Cheats"; Text="Soft Aim exploit is on!"; Duration=5;})
            local CurrentCamera = workspace.CurrentCamera
            local Players = game.GetService(game, "Players")
            local LocalPlayer = Players.LocalPlayer
            local Mouse = LocalPlayer:GetMouse()
            function ClosestPlayer()
                local MaxDist, Closest = math.huge
                for I,V in pairs(Players.GetPlayers(Players)) do
                    if _G.aimry == true then
                        if V == LocalPlayer then continue end
                        if V.Team == LocalPlayer then continue end
                        if not V.Character then continue end
                        local Head = V.Character.FindFirstChild(V.Character, "Head")
                        if not Head then continue end
                        local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
                        if not Vis then continue end
                        local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                        local Dist = (TheirPos - MousePos).Magnitude
                        if Dist < MaxDist then
                            MaxDist = Dist
                            Closest = V
                            print("working")
                        end
                    end
                end
                return Closest
            end
            local MT = getrawmetatable(game)
            local OldNC = MT.__namecall
            local OldIDX = MT.__index
            setreadonly(MT, false)
            MT.__namecall = newcclosure(function(self, ...)
                local Args, Method = {...}, getnamecallmethod()
                if Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
                    local CP = ClosestPlayer()
                    if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, "Head") then
						if _G.aimry == true then
                        	Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character.Head.Position - CurrentCamera.CFrame.Position).Unit * 1000)
                        	return OldNC(self, unpack(Args))
						end
                    end
                end
                return OldNC(self, ...)
            end)
            MT.__index = newcclosure(function(self, K)
                if K == "Clips" then
                    return workspace.Map
                end
                return OldIDX(self, K)
            end)
            setreadonly(MT, true)
        end
    end)

	CombatSection:NewToggle("Aimbot (HEAD)", "Snaps To Player", function(state)

		local localPlayer = game:GetService("Players").LocalPlayer

		if state then

			local function player()
				local target = nil
				local dist = math.huge
				
				for i, v in pairs(game:GetService("Players"):GetPlayers()) do
					if v.Name ~= localPlayer.Name then
						if v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") and v.TeamColor ~= localPlayer.TeamColor then
							local magnitude = (v.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).magnitude

							if magnitude < dist then
								target = v
								dist = magnitude
							end
						end
					end
				end
				
				return target
			end


			local camera = game.Workspace.CurrentCamera
			local UIS = game:GetService("UserInputService")
			local aim = false

			game:GetService("RunService").RenderStepped:Connect(function()
				if aim then
					camera.CFrame = CFrame.new(camera.CFrame.Position,player().Character.Head.Position)
				end
			end)

			UIS.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton2 then
					aim = true
				end
			end)

			UIS.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton2 then
					aim = false
				end
			end)
		end
		
	end)
    
    local GunMod = Window:NewTab("Gun Mods")
    local GunModSection = GunMod:NewSection("Some Of This Can't Be Turned Off!!")

    GunModSection:NewToggle("Infinite Ammo", "Just read", function(state)
        
        if state then
            _G.LPP = true
        else
            _G.LPP = false
        end
        while _G.LPP == true do
            wait()
            game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999
            game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end
    end)

    GunModSection:NewButton("Fire rate", "Sets your fire rate", function(s)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "FireRate" or c.Name == "BFireRate" then
                    c.Value = 0.02 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)

    GunModSection:NewToggle("Allways Auto", "Is this single fire? -No", function(state)
        if state then
            for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
                for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                    for i,x in next, getconnections(c.Changed) do
                        x:Disable() -- probably not needed
                    end
                    if c.Name == "Auto" then
                        c.Value = true -- don't set this above 300 or else your guns wont work
                    end
                end
            end
        else
            print("Ok!")
        end
    end)

    GunModSection:NewButton("Inf Range", "Shiper", function(txt)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "Range" then
                    c.Value = 9e9 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)
    GunModSection:NewButton("No Recoil", "Man... This Weapon is Stable", function(txt)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "RecoilControl" then
                    c.Value = 0 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)
    GunModSection:NewButton("Fast Reload", "Im Flash", function(txt)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "AReload" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" then
                    c.Value = 0 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)
    GunModSection:NewButton("No Spread", "Just Where i was looking", function(txt)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "Spread" or c.Name == "MaxSpread" then
                    c.Value = 0 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)
    GunModSection:NewButton("Fast Equip", "Im Flash... Again", function(txt)
        for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
            for i,c in next, v:GetChildren() do -- for some reason, using GetDescendants dsent let you modify weapon ammo, so I do this instead
                for i,x in next, getconnections(c.Changed) do
                    x:Disable() -- probably not needed
                end
                if c.Name == "EquipTime" then
                    c.Value = 0 -- don't set this above 300 or else your guns wont work
                end
            end
        end
    end)
    local Movement = Window:NewTab("Movement")
    local MovementSection = Movement:NewSection("Movement")

    MovementSection:NewSlider("Walkspeed", "Set Your Humanoid Speed", 500, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

	MovementSection:NewToggle("Inf Jump", "Jump Forever", function(state)
		_G.infinjum = not _G.infinjum
        _G.infinJumStarted = true
		if state then
			game.StarterGui:SetCore("SendNotification", {Title="FPK_Cheats"; Text="Infinite Jump exploit is on!"; Duration=5;})
            local plr = game:GetService('Players').LocalPlayer
            local m = plr:GetMouse()
            m.KeyDown:connect(function(k)
                if _G.infinjum then
                    if k:byte() == 32 then
						if state then
                    		humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                    		humanoid:ChangeState('Jumping')
                    		wait()
							humanoid:ChangeState('PlatformStanding')
                    		wait()
                    		humanoid:ChangeState('Jumping')
						end
                    end
                end
            end)
		else
			print("...")
		end
    end)
	

    local Visual = Window:NewTab("Visual")
    local VisualSection = Visual:NewSection("Visual")
    
    VisualSection:NewButton("Apply Player Chams", "ye", function()
        local dwEntities = game:GetService("Players")
	local dwLocalPlayer = dwEntities.LocalPlayer 
	local dwRunService = game:GetService("RunService")

	local settings_tbl = {
	    ESP_Enabled = true,
	    ESP_TeamCheck = false,
	    Chams = true,
	    Chams_Color = Color3.fromRGB(0,0,255),
	    Chams_Transparency = 0.99,
	    Chams_Glow_Color = Color3.fromRGB(0,255,0)
	}

	function destroy_chams(char)

	    for k,v in next, char:GetChildren() do 

		if v:IsA("BasePart") and v.Transparency ~= 1 then

		    if v:FindFirstChild("Glow") and 
		    v:FindFirstChild("Chams") then

			v.Glow:Destroy()
			v.Chams:Destroy() 

		    end 

		end 

	    end 

	end

	dwRunService.Heartbeat:Connect(function()

	    if settings_tbl.ESP_Enabled then

		for k,v in next, dwEntities:GetPlayers() do 

		    if v ~= dwLocalPlayer then

			if v.Character and
			v.Character:FindFirstChild("HumanoidRootPart") and 
			v.Character:FindFirstChild("Humanoid") and 
			v.Character:FindFirstChild("Humanoid").Health ~= 0 then

			    if settings_tbl.ESP_TeamCheck == false then

				local char = v.Character 

				for k,b in next, char:GetChildren() do 

				    if b:IsA("BasePart") and 
				    b.Transparency ~= 1 then

					if settings_tbl.Chams then

					    if not b:FindFirstChild("Glow") and
					    not b:FindFirstChild("Chams") then

						local chams_box = Instance.new("BoxHandleAdornment", b)
						chams_box.Name = "Chams"
						chams_box.AlwaysOnTop = true
						chams_box.ZIndex = 4 
						chams_box.Adornee = b 
						chams_box.Color3 = settings_tbl.Chams_Color
						chams_box.Transparency = settings_tbl.Chams_Transparency
						chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

						local glow_box = Instance.new("BoxHandleAdornment", b)
						glow_box.Name = "Glow"
						glow_box.AlwaysOnTop = false
						glow_box.ZIndex = 3 
						glow_box.Adornee = b 
						glow_box.Color3 = settings_tbl.Chams_Glow_Color
						glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

					    end

					else

					    destroy_chams(char)

					end

				    end

				end

			    else

				if v.Team == dwLocalPlayer.Team then
				    destroy_chams(v.Character)
				end

			    end

			else

			    destroy_chams(v.Character)

			end

		    end

		end

	    else 

		for k,v in next, dwEntities:GetPlayers() do 

		    if v ~= dwLocalPlayer and 
		    v.Character and 
		    v.Character:FindFirstChild("HumanoidRootPart") and 
		    v.Character:FindFirstChild("Humanoid") and 
		    v.Character:FindFirstChild("Humanoid").Health ~= 0 then

			destroy_chams(v.Character)

		    end

		end

	    end

	end)
    end)

    VisualSection:NewButton("Disable Player Chams", "ye", function()
	v.Chams:Destroy()
	v.Glow:Destroy()
        local dwEntities = game:GetService("Players")
	local dwLocalPlayer = dwEntities.LocalPlayer 
	local dwRunService = game:GetService("RunService")

	local settings_tbl = {
	    ESP_Enabled = false,
	    ESP_TeamCheck = false,
	    Chams = false,
	    Chams_Color = Color3.fromRGB(0,0,255),
	    Chams_Transparency = 0.1,
	    Chams_Glow_Color = Color3.fromRGB(255,0,0)
	}
	v.Chams:Destroy()
	v.Glow:Destroy()
	function destroy_chams(char)

	    for k,v in next, char:GetChildren() do 

		if v:IsA("BasePart") and v.Transparency ~= 1 then

		    if v:FindFirstChild("Glow") and 
		    v:FindFirstChild("Chams") then

			v.Glow:Destroy()
			v.Chams:Destroy() 

		    end 

		end 

	    end 

	end

	dwRunService.Heartbeat:Connect(function()

	    if settings_tbl.ESP_Enabled then

		for k,v in next, dwEntities:GetPlayers() do 

		    if v ~= dwLocalPlayer then

			if v.Character and
			v.Character:FindFirstChild("HumanoidRootPart") and 
			v.Character:FindFirstChild("Humanoid") and 
			v.Character:FindFirstChild("Humanoid").Health ~= 0 then

			    if settings_tbl.ESP_TeamCheck == false then

				local char = v.Character 

				for k,b in next, char:GetChildren() do 

				    if b:IsA("BasePart") and 
				    b.Transparency ~= 1 then

					if settings_tbl.Chams then

					    if not b:FindFirstChild("Glow") and
					    not b:FindFirstChild("Chams") then

						local chams_box = Instance.new("BoxHandleAdornment", b)
						chams_box.Name = "Chams"
						chams_box.AlwaysOnTop = false
						chams_box.ZIndex = 4 
						chams_box.Adornee = b 
						chams_box.Color3 = settings_tbl.Chams_Color
						chams_box.Transparency = settings_tbl.Chams_Transparency
						chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

						local glow_box = Instance.new("BoxHandleAdornment", b)
						glow_box.Name = "Glow"
						glow_box.AlwaysOnTop = true
						glow_box.ZIndex = 3 
						glow_box.Adornee = b 
						glow_box.Color3 = settings_tbl.Chams_Glow_Color
						glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

					    end

					else

					    destroy_chams(char)

					end

				    end

				end

			    else

				if v.Team == dwLocalPlayer.Team then
				    destroy_chams(v.Character)
				end

			    end

			else

			    destroy_chams(v.Character)

			end

		    end

		end

	    else 

		for k,v in next, dwEntities:GetPlayers() do 

		    if v ~= dwLocalPlayer and 
		    v.Character and 
		    v.Character:FindFirstChild("HumanoidRootPart") and 
		    v.Character:FindFirstChild("Humanoid") and 
		    v.Character:FindFirstChild("Humanoid").Health ~= 0 then

			destroy_chams(v.Character)

		    end

		end

	    end
	    v.Chams:Destroy()
	    v.Glow:Destroy()

	end)
    end)

	VisualSection:NewButton("FPS BOOST", "DUUUH", function(stt)
		local a = game
		local b = a.Workspace
		local c = a.Lighting
		local d = b.Terrain
		d.WaterWaveSize = 0
		d.WaterWaveSpeed = 0
		d.WaterReflectance = 0
		d.WaterTransparency = 0
		c.GlobalShadows = false
		c.FogEnd = 9e9
		settings().Rendering.QualityLevel = "Level01"
		for e, f in pairs(a:GetDescendants()) do
		if f:IsA("Part") or f:IsA("Union") or f:IsA("CornerWedgePart") or f:IsA("TrussPart") then
			f.Reflectance = 0
		elseif f:IsA("Decal") or f:IsA("Texture") then
			f.Transparency = 0
		elseif f:IsA("ParticleEmitter") or f:IsA("Trail") then
			f.Lifetime = NumberRange.new(0)
		elseif f:IsA("Explosion") then
			f.BlastPressure = 0
			f.BlastRadius = 0
		elseif f:IsA("Fire") or f:IsA("SpotLight") or f:IsA("Smoke") or f:IsA("Sparkles") then
			f.Enabled = false
		elseif f:IsA("MeshPart") then
			f.Reflectance = 0
		end
		if f:IsA("Fire") then
			f:Destroy()
			wait()
		end
		if string.find(f.Name:lower(), "door") then
			f:Destroy()
		end
		if string.find(f.Name:lower(), "tree") then
			f:Destroy()
		end
		if f:IsA("ParticleEmitter") then
			f:Destroy()
			wait()
		end
		end
		for e, g in pairs(c:GetChildren()) do
		if
			g:IsA("BlurEffect") or g:IsA("SunRaysEffect") or g:IsA("ColorCorrectionEffect") or g:IsA("BloomEffect") or
				g:IsA("DepthOfFieldEffect")
			then
			g.Enabled = false
		end
		end
	end)

	local Teleports = Window:NewTab("Teleports")
    local TeleportsSection = Teleports:NewSection("Player Teleports")
    
    TeleportsSection:NewTextBox("Player Username", "Input Player Name", function(txt)
        _G.txte = txt
    end)
    
    TeleportsSection:NewButton("TP", "Teleport To Player", function(txt)
        targetUsername = _G.txte
        players = game:GetService("Players")
        targetPlayer = players:FindFirstChild(targetUsername)
        players.LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
    end)
    
    TeleportsSection:NewToggle("Stay On Top Of Player", "Teleport To Player Inf", function(t)
        if t then
             _G.onu = true --Set to false if you want to turn it off

            while wait() do
            
                if _G.onu == true then
                    targetUsername = _G.txte
                    players = game:GetService("Players")
                    targetPlayer = players:FindFirstChild(targetUsername)
                    players.LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
                end
            end
        else
            _G.onu = false
        end
    end)
    
    TeleportsSection:NewButton("Fling Player", "Flings Player", function(txt)
        local Settings = {
           Target = _G.txte -- Target Name (Not display name)
        }
        
        -- Objects
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        
        local LocalPlayer = Players.LocalPlayer
        local Target = Players:FindFirstChild(Settings.Target)
        
        local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity.AngularVelocity = Vector3.new(10^6, 10^6, 10^6)
        BodyAngularVelocity.MaxTorque = Vector3.new(10^6, 10^6, 10^6)
        BodyAngularVelocity.P = 10^6
        
        -- Start
        if not Target then return end
        BodyAngularVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        
        while Target.Character.HumanoidRootPart and LocalPlayer.Character.HumanoidRootPart do
           RunService.RenderStepped:Wait()
           LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation
           LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new()
        end
           
        BodyAngularVelocity.Parent = nil
    end)

end
