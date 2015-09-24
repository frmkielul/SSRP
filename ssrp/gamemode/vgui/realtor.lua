-- Realtor (property) NPC VGUI
-- By Francis Paschenate-Love

local realtor = vgui.Create( "DFrame" )
realtor:SetSize( ScrW() * 0.312, ScrH() * 0.416 ) 
local Size_X, Size_Y = realtor:GetSize( )
realtor:SetPos( ( ScrW() / 2 ) - (Size_X / 2), ( ScrH() / 2 ) - (Size_Y / 2 ) )		-- Holy shit can't believe I made that
realtor:SetTitle( "Realtor" ) 
realtor:SetVisible( true ) 
realtor:SetDraggable( false ) 
realtor:ShowCloseButton( true ) 
--realtor:MakePopup()		commented because i cant code 4 shit