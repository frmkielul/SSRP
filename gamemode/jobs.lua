-- Either Pedro is a shitty coder or Garry is a shitty coder
-- becaucse this team system is garbage

-- 8/24/15 - Salary complete

team.SetUp( 1, "Citizen", Color( 0, 255, 0 ) )
team.SetUp( 2, "Police Officer", Color( 51, 102, 153 ) )
team.SetUp( 3, "SWAT Officer", Color( 102, 0, 153 ) )
team.SetUp( 4, "Chief of Police", Color( 0, 0, 255 ) )
team.SetUp( 5, "Firefighter", Color( 255, 102, 0 ) )
team.SetUp( 6, "Medic", Color( 255, 0, 128 ) )
team.SetUp( 7, "Mayor", Color( 255, 0, 0 ) )
team.SetUp( 8, "Secret Service", Color( 0, 0, 0 ) )

local Citizen = {}
	Citizen.DisplayName			= "Citizen"

	Citizen.WalkSpeed			= 200	-- How fast to move when not running
	Citizen.RunSpeed			= 400		-- How fast to move when running
	Citizen.CrouchedWalkSpeed	= 0.3		-- Multiply move speed by this when crouching
	Citizen.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
	Citizen.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Citizen.JumpPower			= 200		-- How powerful our jump should be
	Citizen.CanUseFlashlight	= true		-- Can we use the flashlight
	Citizen.MaxHealth			= 100		-- Max health we can have
	Citizen.StartHealth			= 100		-- How much health we start with
	Citizen.StartArmor			= 0			-- How much armour we start with
	Citizen.DropWeaponOnDie		= true		-- Do we drop our weapon when we die
	Citizen.TeammateNoCollide	= false		-- Do we collide with teammates or run straight through them
	Citizen.AvoidPlayers		= true		-- Automatically swerves around other players
	Citizen.UseVMHands			= true		-- Uses viewmodel hands
	Citizen.Salary				= 20
	Citizen.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Citizen.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Citizen.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Citizen.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_citizen", Citizen, "player_default")

local Police = {}
	Police.DisplayName			= "Police"

	Police.WalkSpeed			= 200	-- How fast to move when not running
	Police.RunSpeed				= 400		-- How fast to move when running
	Police.CrouchedWalkSpeed	= 0.3		-- Multiply move speed by this when crouching
	Police.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
	Police.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Police.JumpPower			= 200		-- How powerful our jump should be
	Police.CanUseFlashlight		= true		-- Can we use the flashlight
	Police.MaxHealth			= 100		-- Max health we can have
	Police.StartHealth			= 100		-- How much health we start with
	Police.StartArmor			= 100			-- How much armour we start with
	Police.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	Police.TeammateNoCollide	= true		-- Do we collide with teammates or run straight through them
	Police.AvoidPlayers			= true		-- Automatically swerves around other players
	Police.UseVMHands			= true		-- Uses viewmodel hands
	Police.Salary				= 100	
	Police.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Police.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Police.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Police.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_police", Police, "player_default")

local SWAT = {}
	SWAT.DisplayName			= "SWAT"

	SWAT.WalkSpeed				= 200	-- How fast to move when not running
	SWAT.RunSpeed				= 400		-- How fast to move when running
	SWAT.CrouchedWalkSpeed		= 0.3		-- Multiply move speed by this when crouching
	SWAT.DuckSpeed				= 0.3		-- How fast to go from not ducking, to ducking
	SWAT.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	SWAT.JumpPower				= 200		-- How powerful our jump should be
	SWAT.CanUseFlashlight		= true		-- Can we use the flashlight
	SWAT.MaxHealth				= 100		-- Max health we can have
	SWAT.StartHealth			= 100		-- How much health we start with
	SWAT.StartArmor				= 100			-- How much armour we start with
	SWAT.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	SWAT.TeammateNoCollide		= true		-- Do we collide with teammates or run straight through them
	SWAT.AvoidPlayers			= true		-- Automatically swerves around other players
	SWAT.UseVMHands				= true		-- Uses viewmodel hands
	SWAT.Salary					= 230
	SWAT.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	SWAT.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	SWAT.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(SWAT.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_SWAT", SWAT, "player_default")

local Chief = {}
	Chief.DisplayName			= "Chief of Police"

	Chief.WalkSpeed				= 200	-- How fast to move when not running
	Chief.RunSpeed				= 400		-- How fast to move when running
	Chief.CrouchedWalkSpeed		= 0.3		-- Multiply move speed by this when crouching
	Chief.DuckSpeed				= 0.3		-- How fast to go from not ducking, to ducking
	Chief.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Chief.JumpPower				= 200		-- How powerful our jump should be
	Chief.CanUseFlashlight		= true		-- Can we use the flashlight
	Chief.MaxHealth				= 100		-- Max health we can have
	Chief.StartHealth			= 100		-- How much health we start with
	Chief.StartArmor			= 100			-- How much armour we start with
	Chief.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	Chief.TeammateNoCollide		= true		-- Do we collide with teammates or run straight through them
	Chief.AvoidPlayers			= true		-- Automatically swerves around other players
	Chief.UseVMHands			= true		-- Uses viewmodel hands
	Chief.Salary				= 300
	Chief.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Chief.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Chief.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Chief.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_chief", Chief, "player_default")

local Firefighter = {}
	Firefighter.DisplayName			= "Firefighter"

	Firefighter.WalkSpeed			= 200	-- How fast to move when not running
	Firefighter.RunSpeed			= 400		-- How fast to move when running
	Firefighter.CrouchedWalkSpeed	= 0.3		-- Multiply move speed by this when crouching
	Firefighter.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
	Firefighter.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Firefighter.JumpPower			= 200		-- How powerful our jump should be
	Firefighter.CanUseFlashlight	= true		-- Can we use the flashlight
	Firefighter.MaxHealth			= 100		-- Max health we can have
	Firefighter.StartHealth			= 100		-- How much health we start with
	Firefighter.StartArmor			= 0			-- How much armour we start with
	Firefighter.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	Firefighter.TeammateNoCollide	= true		-- Do we collide with teammates or run straight through them
	Firefighter.AvoidPlayers		= true		-- Automatically swerves around other players
	Firefighter.UseVMHands			= true		-- Uses viewmodel hands
	Firefighter.Salary			= 85
	Firefighter.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Firefighter.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Firefighter.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Firefighter.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_fireman", Firefighter, "player_default")

local Medic = {}
	Medic.DisplayName			= "Medic"

	Medic.WalkSpeed				= 200	-- How fast to move when not running
	Medic.RunSpeed				= 400		-- How fast to move when running
	Medic.CrouchedWalkSpeed		= 0.3		-- Multiply move speed by this when crouching
	Medic.DuckSpeed				= 0.3		-- How fast to go from not ducking, to ducking
	Medic.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Medic.JumpPower				= 200		-- How powerful our jump should be
	Medic.CanUseFlashlight		= true		-- Can we use the flashlight
	Medic.MaxHealth				= 100		-- Max health we can have
	Medic.StartHealth			= 100		-- How much health we start with
	Medic.StartArmor			= 0			-- How much armour we start with
	Medic.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	Medic.TeammateNoCollide		= true		-- Do we collide with teammates or run straight through them
	Medic.AvoidPlayers			= true		-- Automatically swerves around other players
	Medic.UseVMHands			= true		-- Uses viewmodel hands
	Medic.Salary				= 90
	Medic.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Police.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Police.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Police.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_medic", Medic, "player_default")

local Mayor = {}
	Mayor.DisplayName			= "Mayor"

	Mayor.WalkSpeed				= 200	-- How fast to move when not running
	Mayor.RunSpeed				= 400		-- How fast to move when running
	Mayor.CrouchedWalkSpeed		= 0.3		-- Multiply move speed by this when crouching
	Mayor.DuckSpeed				= 0.3		-- How fast to go from not ducking, to ducking
	Mayor.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	Mayor.JumpPower				= 200		-- How powerful our jump should be
	Mayor.CanUseFlashlight		= true		-- Can we use the flashlight
	Mayor.MaxHealth				= 100		-- Max health we can have
	Mayor.StartHealth			= 100		-- How much health we start with
	Mayor.StartArmor			= 0			-- How much armour we start with
	Mayor.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	Mayor.TeammateNoCollide		= true		-- Do we collide with teammates or run straight through them
	Mayor.AvoidPlayers			= true		-- Automatically swerves around other players
	Mayor.UseVMHands			= true		-- Uses viewmodel hands
	Mayor.Salary				= 500	
	Mayor.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	Mayor.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	Mayor.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(Mayor.Salary)
		end)
	end
	
player_manager.RegisterClass( "job_mayor", Mayor, "player_default")

local SecretService = {}
	SecretService.DisplayName			= "Secret Service"

	SecretService.WalkSpeed				= 200	-- How fast to move when not running
	SecretService.RunSpeed				= 400		-- How fast to move when running
	SecretService.CrouchedWalkSpeed		= 0.3		-- Multiply move speed by this when crouching
	SecretService.DuckSpeed				= 0.3		-- How fast to go from not ducking, to ducking
	SecretService.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
	SecretService.JumpPower				= 200		-- How powerful our jump should be
	SecretService.CanUseFlashlight		= true		-- Can we use the flashlight
	SecretService.MaxHealth				= 100		-- Max health we can have
	SecretService.StartHealth			= 100		-- How much health we start with
	SecretService.StartArmor			= 100			-- How much armour we start with
	SecretService.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
	SecretService.TeammateNoCollide		= true		-- Do we collide with teammates or run straight through them
	SecretService.AvoidPlayers			= true		-- Automatically swerves around other players
	SecretService.UseVMHands			= true		-- Uses viewmodel hands
	SecretService.Salary				= 500	
	SecretService.Loadout = function (tbl)
		tbl.Player:StripWeapons()
		tbl.Player:Give( "weapon_physgun" )
		tbl.Player:Give( "weapon_physcannon" )
		tbl.Player:Give( "gmod_tool" )
		tbl.Player:Give( "weapon_ssrp_fists" )
	end
	SecretService.Model = function (tbl)
		local cl_playermodel = tbl.Player:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		util.PrecacheModel( modelname )
		tbl.Player:SetModel( modelname )
	end
	SecretService.Payout = function (tbl)
		timer.Create( "payout", 300, 0, function() 
			tbl.Player:AddMoney(SecretService.Salary)
		end)
	end
player_manager.RegisterClass( "job_secretservice", SecretService, "player_default")