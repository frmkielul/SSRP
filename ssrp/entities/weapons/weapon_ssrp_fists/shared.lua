SWEP.PrintName			= "Fists"			
SWEP.Author			= "Frank Paschen"
SWEP.Instructions		= "Left click to lock, right click to unlock."

SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 3
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

-- Defining these here should work fine
local ply = self.Owner
local eyetrace = self.Owner:GetEyeTrace().Entity
local MAX_DISTANCE_FROM_DOOR = 120

function SWEP:PrimaryAttack()
	if (ply:GetPos():Distance(eyetrace:GetPos()) > MAX_DISTANCE_FROM_DOOR) then
		return
	else
		ply:ConCommand("lockdoor")
	end
end
	
function SWEP:SecondaryAttack()
	if (ply:GetPos():Distance(eyetrace:GetPos()) > MAX_DISTANCE_FROM_DOOR) then
		return
	else
		ply:ConCommand("unlockdoor")
	end
end
