-- SH_NPCS.LUA

local NPC_DATABASE = {}

function RegisterNPC ( _npc ) 
	table.insert(NPC_DATABASE, npc)
	
	--[[local NPC = ents.Create( "npc_citizen" )

	if !isValid( NPC ) then return end

	NPC:SetModel( npc.Model )
	NPC:SetPos( npc.Position )
	--NPC:SetAngles( npc.Angles )
	NPC:Spawn()]]
	
	SSRP.AddLog("[NPC] Name: " .. _npc.Name .. " ID: " .. _npc.ID .. " registered successfully.")
end