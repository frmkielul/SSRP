AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "jobs.lua" )
AddCSLuaFile( "commands.lua" )

include( "shared.lua" )
include( "jobs.lua" )
--include( "door_functions.lua" )			-- Totally useless
include( "commands.lua" )

-- Properties
include( "sh_properties.lua" )
include( "properties/Genetech.lua" )

-- NPCs
include( "sh_npcs.lua" )
include( "npcs/bank_teller.lua" )

local spawn_positions = {
	Vector(-770.118530, -2009.667603, 140.031250),
	Vector(-769.034729, -2144.532715, 140.031250),
	Vector(-768.023254, -2270.398193, 140.031250),
	Vector(-657.160522, -2269.506104, 140.031250),
	Vector(-646.065979, -2147.530518, 140.031250),
	Vector(-647.149780, -2012.666260, 140.031250),
	Vector(-518.338379, -2011.629272, 140.031250),
	Vector(-517.179871, -2149.494141, 140.031250),
	Vector(-516.241943, -2266.208008, 140.031250),
	Vector(-515.253357, -2389.225098, 140.031250),
	Vector(-401.416412, -2388.309082, 140.031250),
	Vector(-397.427032, -2269.136963, 140.031250),
	Vector(-398.389069, -2149.434326, 140.031250),
}
-- This table and the for loop below it are used to remove Nexus doors
local doors_to_remove_nexus = {
	Vector(-772.36999511719, -1452, 138),
	Vector(-675.63000488281, -1452, 138),
	Vector(-492.36999511719, -1452, 138),
	Vector(-395.63000488281, -1452, 138),
}
for k,v in pairs(ents.GetAll()) do
	for _, l in pairs(doors_to_remove_nexus) do
		if (v:GetPos() == l) then
			v:Remove()
		end
	end
end
RunConsoleCommand("removeprops")

function GM:PlayerInitialSpawn( ply )
	local spawn_index = math.random(13)

	ply:SetTeam( 1 )
	playerJob = "job_citizen"
	player_manager.SetPlayerClass( ply, playerJob)
	player_manager.OnPlayerSpawn( ply )
	ply:SetPos(spawn_positions[spawn_index])
end

function GM:PlayerSpawn( ply )
	if ply:Team() == 1 then
		playerJob = "job_citizen"
	elseif ply:Team() == 2 then
		playerJob = "job_police"
	elseif ply:Team() == 3 then
		playerJob = "job_SWAT"
	elseif ply:Team() == 4 then
		playerJob = "job_chief"
	elseif ply:Team() == 5 then
		playerJob = "job_firefighter"
	elseif ply:Team() == 6 then
		playerJob = "job_medic"
	elseif ply:Team() == 7 then
		playerJob = "job_mayor"
	elseif ply:Team() == 8 then
		playerJob = "job_secretservice"
	else
		playerJob = "job_citizen"
	end
	player_manager.SetPlayerClass( ply, tostring(playerJob))
	player_manager.RunClass( ply, "Loadout")
	player_manager.RunClass( ply, "Model")
	player_manager.RunClass( ply, "Payout")
	player_manager.OnPlayerSpawn( ply )
	ply:SetPos(Vector(-515, -2225,  140))
end

-- "Realistic" fall damage
function GM:GetFallDamage( ply, speed )
	return ( speed / 8.7 )
end