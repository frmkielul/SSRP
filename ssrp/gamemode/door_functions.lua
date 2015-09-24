concommand.Add("doors_openall", function()
	for k,v in pairs(ents.GetAll()) do
		if (v:GetClass() == "func_door" or v:GetClass() == "prop_door_rotating" or v:GetClass() == "func_door_rotating") then
			v:Fire("unlock", "", 0)
			v:Fire("Open", "", 0)
		end
	end
end)
concommand.Add("doors_closeall", function()
	for k,v in pairs(ents.GetAll()) do
		if (v:GetClass() == "func_door" or v:GetClass() == "prop_door_rotating" or v:GetClass() == "func_door_rotating") then
			v:Fire("Open", "", 0)
			v:Fire("Close", "", 0)
		end
	end
end)
concommand.Add("doors_lockall", function()
	for k,v in pairs(ents.GetAll()) do
		if (v:GetClass() == "func_door" or v:GetClass() == "prop_door_rotating" or v:GetClass() == "func_door_rotating") then
			v:Fire("Close", "", 0)
			v:Fire("lock", "", 0)
		end
	end
end)