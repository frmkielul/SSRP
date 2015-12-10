-- most of these are for debug

concommand.Add("promote", function( ply, cmd, args )
	local rank = tonumber(args[1])
	ply:SetTeam(rank)
	ply:Kill()	-- for loadouts
end)
concommand.Add("addmoney", function(ply, cmd, args)
	local amt = tonumber(args[1])
	if !IsValid(ply) or !amt then return end
	ply:AddMoney(amt)
end)
concommand.Add("setmoney", function(ply, cmd, args)
	local amt = tonumber(args[1])
	if !IsValid(ply) or !amt then return end
	ply:SetMoney(amt)
end)
concommand.Add("showeyetrace", function(ply)
	timer.Create("print_eyetrace", 0.1, 0, function() ply:ChatPrint( tostring(ply:GetEyeTrace().Entity) )
	end)
end)
concommand.Add("stopeyetrace", function(ply)
	timer.Pause("print_eyetrace")
	ply:ChatPrint("EyeTrace halted!\n")
end)
--[[concommand.Add("showeyetrace_vector", function( ply )
	ply:ChatPrint( "Vector(" .. tostring(ply:GetEyeTrace().Entity:GetPos().x) .. ", " .. tostring(ply:GetEyeTrace().Entity:GetPos().y) .. ", " .. tostring(ply:GetEyeTrace().Entity:GetPos().z) .. ")" ) 
end)]]
concommand.Add("removeprops", function(ply)
	for k,v in pairs(ents.GetAll()) do
		if (v:GetClass() == "prop_physics_multiplayer") then
			v:Remove()
		end
	end
	SSRP.AddLog("Removing all physics props!")
end)
concommand.Add("property_buy", function(ply, cmd, args)
	local property = tonumber(args[1])
	BuyProperty( ply, property )
end)
concommand.Add("property_sell", function(ply, cmd, args)
	local property = tonumber(args[1])
	SellProperty( ply, property )
end)
concommand.Add("lockdoor", function(ply)
	player_lock( ply )
end)
concommand.Add("unlockdoor", function(ply)
	player_unlock( ply )
end)
concommand.Add("fetch_job_from_table", function(ply)
	ply:ChatPrint(SSRP.GetJobFromTable( ply ))
end)