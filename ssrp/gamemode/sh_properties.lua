-- SH_PROPERTIES.LUA

-- Issue: Player cannot own more than 1 property at a time (networkedint)

-- Not actually a database, just a structured table
-- lua ur shit m8
local PROPERTY_DATABASE = {}

doors_types = {
	"func_door",
	"func_door_rotating",
	"prop_door_rotating",
}
-- Called by RegisterProperty() after each property is registered
function Property_Init()
	for k,v in pairs(PROPERTY_DATABASE) do
		SSRP.AddLog("[PROPERTY] Name: " .. PROPERTY_DATABASE[k].Name .. " ID: " .. PROPERTY_DATABASE[k].ID .. " registered successfully.")
	end
end
-- Called by each property individually. Loads property IDs into the database
function RegisterProperty( _property )
	table.insert(PROPERTY_DATABASE, _property)
	Property_Init()
end
-- Function that handles purchasing a property
function BuyProperty( ply, property_id )
	local property_cost = PROPERTY_DATABASE[property_id].Price
	
	if PROPERTY_DATABASE[property_id].Owner == ply:SteamID( ) then
		ply:ChatPrint( "You already own this property!" )
		return false
	elseif PROPERTY_DATABASE[property_id].Owner ~= nil then
		ply:ChatPrint("Property already owned!")
		return false
	else
		-- If they don't already own it, and it's not already owned, test if they can afford it
		if !ply:CanAfford(property_cost) then
			ply:ChatPrint("You can not afford to buy this property!")
			-- If they can't afford, return false.
			return false;
		else
			-- Take money from bank account
			ply:TakeMoney(property_cost)
			-- Set their SteamID as the owner
			PROPERTY_DATABASE[property_id].Owner = ply:SteamID( )
			-- Set 'property-owned' NWInt to the property id
			ply:SetNetworkedInt( "property_owned", property_id )
			-- Log it to the console
			SSRP.AddLog("[SSRP-DEV] NetworkedInt 'property_owned' set to " .. property_id .. " for " .. ply:Nick())
			-- Print it to their chat
			ply:ChatPrint("Property purchased: " .. PROPERTY_DATABASE[property_id].Name .. "!")
			-- Hooray! Return true.
			return true
		end
	end
end
-- Function that handles selling a property
function SellProperty( ply, property_id )
	if ply:GetNetworkedInt( "property_owned" ) == property_id then
		ply:SetNetworkedInt( "property_owned", 0)
		PROPERTY_DATABASE[property_id].Owner = nil
		-- give them 40% back
		ply:AddMoney(PROPERTY_DATABASE[property_id].Price*0.40)
		
		for k,v in pairs(PROPERTY_DATABASE) do
			for _,d in pairs(PROPERTY_DATABASE[property_id].Doors) do
				for _,e in pairs(ents.GetAll()) do
					if e:GetPos() == d then
						e:Fire("Unlock", "", 0)
					end
				end
			end
		end
		SSRP.AddLog("[SSRP-DEV] All doors unlocked in property " .. PROPERTY_DATABASE[property_id].Name .. ". Reason: Sold")
		ply:ChatPrint("Property sold: " .. PROPERTY_DATABASE[property_id].Name .. "!")
		return true
	else
		ply:ChatPrint( "You do not own that property!" )
		return false
	end
end
-- Called by the hands SWEP. Locks the door at eyetrace
function player_lock( ply )
	local door_ateye = ply:GetEyeTrace().Entity
	local door_ateye_position = door_ateye:GetPos()
	
	for k,v in pairs(PROPERTY_DATABASE) do
		for _,d in pairs(PROPERTY_DATABASE[k].Doors) do
			if door_ateye_position == d and PROPERTY_DATABASE[k].Owner == ply:SteamID( ) then
				door_ateye:Fire("Lock", "", 0)
				sound.Play( "doors/door_latch1.wav", door_ateye_position)
				return true
			end
		end
	end
end
-- Called by the hands SWEP. Unlocks the door at eyetrace 
function player_unlock( ply )
	local door_ateye = ply:GetEyeTrace().Entity
	local door_ateye_position = door_ateye:GetPos()
	for k,v in pairs(PROPERTY_DATABASE) do
		for _,d in pairs(PROPERTY_DATABASE[k].Doors) do
			if door_ateye_position == d and PROPERTY_DATABASE[k].Owner == ply:SteamID( ) then
				door_ateye:Fire("Unlock", "", 0)
				sound.Play( "doors/latchunlocked1.wav", door_ateye_position)
				return true
			end
		end
	end
end
-- check if ent is a door, return true or false
function IsDoor( ent )
	for k,v in pairs(door_types) do
		if ent:GetType() == v then
			return true
		end
	end
	
	return false
end
-- Retrieves the owner of a door
function get_owner( _propertyid )
	return PROPERTY_DATABASE[_propertyid].Owner
end
-- Returns the property that contains the door (takes entity, returns int)
function get_door_property( ent )
	for k,v in pairs(PROPERTY_DATABASE) do
		for _,d in pairs(PROPERTY_DATABASE[k].Doors) do
			if ent:GetPos() == d then
				return PROPERTY_DATABASE[k].ID
			end
		end
	end
end

-- Door functions 
--[[
ent:Fire("Open", "", 0)
ent:Fire("Close", "", 0)
ent:Fire("Toggle", "", 0)
ent:Fire("Lock", "", 0)
ent:Fire("Unlock", "", 0)
]]--